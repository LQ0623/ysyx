/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input clk,
	// from EXEU
	input [31:0]


    input Mem_Write,
    input [7:0] Mem_Wmask,
    input [31:0] rs_data,
    input [31:0] alu_result,
    input Mem_Read,
    input [2:0] Mem_RMask,

    output [31:0] Mem_rdata_extend
);

	// new
	wire [31:0] mem_addr;
	wire [7:0] RealMemWmask;
	wire [31:0] place;
	wire [31:0] rdraw;

    /* 为了对齐地址 */
	assign mem_addr = alu_result & (~32'h3);	// 对齐到4字节边界
	assign place = alu_result - mem_addr;		// 计算实际地址与字节之间的偏移
	assign RealMemWmask = Mem_WMask << place;	// 
	
	// 内存操作
	ysyx_24100006_mem mem(
		.clk(clk),
		.Mem_Write(Mem_Write),
		.Mem_WMask(RealMemWmask),
		.waddr(mem_addr),
		.wdata(rs2_data),
		.Mem_Read(Mem_Read),
		.raddr(mem_addr),
		.rdata(rdraw)
	);

     /**
		写入内存的内容，半字或者一个字
	*/
	wire [31:0] Mem_rdata;
	// rdplace 的计算涉及将读取到的数据 rdraw 按照 place 的值进行右移操作。由于 place 表示的是字节偏移量，而每个字节有8位，所以 place << 3 实际上是将字节偏移量转换为位偏移量（即乘以 8）。这样可以确保数据对齐到正确的位位置。
	assign Mem_rdata = rdraw >> (place << 3);	// 将读取到的数据 rdraw 右移 (place << 3) 位。因为 place 表示字节偏移，乘以 8（即左移3位）得到位偏移量。右移操作可以将数据对齐到正确的位置

	ysyx_24100006_MuxKey#(5,3,32) mem_rdata_extend(Mem_rdata_extend,Mem_RMask,{
		3'b000,{{24{Mem_rdata[7]}},Mem_rdata[7:0]},
		3'b001,{24'b0,Mem_rdata[7:0]},
		3'b010,{{16{Mem_rdata[15]}},Mem_rdata[15:0]},
		3'b011,{16'b0,Mem_rdata[15:0]},
		3'b100,Mem_rdata[31:0]
	});

endmodule