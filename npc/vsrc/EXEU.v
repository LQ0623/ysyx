/**
    保存EXE级之后的临时信息
*/
module EXEU(
    input clk,
    input EXEW,
    input [31:0] insIn,
    output [31:0] insOut
);

    always @(posedge clk) begin
        if(EXEW == 1)begin
            insOut <= insIn;
        end
    end

endmodule
