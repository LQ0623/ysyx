import "DPI-C" function void skip();
module ysyx_24100006_clint (
    input               clk,
    input               reset,

    // AXI-Lite 接口
    input  [31:0]       axi_araddr,
    input               axi_arvalid,
    output              axi_arready,
    input               axi_rready,
    output              axi_rvalid,
    output reg [31:0]   axi_rdata,
    output [1:0]        axi_rresp,
    output              axi_rlast
);

`ifndef NPC
    parameter BASE_ADDR = 32'h0200_0000;  // TIMER 基地址
`else
    parameter BASE_ADDR = 32'ha000_0048;  // NPC 仿真基地址
`endif

    // 状态定义
    localparam S_WAIT_ARV = 1'b0;  // 等待地址有效
    localparam S_WAIT_RR  = 1'b1;  // 等待读取就绪
    
    reg         state;
    reg [63:0]  mtime;

    // mtime 计数器
    always @(posedge clk) begin
        if (reset) mtime <= 64'h0;
        else mtime <= mtime + 1;
    end

    // AXI 控制信号默认值
    assign axi_arready = (state == S_WAIT_ARV);
    assign axi_rvalid  = (state == S_WAIT_RR);

    // 状态机与数据处理
    always @(posedge clk) begin
        if (reset) begin
            state       <= S_WAIT_ARV;
            axi_rdata   <= 32'b0;
        end else begin
            case (state)
                S_WAIT_ARV: begin
                    if (axi_arvalid && axi_arready) begin
                        state       <= S_WAIT_RR;
                        
                        `ifdef VERILATOR_SIM
                            skip();
                        `endif

                        // 根据地址选择数据
                        axi_rdata   <= (axi_araddr == BASE_ADDR) 
                                        ? mtime[31:0] 
                                        : mtime[63:32];
                    end
                end
                
                S_WAIT_RR: begin
                    if (axi_rready && axi_rvalid) begin
                        state       <= S_WAIT_ARV;
                    end
                end
            endcase
        end
    end

    // 移除未使用的写接口信号
    // assign axi_awready = 0;
    // assign axi_wready = 0;
    // assign axi_bvalid = 0;
    // assign axi_bresp = 0;
    assign axi_rresp = 2'b0;
    assign axi_rlast = 1'b1;  // 单次传输始终为1

endmodule