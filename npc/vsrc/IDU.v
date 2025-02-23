/**
    保存控制信息
*/
module IDU(
    input clk,
    input IDW,
    input [31:0] insIn,
    output [31:0] insOut
);

    always @(posedge clk) begin
        if(IDW == 1)begin
            insOut <= insIn;
        end
    end

endmodule
