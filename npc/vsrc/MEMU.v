/**
    保存MEM级之后的临时信息
*/
module MEMU(
    input clk,
    input MEMW,
    input [31:0] insIn,
    output [31:0] insOut
);

    always @(posedge clk) begin
        if(MEMW == 1)begin
            insOut <= insIn;
        end
    end

endmodule
