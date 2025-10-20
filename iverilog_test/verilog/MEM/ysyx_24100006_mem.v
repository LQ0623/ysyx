/**
    统一的 AXI-Lite/简化AXI 存储器
    - 仅在 __ICARUS__ 下使用纯 Verilog 行为内存 + $readmemh
    - 其余情况保持你原来的 DPI-C 接口（pmem_read/pmem_write）
    - 端口列表、信号名、握手接口 与原文件保持一致
*/
`timescale 1ns/1ps
`default_nettype none

module ysyx_24100006_mem(
    input               clk,
    input               reset,

    // axi 写入和读取地址
    input  [31:0]       axi_araddr,
    input  [31:0]       axi_awaddr,
    // axi 写入数据和写入使用的掩码
    input  [31:0]       axi_wdata,
    input  [3:0]        axi_wstrb,

    // axi控制信号
    // read addr
    input               axi_arvalid,
    output reg          axi_arready,
    // read data
    input               axi_rready,
    output reg          axi_rvalid,
    // write addr
    input               axi_awvalid,
    output reg          axi_awready,
    // write data
    input               axi_wvalid,
    output reg          axi_wready,
    // response
    input               axi_bready,
    output reg          axi_bvalid,
    output reg  [1:0]   axi_bresp,

    // axi 读取的回应
    output reg  [1:0]   axi_rresp,
    output reg  [31:0]  axi_rdata,

    // 新增信号
    input   [7:0]       axi_arlen,
    input   [2:0]       axi_arsize,
    output reg          axi_rlast,
    input   [7:0]       axi_awlen,
    input   [2:0]       axi_awsize,
    input               axi_wlast
);

`ifdef __ICARUS__
    // ------------------------------
    // Icarus: 纯 Verilog 行为内存
    // ------------------------------
    localparam BASE_ADDR = 32'h8000_0000;
    localparam MEM_BYTES = 16*1024*1024;   // 16MB
    reg [7:0] mem [0:MEM_BYTES-1];         // 字节寻址

    // 运行时通过 +img=xxx.hex 指定镜像；默认 "program.hex"
    string IMG;
    initial begin
        if (!$value$plusargs("img=%s", IMG)) IMG = "program.hex";
        $display("[mem] loading image: %0s", IMG);
        // 注意：objcopy 需 --adjust-vma -0x80000000 让地址从 0 开始
        $readmemh(IMG, mem);
    end

    function [31:0] load32(input [31:0] addr);
        reg [31:0] idx;
        begin
            load32 = 32'h0;
            if (addr >= BASE_ADDR && addr < BASE_ADDR + MEM_BYTES - 3) begin
                idx    = addr - BASE_ADDR;
                // 小端
                load32 = {mem[idx+3], mem[idx+2], mem[idx+1], mem[idx+0]};
            end
        end
    endfunction

    task store32(input [31:0] addr, input [31:0] data, input [3:0] strb);
        reg [31:0] idx;
        begin
            if (addr >= BASE_ADDR && addr < BASE_ADDR + MEM_BYTES - 3) begin
                idx = addr - BASE_ADDR;
                if (strb[0]) mem[idx+0] = data[7:0];
                if (strb[1]) mem[idx+1] = data[15:8];
                if (strb[2]) mem[idx+2] = data[23:16];
                if (strb[3]) mem[idx+3] = data[31:24];
            end
        end
    endtask
`else
    // ------------------------------
    // Verilator: 保留原 DPI-C
    // ------------------------------
    import "DPI-C" function int  pmem_read (input int raddr);
    import "DPI-C" function void pmem_write(input int waddr, input int wdata, input byte wmask);
