/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input 				clk,
	input 				reset,
	input [1:0]			sram_read_write,
	// from EXEU
	input [31:0] 		pc_M,
	input [31:0] 		alu_result_M,
	input [31:0] 		sext_imm_M,
	input [31:0] 		rs1_data_M,
    input [31:0] 		rs2_data_M,
	input [31:0] 		rdata_csr_M,

	// from MEM
	input [31:0] 		rdraw,

	// control signal
	input 				irq_M,
	input [7:0] 		irq_no_M,
	input 				Gpr_Write_M,
	input 				Csr_Write_M,
	input [2:0] 		Gpr_Write_RD_M,
	input [1:0] 		Csr_Write_RD_M,
	input 				Mem_Read_M,
	input 				Mem_Write_M,
	input [7:0] 		Mem_WMask_M,
	input [2:0] 		Mem_RMask_M,

	// AXI-Lite接口
    // read_addr
	input 	reg 		axi_arready,
	output 	reg 		axi_arvalid,
    // read data
	input 	reg 		axi_rvalid,
    output 	reg 		axi_rready,
	// write addr
	input 	reg 		axi_awready,
	output 	reg 		axi_awvalid,
	// write data
	input 	reg 		axi_wready,
	output 	reg 		axi_wvalid,
	// response
	input 	reg 		axi_bvalid,
	output 	reg 		axi_bready,


	// 握手机制使用
	input 				exe_valid,
	// 来自WB的流控
	input 				wb_ready,
	output 	reg 		mem_valid,
	output 	reg 		mem_ready,

	// to MEM
	output [31:0] 		mem_addr,
	output [7:0] 		RealMemWmask,

	// to WBU
	output [31:0] 		pc_W,
	output [31:0] 		sext_imm_W,
	output [31:0] 		alu_result_W,
	output [31:0] 		rs1_data_W,
	output [31:0] 		rdata_csr_W,
	output [31:0] 		Mem_rdata_extend,

	// control signal to WBU
	output 				irq_W,
	output [7:0] 		irq_no_W,
	output 				Gpr_Write_W,
	output 				Csr_Write_W,
	output [2:0] 		Gpr_Write_RD_W,
	output [1:0] 		Csr_Write_RD_W
);

	// TAG:也需要使用读写使能来进行状态的转移
	// TAG:读操作、写操作或者不操作内存这三种状态之间的转移的选择是在controller单独拉一条线出来，表示是读操作、写操作还是不操作内存

	reg [31:0] locked_addr;  // 地址锁存
    reg [31:0] locked_data;  // 数据锁存


	// 握手机制
	parameter 	S_IDLE 		= 0, 
				READ_ADDR 	= 1, 
				READ_DATA 	= 2, 
				WRITE_ADDR 	= 3, 
				WRITE_DATA 	= 4, 
				WRITE_RESP 	= 5, 
				S_DELAY 	= 6, 
				S_ACCESS 	= 7;
	reg [2:0] state;

	always @(posedge clk) begin
		if(reset) begin
			// axi 握手信号初始化
			axi_arvalid <= 0;
            axi_awvalid <= 0;
            axi_wvalid <= 0;
            axi_rready <= 0;
            axi_bready <= 0;

			// 模块握手使用
			mem_valid	<= 1'b0;
			mem_ready	<= 1'b1;
			state		<= S_IDLE;
		end else begin
			case(state) 
				S_IDLE: begin
					if(exe_valid && mem_ready) begin
						// 表示现在mem模块正在处理数据，不能接受新的数据
						mem_ready	<= 1'b0;
						// axi 读取
						if(sram_read_write == 2'b01) begin
							// 锁存地址和数据
							locked_addr 	<= alu_result_M;
							locked_data 	<= rs2_data_M;

							// axi握手
							axi_arvalid		<= 1'b1;
							state			<= READ_ADDR;
						end else if(sram_read_write == 2'b10) begin
							// 锁存地址和数据
							locked_addr 	<= alu_result_M;
							locked_data 	<= rs2_data_M;

							// 地址和数据同时发送，这样效率最高
							axi_awvalid		<= 1'b1;
							axi_wvalid		<= 1'b1;
							state			<= WRITE_ADDR;
						end else begin
							locked_addr 	<= 32'h0;
							locked_data 	<= 32'h0;
							state			<= S_DELAY;
						end
					end
				end

				// axi 读地址有效
				READ_ADDR: begin
					if(axi_arready == 1'b1) begin
						axi_arvalid		<= 1'b0;
						axi_rready		<= 1'b1;
						state			<= READ_DATA;
					end
				end
				// axi 读数据有效
				READ_DATA: begin
					if(axi_rvalid == 1'b1) begin
						axi_rready		<= 1'b0;
						state			<= S_DELAY;
					end
				end

				// axi 写使用
				WRITE_ADDR: begin
					if(axi_awready == 1'b1 && axi_wready == 1'b1) begin
						// 因为在MEM的SRAM中，地址和数据是一起将ready置为低的，所以这里还是需要一起无效
						// 若在SRAM中，不一起将ready信号置为低，则还是需要转移到WRITE_DATA状态
						axi_awvalid			<= 1'b0;
						axi_wvalid			<= 1'b0;
						axi_bready			<= 1'b1;
						state				<= WRITE_RESP;
						
						// state				<= WRITE_DATA
					end
				end
				WRITE_DATA: begin
					if(axi_wready == 1'b1) begin
						axi_wvalid			<= 1'b0;
						axi_bready			<= 1'b1;
						state				<= WRITE_RESP;
					end
				end
				WRITE_RESP: begin
					if(axi_bvalid == 1'b1) begin
						axi_bready			<= 1'b0;
						state				<= S_DELAY;
					end
				end
				S_DELAY: begin	// 修改mem_valid信号，用于mem与下一级和上一级模块进行握手
					mem_valid	<= 1'b1;
					// mem_ready	<= 1'b0;
					state		<= S_ACCESS;
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


	wire [31:0] place;

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
	assign mem_addr = locked_addr & (~32'h3);	// 对齐到4字节边界
	assign place = locked_addr - mem_addr;		// 计算实际地址与字节之间的偏移
	assign RealMemWmask = Mem_WMask_M << place;	// 真实的写内存的掩码
	

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