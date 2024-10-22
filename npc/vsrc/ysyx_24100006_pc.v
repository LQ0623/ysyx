module ysyx_24100006_pc(
    input clk,
    input reset,
    input[31:0] npc,
    output[31:0] pc;
);

    always @(posedge clk) begin
        if(!reset){
            pc <= 32'h80000000;
        }else{
            pc <= npc;
        }
    end

endmodule
