module ysyx_24100006_cpu(
	input clk,
	input reset,
	input [31:0] instruction,
	output [31:0] result,
	output [31:0] x_pc
);
	wire [31:0]pc;
	wire [31:0]npc;
	ysyx_24100006_pc PC(.clk(clk),.reset(reset),.npc(npc),.pc(pc));
	ysyx_24100006_npc NPC(.pc(pc),.npc(npc));


	wire wen;
	assign wen = 0;
	wire [4:0] rs;
	wire [4:0] rt;
	// wire [4:0] rd;
	/* verilator lint_off UNDRIVEN */
	wire [4:0] waddr;
	wire [31:0] wdata;
	wire [31:0] rs1_data;
	/* verilator lint_off UNUSEDSIGNAL */
	wire [31:0] rs2_data;
	
	assign rs = instruction[19:15];
	assign rt = instruction[24:20];
	ysyx_24100006_RegisterFile registerfile(.clk(clk),.reset(reset),.wdata(wdata),.waddr(waddr),.wen(wen),
											.rs1(rs),.rs2(rt),.rs1_data(rs1_data),.rs2_data(rs2_data));
	
	wire [31:0] sext_imm;
	ysyx_24100006_imm_sext imm_sext(.inst(instruction),.sext_imm(sext_imm));
	
	// wire [31:0] result;
	ysyx_24100006_alu alu(.rs_data(rs1_data),.rt_data(sext_imm),.rd_data(result));
	
	assign x_pc = pc;
endmodule
