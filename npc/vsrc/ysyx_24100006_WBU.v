/**
    写回模块
*/
module ysyx_24100006_wbu(
    input [31:0] pc,
    input [31:0] sext_imm,
    input [31:0] alu_result,
    input [31:0] Mem_rdata_extend,
    input [31:0] rdata_csr,
    input [31:0] rs1_data,

    // control signal
    input Gpr_Write,
	input Csr_Write,
    input [2:0] Gpr_Write_RD,
    input [1:0] Csr_Write_RD,

    output Gpr_Write_WD,
	output Csr_Write_WD,
    output [31:0] wdata_gpr,
    output [31:0] wdata_csr

);
    
    assign Gpr_Write_WD = Gpr_Write;
    assign Csr_Write_WD = Csr_Write;

    // 选择写入通用寄存器的内容
	ysyx_24100006_MuxKey#(5,3,32) gpr_write_data_mux(wdata_gpr,Gpr_Write_RD,{
		3'b000, sext_imm,
		3'b001, alu_result,
		3'b010, (pc+4),
		3'b011, Mem_rdata_extend,
		3'b100, rdata_csr
	});


	// 选择写入系统寄存器的内容
	ysyx_24100006_MuxKey#(3,2,32) csr_write_data_mux(wdata_csr,Csr_Write_RD,{
		2'b00,pc,
		2'b01,rs1_data,
		2'b10,(rdata_csr | rs1_data)
	});

endmodule