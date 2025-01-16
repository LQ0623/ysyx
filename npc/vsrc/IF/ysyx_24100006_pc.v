/**
	PC模块
*/
module ysyx_24100006_pc(
    input clk,
    input reset,
    input[31:0] npc,
    output[31:0] pc
);
	// always @(npc) begin
	// 	$display("npc is %h\n",npc);
    // end

    ysyx_24100006_Reg #(32,32'h80000000) pc1(
		.clk(clk),
		.rst(reset),
		.din(npc),
		.dout(pc),
		.wen(1'b1)
	);	

endmodule
