// 线性反馈移位寄存器模块
module ysyx_24100006_lfsr #(
    parameter WIDTH = 16
)(
    input clk,
    input reset,
    output reg [WIDTH-1:0] rnd
);

    // 16-bit最大长度LFSR
    always @(posedge clk) begin
        if(reset) begin
            rnd <= 16'hACE1; // 初始种子值
        end else begin
            rnd <= {rnd[14:0], rnd[15] ^ rnd[13] ^ rnd[12] ^ rnd[10]};
        end
    end

endmodule