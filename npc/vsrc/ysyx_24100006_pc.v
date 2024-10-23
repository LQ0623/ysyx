module ysyx_24100006_pc(
    input clk,
    input reset,
    input[31:0] npc,
    output reg [31:0] pc
);

    always @(posedge clk) begin
        if(reset)begin
            pc <= 32'h80000000;
        end else begin
            pc <= npc;
        end
    end

endmodule
