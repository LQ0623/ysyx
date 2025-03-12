/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

    input [31:0] npc,
	
	// 握手信号以及取指有效信号
	input id_ready,
	output reg if_valid,

    output reg [31:0] pc_F,
    output reg [31:0] instruction   // 读出的指令
);

	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_DELAY_1 = 2, S_DELAY_2 = 3, S_WAIT = 4;
	reg [2:0] state;

	always @(posedge clk) begin
		if(reset) begin
			state 		<= S_IDLE;
			if_valid	<= 1'b0;
		end else begin
			case (state)
				S_IDLE: begin
					if(if_valid == 1'b0) begin
						// 后续如果修改的建议：判断是否有指令需要发送，然后在跳转到下一个状态
						state	<= S_FETCH;
					end
				end
				S_FETCH: begin
					state		<= S_DELAY_1;
				end
				S_DELAY_1: begin
					state		<= S_DELAY_2;
				end
				S_DELAY_2: begin
					if_valid	<= 1'b1;
					state		<= S_WAIT;
				end
				S_WAIT: begin
					if(if_valid && id_ready) begin
						if_valid	<= 1'b0;
						state		<= S_IDLE;
					end
				end
			endcase
		end
	end

	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW(if_valid),
		.npc(npc),
		.pc(pc_F)
	);

	wire [31:0] instruction_temp;	// 指令寄存器读出的数据
	ysyx_24100006_im IM(
		.valid(~(reset | clk)),
		.pc(pc_F),
		.instruction(instruction_temp)
	);

    /**
		IR寄存器：保存取出的指令
	*/
	ysyx_24100006_Reg #(32,32'h00000000) IR(
		.clk(clk),
		.rst(reset),
		.din(instruction_temp),
		.dout(instruction),
		.wen(1'b1)
	);

endmodule