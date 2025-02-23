/**
    保存取值之后的临时信息
*/
module IFU(
    input clk,
    input IFW,
    input [31:0] insIn,
    output [31:0] insOut
);

    always @(posedge clk) begin
        if(IFW == 1)begin
            insOut <= insIn;
        end
    end

endmodule
