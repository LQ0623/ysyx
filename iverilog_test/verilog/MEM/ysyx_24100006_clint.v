`ifndef __ICARUS__
import "DPI-C" function void skip();
`endif
module ysyx_24100006_clint (
    input               clk,
    input               reset,

    // AXI-Lite 接口
    input  [31:0]       axi_araddr,
    input               axi_arvalid,
    output              axi_rvalid,
    output reg [31:0]   axi_rdata
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

    // mtime 计数器
    reg [31:0] mtime_lo, mtime_hi;
    reg carry;
    always @(posedge clk) begin
        if (reset) begin 
            mtime_lo<=0; 
            mtime_hi<=0; 
            carry   <=0;
        end
        else begin
            {carry, mtime_lo} <= mtime_lo + 32'd1;
            if (carry) begin
                mtime_hi <= mtime_hi + 32'd1;
            end
        end
    end

    // AXI 控制信号默认值
    assign axi_rvalid  = (state == S_WAIT_RR);

    // 状态机与数据处理
    always @(posedge clk) begin
        if (reset) begin
            state       <= S_WAIT_ARV;
            axi_rdata   <= 32'b0;
        end else begin
            case (state)
                S_WAIT_ARV: begin
                    if (axi_arvalid) begin
                        state       <= S_WAIT_RR;
                        
                        `ifndef __ICARUS__
                            skip();
                        `endif
                        axi_rdata   <= (state == S_WAIT_ARV && axi_araddr[2] == BASE_ADDR[2]) 
                                    ? mtime_lo 
                                    : mtime_hi;
                    end
                end
                
                S_WAIT_RR: begin
                    state       <= S_WAIT_ARV;
                end
            endcase
        end
    end

endmodule