`endif

    // ------------------------------
    // 状态机（读/写突发简化实现）
    // ------------------------------
    localparam S_IDLE   = 3'd0,
               S_RDATA  = 3'd1,
               S_WDATA  = 3'd2,
               S_BRESP  = 3'd3;

    reg [2:0]  state;

    // 读突发
    reg [31:0] raddr_q;
    reg [7:0]  rlen_q;
    reg [7:0]  rcnt_q;
    reg [2:0]  rsize_q;

    // 写突发
    reg [31:0] waddr_q;
    reg [7:0]  wlen_q;
    reg [7:0]  wcnt_q;
    reg [2:0]  wsize_q;

    // 绝大多数场景为 4B beat（size=2），简单实现：每拍递增 4
    wire [31:0] INC = 32'd4;

    // 复位
    always @(posedge clk) begin
        if (reset) begin
            state       <= S_IDLE;

            axi_arready <= 1'b0;
            axi_awready <= 1'b0;
            axi_wready  <= 1'b0;

            axi_rvalid  <= 1'b0;
            axi_rlast   <= 1'b0;
            axi_rdata   <= 32'h0;
            axi_rresp   <= 2'b00;

            axi_bvalid  <= 1'b0;
            axi_bresp   <= 2'b00;
        end else begin
            // 默认拉低 ready（在需要时再拉高一个拍）
            axi_arready <= 1'b0;
            axi_awready <= 1'b0;
            axi_wready  <= 1'b0;

            case (state)
            // ------------------ 空闲：仲裁 AR > AW ------------------
            S_IDLE: begin
                axi_rlast <= 1'b0;

                if (axi_arvalid) begin
                    // 接受读地址
                    axi_arready <= 1'b1;

                    raddr_q <= axi_araddr;
                    rlen_q  <= axi_arlen;
                    rcnt_q  <= 8'd0;
                    rsize_q <= axi_arsize;

                    // 首个 beat 立即准备
`ifdef __ICARUS__
                    axi_rdata <= load32(axi_araddr);
`else
                    axi_rdata <= pmem_read(axi_araddr);
`endif
                    axi_rresp <= 2'b00;
                    axi_rvalid<= 1'b1;
                    axi_rlast <= (axi_arlen == 8'd0);

                    state     <= S_RDATA;

                end else if (axi_awvalid) begin
                    // 接受写地址
                    axi_awready <= 1'b1;

                    waddr_q <= axi_awaddr;
                    wlen_q  <= axi_awlen;
                    wcnt_q  <= 8'd0;
                    wsize_q <= axi_awsize;

                    state   <= S_WDATA;
                end
            end

            // ------------------ 读数据通道 ------------------
            S_RDATA: begin
                if (axi_rvalid && axi_rready) begin
                    // 完成当前 beat
                    if (rcnt_q == rlen_q) begin
                        // 最后一个 beat 结束
                        axi_rvalid <= 1'b0;
                        axi_rlast  <= 1'b0;
                        state      <= S_IDLE;
                    end else begin
                        rcnt_q  <= rcnt_q + 1'b1;
                        raddr_q <= raddr_q + INC;

`ifdef __ICARUS__
                        axi_rdata <= load32(raddr_q + INC);
`else
                        axi_rdata <= pmem_read(raddr_q + INC);
`endif
                        axi_rlast <= ((rcnt_q + 1'b1) == rlen_q);
                    end
                end
            end

            // ------------------ 写数据通道 ------------------
            S_WDATA: begin
                axi_wready <= 1'b1;
                if (axi_wvalid && axi_wready) begin
`ifdef __ICARUS__
                    store32(waddr_q, axi_wdata, axi_wstrb);
`else
                    pmem_write(waddr_q, axi_wdata, {4'b0, axi_wstrb});
`endif
                    if (wcnt_q == wlen_q || axi_wlast) begin
                        // 写突发完成，发写响应
                        axi_wready <= 1'b0;
                        axi_bvalid <= 1'b1;
                        axi_bresp  <= 2'b00;
                        state      <= S_BRESP;
                    end else begin
                        wcnt_q  <= wcnt_q + 1'b1;
                        waddr_q <= waddr_q + INC;
                    end
                end
            end

            // ------------------ 写响应 ------------------
            S_BRESP: begin
                if (axi_bvalid && axi_bready) begin
                    axi_bvalid <= 1'b0;
                    state      <= S_IDLE;
                end
            end

            default: state <= S_IDLE;
            endcase
        end
    end

endmodule

`default_nettype wire
