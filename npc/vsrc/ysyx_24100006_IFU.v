/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

    input [31:0] 		npc,
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

	// 新增AXI信号
	output 	reg	[7:0]	axi_arlen,
	output 	reg	[2:0]	axi_arsize,
	input 	reg			axi_rlast,

	// 握手信号
	input 				wb_ready,	// 这个是决定if_valid是否有效,表示上一条指令执行完毕
	input 				id_ready,
	output 	reg 		if_valid,

    output 	reg [31:0] 	pc_F,

	// PC更换为NPC的有效信号，本来可以直接使用if_valid的，但是因为访问指令寄存器加入了延时之后，导致取指和pc更新对不上拍
	output 	reg 		PCW,

	// Access Fault异常
	input	[1:0]		Access_Fault
);

	reg [6:0] delay_counter;	// 因为现在的取指还是需要受到下面的模块执行情况的控制，所以需要将if_valid置为1之前需要延迟几个时钟周期，等到后面的模块执行完毕

	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_DELAY_1 = 2, S_DELAY_2 = 3, S_DELAY_3 = 4, S_DELAY_4 = 5, S_DELAY_5 = 6, S_DELAY_6 = 7, S_DELAY_7 = 8, S_DELAY_8 = 9, S_DELAY_9 = 10, S_AR_DELAY = 11, S_R_DELAY = 12, S_DELAY_12 = 13, S_DELAY_13 = 14, S_DELAY_14 = 15, S_DELAY_15 = 16, S_DELAY_16 = 17, S_DELAY_17 = 18, S_DELAY_18 = 19, S_DELAY_19 = 20, S_WAIT = 21;
	reg [5:0] state;

	// 判断是否取下一条指令，new_ins信号为高表示可以取下一条指令
	reg new_ins;
	always @(posedge clk) begin
		if(reset)begin
			new_ins		<= 1'b1;
		end else if(wb_ready == 1'b0)begin
			new_ins		<= 1'b1;
		end else if(if_valid == 1'b1)begin
			new_ins		<= 1'b0;
		end else begin
			new_ins		<= new_ins;
		end
	end


	always @(posedge clk) begin
		if(reset) begin
			state 			<= S_IDLE;
			// state 			<= S_DELAY_7;
			if_valid		<= 1'b0;
			PCW				<= 1'b0;
			axi_arvalid 	<= 1'b0;
			axi_awvalid		<= 1'b0;
			axi_wvalid		<= 1'b0;
			axi_bready		<= 1'b0;

			axi_arlen		<= 8'b0;
			axi_arsize		<= 3'b010;	// 一次传输四个字节

			delay_counter	<= 3;
		end else begin
			case (state)
				S_IDLE: begin
					if(if_valid == 1'b0 && new_ins == 1'b1) begin
						// 后续如果修改的建议：判断是否有指令需要发送，然后在跳转到下一个状态
						axi_arvalid	<= 1'b1;
						state		<= S_FETCH;
					end
				end
				S_FETCH: begin
					// 地址握手成功
					if(axi_arready == 1'b1)begin
						axi_arvalid	<= 1'b0;
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
						if_valid		<= 1'b0;
						delay_counter	<= 2;
						state			<= S_DELAY_4;	// 这一个在多周期的环节不能省去
					end
				end

				S_DELAY_4: begin
					if(delay_counter > 0)begin
						delay_counter	<= delay_counter - 1'b1;
					end else begin
						state		<= S_DELAY_5;
					end
				end
				S_DELAY_5:begin
					PCW			<= 1'b1;
					state		<= S_DELAY_6;
				end
				S_DELAY_6: begin
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
		.Access_Fault(Access_Fault),
		.npc(npc),
		.pc(pc_F)
	);

endmodule