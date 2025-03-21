/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

    input [31:0] 		npc,
	input sram_read_write,
	input Mem_Read_M,
	
	// mem的lfsr延迟
    input [15:0]      	lfsr_out,

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


	// 握手信号
	input 				id_ready,
	output 	reg 		if_valid,

    output 	reg [31:0] 	pc_F,

	// PC更换为NPC的有效信号，本来可以直接使用if_valid的，但是因为访问指令寄存器加入了延时之后，导致取指和pc更新对不上拍
	output 	reg 		PCW
);

	// 因为mem随机延迟的话，这里状态机的状态转移也需要随机起来，后续会使用传入的信号来当作延时
	// 新增延迟计数器
    reg [7:0] mem_delay;
    parameter FIXED_DELAY = 123; // 可配置为5/10/20等

	// LFSR信号
    wire [15:0] lfsr_delay;
    reg [7:0] ar_delay,r_delay;

    // 实例化LFSR
    ysyx_24100006_lfsr lfsr_inst(
        .clk(clk),
        .reset(reset),
        .rnd(lfsr_delay)
    );


	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_DELAY_1 = 2, S_DELAY_2 = 3, S_DELAY_3 = 4, S_DELAY_4 = 5, S_DELAY_5 = 6, S_DELAY_6 = 7, S_DELAY_7 = 8, S_DELAY_8 = 9, S_DELAY_9 = 10, S_AR_DELAY = 11, S_R_DELAY = 12, S_DELAY_12 = 13, S_DELAY_13 = 14, S_DELAY_14 = 15, S_DELAY_15 = 16, S_DELAY_16 = 17, S_DELAY_17 = 18, S_DELAY_18 = 19, S_DELAY_19 = 20, S_WAIT = 21;
	reg [5:0] state;

	always @(posedge clk) begin
		if(reset) begin
			state 			<= S_IDLE;
			if_valid		<= 1'b0;
			PCW				<= 1'b0;
			axi_arvalid 	<= 1'b0;
			axi_awvalid		<= 1'b0;
			axi_wvalid		<= 1'b0;
			axi_bready		<= 1'b0;
			mem_delay		<= 8'b0;
			ar_delay		<= 8'b0;
		end else begin
			case (state)
				S_IDLE: begin
					if(if_valid == 1'b0) begin
						// 后续如果修改的建议：判断是否有指令需要发送，然后在跳转到下一个状态
						ar_delay	<= lfsr_delay[7:0];
						state		<= S_AR_DELAY;
					end
				end
				S_AR_DELAY: begin
					if(ar_delay > 0)begin
						ar_delay	<= ar_delay - 1'b1;
					end else begin
						axi_arvalid	<= 1'b1;
						state		<= S_FETCH;
					end
				end
				S_FETCH: begin
					// 地址握手成功
					if(axi_arready == 1'b1)begin
						axi_arvalid	<= 1'b0;
						r_delay		<= lfsr_delay[7:0];
						state		<= S_R_DELAY;
					end
				end
				S_R_DELAY: begin
					if(r_delay > 0)begin
						r_delay		<= r_delay - 1'b1;
					end else begin
						axi_rready	<= 1'b1;
						state		<= S_DELAY_1;
					end
				end
				S_DELAY_1: begin
					if(axi_rvalid == 1'b1 && axi_rready == 1'b1) begin
						axi_rready	<= 1'b0;
						state		<= S_DELAY_2;
					end
				end
				S_DELAY_2: begin
					if_valid	<= 1'b1;
					state		<= S_DELAY_3;
				end
				S_DELAY_3: begin
					if(if_valid && id_ready) begin
						mem_delay		<= 1;
						if_valid		<= 1'b0;
						state			<= S_DELAY_12;
					end
				end

				// 这是为了测试MEMU的随机延时
				S_DELAY_12: begin
					if(Mem_Read_M == 1'b1) begin
						if(mem_delay > 0)begin
							mem_delay	<= mem_delay - 1'b1;
						end else begin
							mem_delay	<= {4'b0,lfsr_out[3:0]};	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
							state		<= S_DELAY_13;
						end
					end else if(sram_read_write == 1'b1) begin
						if(mem_delay > 0)begin
							mem_delay	<= mem_delay - 1'b1;
						end else begin
							mem_delay	<= {4'b0,lfsr_out[3:0]};	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
							state		<= S_DELAY_16;
						end
					end else begin
						mem_delay		<= 3;
						state			<= S_DELAY_4;
					end
				end

				// 下面三个状态是为了测试MEMU的读功能的延迟
				// 这是为了测试MEMU的随机延时
				S_DELAY_13: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= 1;	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_14;
					end
				end
				// 这是为了测试MEMU的随机延时
				S_DELAY_14: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= lfsr_out[7:0];	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_15;
					end
				end
				// 这是为了测试MEMU的随机延时
				S_DELAY_15: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= 1;	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_9;
					end
				end
				
				// 下面三个状态是为了测试MEMU的写功能的延迟
				// 这是为了测试MEMU的随机延时
				S_DELAY_16: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= 1;	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_17;
					end
				end
				// 这是为了测试MEMU的随机延时
				S_DELAY_17: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= lfsr_out[7:0];	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_18;
					end
				end
				// 这是为了测试MEMU的随机延时
				S_DELAY_18: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= 1;	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_9;
					end
				end
				


				// TODO：S_DELAY_9 是为了测试总线而添加的部分，这个后续可能需要删除，与mem_delay有关的都是因为测试总线来的
				S_DELAY_9: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						mem_delay	<= lfsr_out[7:0];	// TODO:lfsr_out是因为访问mem的SRAM的延迟引入的
						state		<= S_DELAY_4;
					end
				end
				S_DELAY_4: begin
					if(mem_delay > 0)begin
						mem_delay	<= mem_delay - 1'b1;
					end else begin
						state		<= S_DELAY_7;
					end
				end
				// S_DELAY_5: begin
				// 	state		<= S_DELAY_6;
				// end
				// S_DELAY_6: begin
				// 	state		<= S_DELAY_7;
				// end
				S_DELAY_7:begin
					PCW			<= 1'b1;
					state		<= S_DELAY_8;
				end
				S_DELAY_8: begin
					PCW			<= 1'b0;
					state		<= S_WAIT;
				end
				S_WAIT: begin
					state		<= S_IDLE;
				end
			endcase
		end
	end

	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW(PCW),
		.npc(npc),
		.pc(pc_F)
	);

	// wire [31:0] instruction_temp;	// 指令寄存器读出的数据
	// ysyx_24100006_im IM(
	// 	.clk(clk),
	// 	.reset(reset),
	// 	.axi_araddr(pc_F),
	// 	.axi_arvalid(axi_arvalid),
	// 	.axi_rready(axi_rready),
	// 	.axi_arready(axi_arready),
	// 	.axi_rvalid(axi_rvalid),
	// 	.axi_rdata(instruction_temp)
	// );

    // /**
	// 	IR寄存器：保存取出的指令
	// */
	// ysyx_24100006_Reg #(32,32'h00000000) IR(
	// 	.clk(clk),
	// 	.rst(reset),
	// 	.din(instruction_temp),
	// 	.dout(instruction),
	// 	.wen(1'b1)
	// );

	// always @(posedge clk) begin
	// 	$display("pc is %x",pc_F);
	// end

endmodule