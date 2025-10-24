/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,
	input               stall_id, 
	
	input 				is_fence_i,
	input 				icache_flush_done,

	// from EXE
    input [31:0] 		npc,
	input 				redirect_valid, 	// 需要重定向PC
	// AXI-Lite接口
    // read_addr
	output	reg [31:0]	axi_araddr,
	input 		 		axi_arready,
	output 	reg 		axi_arvalid,
    // read data
	input 		 		axi_rvalid,
    output 	reg 		axi_rready,
	input	[31:0]		axi_rdata,

	// 握手信号
	output 	reg			if_in_valid,
	input 				if_in_ready,


    output reg	[31:0]  pc_F,


	output reg [31:0] 	inst_F
	// output [31:0]		pc_add_4_o

`ifdef VERILATOR_SIM
	// Access Fault异常
	,input	[1:0]		Access_Fault
`endif

	// 异常相关
	,input [31:0]		csr_mtvec
	,input				EXC
);

	// 是否发送重定向
	reg [1:0] redirect_flag;	// 检测上升沿
	always @(posedge clk) begin
		redirect_flag <= {redirect_flag[0],redirect_valid};
	end
	// 异常处理机制
	reg [1:0] exc_flag;	// 检测上升沿
	always @(posedge clk) begin
		exc_flag <= {exc_flag[0],EXC};
	end
	reg [1:0] req_epoch;
	reg [1:0] cur_epoch;
	always @(posedge clk) begin
		if (reset) begin
			req_epoch <= 2'b0;
			cur_epoch <= 2'b0;
		end else begin
			if (axi_arvalid && axi_arready) begin
				req_epoch <= cur_epoch;
			end
			if (( redirect_valid == 1 && redirect_flag == 2'b00) || (EXC == 1 && exc_flag == 2'b00)) begin
				cur_epoch <= cur_epoch + 1;
			end
		end
	end

	reg PCW; 

	// 是否可以启动新取指
	wire can_accept_new = !if_in_valid || (if_in_ready & ~stall_id) || (is_fence_i);

	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_WAITD = 3;
	reg [1:0] state;

	always @(posedge clk) begin
		if(reset) begin
			state 			<= S_IDLE;
			if_in_valid		<= 1'b0;
			PCW				<= 1'b0;
			axi_arvalid 	<= 1'b0;
			axi_rready		<= 1'b0;

		end else begin

			// 当 icache 刷新完毕后，回到空闲状态
			// 以防止在刷新过程中进入取指状态
			if(icache_flush_done)begin
				state <= S_IDLE;
			end

			case (state)
                S_IDLE: begin
                    if (can_accept_new) begin
                        axi_arvalid <= 1'b1;
                        state       <= S_FETCH;
                    end
                end
                S_FETCH: begin
                    if (axi_arready) begin
                        axi_arvalid <= 1'b0;
                        axi_rready	<= 1'b1;
                        state   	<= S_WAITD;
                    end
                end
                S_WAITD: begin
                    if (axi_rvalid && axi_rready) begin
                        if(req_epoch == cur_epoch && !redirect_valid && !EXC) begin
							// 取指成功
							inst_F     	<= axi_rdata;
							if_in_valid	<= 1'b1; // 有新指令可输出
						end 
						axi_rready	<= 1'b0;
						state     	<= S_IDLE;
                    end
                end
            endcase

			// 当 IF_ID 接走数据后，清除 valid
            if (if_in_valid && if_in_ready) begin
                if_in_valid 		<= 1'b0;
            end
		end
	end

// 如果不是仿真的话,那么pc_F是没有定义的
// `ifndef VERILATOR_SIM
// 	wire [31:0] pc_F;
// `endif

	// 判断指令是否为jal指令，并计算跳转的位置
	wire [31:0] jal_target;
	wire 		is_jal;
	assign is_jal 		= (inst_F[6:0] == 7'b1101111) ? 1'b1 : 1'b0;
	assign jal_target 	= pc_F + {{12{inst_F[31]}},inst_F[19:12],inst_F[20],inst_F[30:21],1'b0};


	wire [31:0] npc_temp;
	// assign pc_add_4_o 	= pc_F + 4;
	assign npc_temp 	= EXC ? csr_mtvec : (redirect_valid ? npc : (is_jal ? jal_target : pc_F + 4));
	// assign npc_temp 	= EXC ? csr_mtvec : (redirect_valid ? npc : pc_add_4_o);
	assign axi_araddr 	= pc_F;


`ifndef NPC
	// ysyx_24100006_Reg #(32,32'h30000000) pc1(
	// 	.clk(clk),
	// 	.rst(reset),
	// 	.din(npc_temp),
	// 	.dout(pc_F),
	// 	.wen((if_in_valid == 1 && if_in_ready == 1) || redirect_valid || EXC)
	// );
	always @(posedge clk) begin
		if (reset) pc_F <= 32'h30000000;
		else if ((if_in_valid == 1 && if_in_ready == 1) || redirect_valid || EXC) pc_F <= npc_temp;
	end
`else
	// ysyx_24100006_Reg #(32,32'h80000000) pc1(
	// 	.clk(clk),
	// 	.rst(reset),
	// 	.din(npc_temp),
	// 	.dout(pc_F),
	// 	.wen((if_in_valid == 1 && if_in_ready == 1) || redirect_valid || EXC)
	// );
	always @(posedge clk) begin
		if (reset) pc_F <= 32'h80000000;
		else if ((if_in_valid == 1 && if_in_ready == 1) || redirect_valid || EXC) pc_F <= npc_temp;
	end
`endif


`ifndef __ICARUS__
	import "DPI-C" function void get_PCW(input bit PCW);
	always @(*) begin
		get_PCW(if_in_valid);
	end
`endif

endmodule