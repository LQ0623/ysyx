/**
	PC模块
*/
module ysyx_24100006_pc(
    input clk,
    input reset,
	input PCW,	// 是否更新PC
	input [1:0] Access_Fault,// 是否触发Acess Fault
    input[31:0] npc,
    output[31:0] pc
);
	// always @(npc) begin
	// 	$display("npc is %h\n",npc);
    // end
	wire [31:0] real_npc;

`ifndef YSYXSOC
	ysyx_24100006_MuxKey#(3,2,32) alu_a_data_mux(real_npc,Access_Fault,{
		2'b00,npc,
		2'b01,32'b0,
		2'b10,32'b0
	});

    ysyx_24100006_Reg #(32,32'h80000000) pc1(
		.clk(clk),
		.rst(reset),
		.din(real_npc),
		.dout(pc),
		.wen(PCW)
	);		

`endif

`ifdef YSYXSOC

	// 选择下一条指令的pc地址
	ysyx_24100006_MuxKey#(3,2,32) alu_a_data_mux(real_npc,Access_Fault,{
		2'b00,npc,
		2'b01,32'b0,
		2'b10,32'b0
	});

	ysyx_24100006_Reg #(32,32'h30000000) pc1(
		.clk(clk),
		.rst(reset),
		.din(real_npc),
		.dout(pc),
		.wen(PCW)
	);	

`endif

endmodule
