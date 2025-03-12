/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input clk,
	input reset,
	// from EXEU
	input [31:0] pc_M,
	input [31:0] alu_result_M,
	input [31:0] sext_imm_M,
	input [31:0] rs1_data_M,
    input [31:0] rs2_data_M,
	input [31:0] rdata_csr_M,

	// control signal
	input irq_M,
	input [7:0] irq_no_M,
	input Gpr_Write_M,
	input Csr_Write_M,
	input [2:0] Gpr_Write_RD_M,
	input [1:0] Csr_Write_RD_M,
	input Mem_Read_M,
	input Mem_Write_M,
	input [7:0] Mem_WMask_M,
	input [2:0] Mem_RMask_M,

	// 握手机制使用
	input exe_valid,
	// 来自WB的流控
	input wb_ready,
	output reg mem_valid,
	output reg mem_ready,

	// to WBU
	output [31:0] pc_W,
	output [31:0] sext_imm_W,
	output [31:0] alu_result_W,
	output [31:0] rs1_data_W,
	output [31:0] rdata_csr_W,
	output [31:0] Mem_rdata_extend,

	// control signal to WBU
	output irq_W,
	output [7:0] irq_no_W,
	output Gpr_Write_W,
	output Csr_Write_W,
	output [2:0] Gpr_Write_RD_W,
	output [1:0] Csr_Write_RD_W
);

	// 握手机制
	parameter S_IDLE = 0, S_ACCESS = 1;
	reg state;

	always @(posedge clk) begin
		if(reset) begin
			mem_valid	<= 1'b0;
			mem_ready	<= 1'b1;
			state		<= S_IDLE;
		end else begin
			case(state) 
				S_IDLE: begin
					if(exe_valid && mem_ready) begin
						mem_valid	<= 1'b1;
						mem_ready	<= 1'b0;
						state		<= S_ACCESS;
					end
				end
				S_ACCESS: begin
					if(mem_valid && wb_ready) begin
						mem_valid	<= 1'b0;
						mem_ready	<= 1'b1;
						state		<= S_IDLE;
					end
				end
			endcase
		end
	end


	// new
	wire [31:0] mem_addr;
	wire [7:0] RealMemWmask;
	wire [31:0] place;
	wire [31:0] rdraw;

	assign pc_W				= pc_M;
	assign sext_imm_W		= sext_imm_M;
	assign alu_result_W		= alu_result_M;
	assign rs1_data_W		= rs1_data_M;
	assign rdata_csr_W		= rdata_csr_M;

	// control signal to WBU
	assign irq_W			= irq_M;
	assign irq_no_W			= irq_no_M;
	assign Gpr_Write_W		= Gpr_Write_M;
	assign Csr_Write_W		= Csr_Write_M;
	assign Gpr_Write_RD_W	= Gpr_Write_RD_M;
	assign Csr_Write_RD_W	= Csr_Write_RD_M;



    /* 为了对齐地址 */
	assign mem_addr = alu_result_M & (~32'h3);	// 对齐到4字节边界
	assign place = alu_result_M - mem_addr;		// 计算实际地址与字节之间的偏移
	assign RealMemWmask = Mem_WMask_M << place;	// 
	
	// 内存操作
	ysyx_24100006_mem mem(
		.clk(clk),
		.Mem_Write(Mem_Write_M),
		.Mem_WMask(RealMemWmask),
		.waddr(mem_addr),
		.wdata(rs2_data_M),
		.Mem_Read(Mem_Read_M),
		.raddr(mem_addr),
		.rdata(rdraw)
	);

     /**
		写入内存的内容，半字或者一个字
	*/
	wire [31:0] Mem_rdata;
	// rdplace 的计算涉及将读取到的数据 rdraw 按照 place 的值进行右移操作。由于 place 表示的是字节偏移量，而每个字节有8位，所以 place << 3 实际上是将字节偏移量转换为位偏移量（即乘以 8）。这样可以确保数据对齐到正确的位位置。
	assign Mem_rdata = rdraw >> (place << 3);	// 将读取到的数据 rdraw 右移 (place << 3) 位。因为 place 表示字节偏移，乘以 8（即左移3位）得到位偏移量。右移操作可以将数据对齐到正确的位置

	ysyx_24100006_MuxKey#(5,3,32) mem_rdata_extend(Mem_rdata_extend,Mem_RMask_M,{
		3'b000,{{24{Mem_rdata[7]}},Mem_rdata[7:0]},
		3'b001,{24'b0,Mem_rdata[7:0]},
		3'b010,{{16{Mem_rdata[15]}},Mem_rdata[15:0]},
		3'b011,{16'b0,Mem_rdata[15:0]},
		3'b100,Mem_rdata[31:0]
	});

endmodule