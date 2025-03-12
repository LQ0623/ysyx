/**
    写回模块
*/
module ysyx_24100006_wbu(
    input clk,
    input reset,
    input [31:0] pc,
    input [31:0] sext_imm,
    input [31:0] alu_result,
    input [31:0] Mem_rdata_extend,
    input [31:0] rdata_csr,
    input [31:0] rs1_data,

    // control signal
    input irq_W,
    input [7:0] irq_no_W,
    input Gpr_Write,
	input Csr_Write,
    input [2:0] Gpr_Write_RD,
    input [1:0] Csr_Write_RD,

    // 握手机制使用
	input mem_valid,
	output reg wb_ready,

    output irq_WD,
    output [7:0] irq_no_WD,
    output Gpr_Write_WD,
	output Csr_Write_WD,
    output [31:0] wdata_gpr,
    output [31:0] wdata_csr

);
    
    // 握手机制
	parameter S_IDLE = 0, S_WRITE = 1;
	reg state;

    always @(posedge clk) begin
        if(reset) begin
            wb_ready    <= 1'b1;
            state       <= S_IDLE;
        end else begin
            case (state)
                S_IDLE: begin
                    if(mem_valid && wb_ready) begin
                        wb_ready    <= 1'b0;
                        state       <= S_WRITE;
                    end
                end
                S_WRITE: begin
                    wb_ready    <= 1'b1;
                    state       <= S_IDLE;
                end
            endcase
        end
    end


    assign irq_WD       = irq_W;
    assign irq_no_WD    = irq_no_W;
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