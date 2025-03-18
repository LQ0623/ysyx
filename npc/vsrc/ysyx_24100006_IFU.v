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


	// 握手信号
	input 				id_ready,
	output 	reg 		if_valid,

    output 	reg [31:0] 	pc_F,

	// PC更换为NPC的有效信号，本来可以直接使用if_valid的，但是因为访问指令寄存器加入了延时之后，导致取指和pc更新对不上拍
	output 	reg 		PCW
);

	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_DELAY_1 = 2, S_DELAY_2 = 3, S_DELAY_3 = 4, S_DELAY_4 = 5, S_DELAY_5 = 6, S_DELAY_6 = 7, S_DELAY_7 = 8, S_DELAY_8 = 9, S_DELAY_9 = 10, S_DELAY_10 = 11, S_DELAY_11 = 12, S_DELAY_12 = 13, S_DELAY_13 = 14, S_WAIT = 15;
	reg [4:0] state;

	always @(posedge clk) begin
		if(reset) begin
			state 		<= S_IDLE;
			if_valid	<= 1'b0;
			PCW			<= 1'b0;
			axi_arvalid <= 1'b0;
			axi_awvalid	<= 1'b0;
			axi_wvalid	<= 1'b0;
			axi_bready	<= 1'b0;
		end else begin
			case (state)
				S_IDLE: begin
					if(if_valid == 1'b0) begin
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
						if_valid	<= 1'b0;
						state		<= S_DELAY_4;
					end
				end
				S_DELAY_4: begin
					state		<= S_DELAY_5;
				end
				S_DELAY_5: begin
					state		<= S_DELAY_6;
				end
				S_DELAY_6: begin
					state		<= S_DELAY_7;
				end
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