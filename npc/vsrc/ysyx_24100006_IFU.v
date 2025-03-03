/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

    input [31:0] npc,
    // control signal from IDU
    input PCW,

    output [31:0] pc,
    output [31:0] instruction   // 读出的指令
);

	wire PCW;			// 控制是否更新PC
	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW(PCW),
		.npc(npc),
		.pc(pc)
	);

	wire [31:0] instruction_temp;	// 指令寄存器读出的数据
	ysyx_24100006_im IM(
		.pc(pc),
		.instruction(instruction_temp)
	);

    /**
		IR寄存器：保存取出的指令
	*/
	ysyx_24100006_Reg #(32,32'h00000000) IR(
		.clk(clk),
		.rst(reset),
		.din(instruction_temp),
		.dout(instruction),
		.wen(1'b1)
	);

endmodule