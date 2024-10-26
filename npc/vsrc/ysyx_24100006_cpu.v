// import "DPI-C" function void npc_trap ();
module ysyx_24100006_cpu(
	input clk,
	input reset,
	output [31:0] x_result,
	output [31:0] x_pc
);
	wire [31:0]pc;
	wire [31:0]npc;
	ysyx_24100006_pc PC(.clk(clk),.reset(reset),.npc(npc),.pc(pc));

	wire [31:0] instruction;
	ysyx_24100006_im IM(.pc(pc),.instruction(instruction));

	wire [3:0] aluop;
	wire Reg_Write,Mem_Write;
	wire [1:0] Reg_Write_RD;
	wire [3:0] Jump;
	wire [2:0] Imm_Type;
	wire AluSrcA,AluSrcB;

	ysyx_24100006_controller controller(.opcode(instruction[6:0]),.funct3(instruction[14:12]),.funct7(instruction[31:25]),
										.aluop(aluop),.Reg_Write(Reg_Write),.Reg_Write_RD(Reg_Write_RD),.Mem_Write(Mem_Write),
										.Jump(Jump),.Imm_Type(Imm_Type),.AluSrcA(AluSrcA),.AluSrcB(AluSrcB));

	wire [4:0] 	rs;
	wire [4:0] 	rt;
	/* verilator lint_off UNDRIVEN */
	/* verilator lint_off UNUSEDSIGNAL */
	wire [4:0] 	rd;
	wire [4:0] 	waddr_reg;
	wire [31:0] wdata_reg;
	wire [31:0] rs1_data;
	wire [31:0] rs2_data;
	wire [31:0] alu_result;
	wire [31:0] sext_imm;
	wire of,zf,cf;
	/* verilator lint_off UNDRIVEN */
	/* verilator lint_off UNUSEDSIGNAL */
	
	assign waddr_reg 	= instruction[11:7];
	assign rs 			= instruction[19:15];
	assign rt 			= instruction[24:20];

	// 选择写入寄存器的内容
	ysyx_24100006_MuxKey#(3,2,32) reg_write_data_mux(wdata_reg,Reg_Write_RD,{
		2'b00,sext_imm,
		2'b01,alu_result,
		2'b10,(pc+4)
	});

	ysyx_24100006_RegisterFile registerfile(.clk(clk),.wdata(wdata_reg),.waddr(waddr_reg),.wen(Reg_Write),
											.rs1(rs),.rs2(rt),.rs1_data(rs1_data),.rs2_data(rs2_data));
	
	
	ysyx_24100006_imm_sext imm_sext(.inst(instruction),.Imm_Type(Imm_Type),.sext_imm(sext_imm));
	
	wire [31:0] alu_a_data,alu_b_data;

	// 选择进入加法器的内容
	ysyx_24100006_MuxKey#(2,1,32) alu_a_data_mux(alu_a_data,AluSrcA,{
		1'b0,rs1_data,
		1'b1,pc
	});
	ysyx_24100006_MuxKey#(2,1,32) alu_b_data_mux(alu_b_data,AluSrcB,{
		1'b0,rs2_data,
		1'b1,sext_imm
	});

	ysyx_24100006_alu alu(.rs_data(alu_a_data),.aluop(aluop),.rt_data(alu_b_data),.result(alu_result),.of(of),.cf(cf),.zf(zf));
	
	// 这里需要修改，不一定写入的内容就是rs_data
	ysyx_24100006_mem mem(.clk(clk),.Mem_Write(Mem_Write),.waddr(alu_result),.wdata(rs2_data));

	// 下一条指令怎么跳转
	ysyx_24100006_npc NPC(.pc(pc),.Skip_mode(Jump),.sext_imm(sext_imm),.rs_data(rs1_data),.zf(zf),.npc(npc));

	assign x_pc 		= pc;
	assign x_result 	= alu_result;
	
	// always@(*)begin
	// 	if(instruction[6:0] == 7'b1110011)begin
	// 		npc_trap();
	// 	end
	// end

	always @(posedge clk) begin
		$display("instruction_opcode is %x\n",instruction[6:0]);
	end

endmodule
