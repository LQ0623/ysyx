/**
    取指模块（带 fetch-generation/tag 机制）
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

	// from EXE
    input [31:0] 		npc,
	input 				redirect_valid, 	// 需要重定向PC（你说这是单拍脉冲）

	// AXI-Lite接口
    // read_addr
	output	 [31:0]	axi_araddr,
	input 		 		axi_arready,
	output 	reg 		axi_arvalid,
    // read data
	input 		 		axi_rvalid,
    output 	reg 		axi_rready,
	input	[31:0]		axi_rdata,
	// write addr
	input 		 		axi_awready,
	output 	reg 		axi_awvalid,
	// write data
	input 				axi_wready,
	output 	reg 		axi_wvalid,
	// response
	input 				axi_bvalid,
	output 	reg 		axi_bready,

	// 新增AXI信号
	output 	reg	[7:0]	axi_arlen,
	output 	reg	[2:0]	axi_arsize,
	input 				axi_rlast,

	// 握手信号
	output 	reg			if_in_valid,
	input 				if_in_ready,

    output 	[31:0] 		pc_F,
	output 	reg [31:0] 	inst_F,

	// Access Fault异常
	input	[1:0]		Access_Fault
);

	// ----------------------------
	// 参数与寄存：fetch generation
	// ----------------------------
	localparam TAG_W = 3; // 世代宽度，3位通常足够（可改）
	reg [TAG_W-1:0] fetch_tag;    // 当前有效世代
	reg [TAG_W-1:0] pending_tag;  // outstanding request 所属世代
	reg             pending_req;  // 是否等待返回

	// 记录本次 request 的 PC（用于在接收时可选回填）
	reg [31:0] pending_req_pc;

	// 状态机与握手
	parameter S_IDLE = 0, S_FETCH = 1, S_WAITD = 3;
	reg [1:0] state;

	// 计算 next tag（如果 redirect_valid=1，则 next = fetch+1）
	wire [TAG_W-1:0] next_fetch_tag = fetch_tag + {2'b0,redirect_valid};

	// 是否能启动新取指（与你原来逻辑保持）
	wire can_accept_new = !if_in_valid || if_in_ready;

	// ----------------------------
	// 主时序逻辑
	// ----------------------------
	always @(posedge clk) begin
		if (reset) begin
			// state & handshake
			state 			<= S_IDLE;
			if_in_valid		<= 1'b0;
			axi_arvalid 	<= 1'b0;
			axi_awvalid		<= 1'b0;
			axi_wvalid		<= 1'b0;
			axi_bready		<= 1'b0;
			axi_rready		<= 1'b0;

			axi_arlen		<= 8'b0;
			axi_arsize		<= 3'b010;	// 一次传输四个字节

			// tags & pending
			fetch_tag		<= {TAG_W{1'b0}};
			pending_tag		<= {TAG_W{1'b0}};
			pending_req		<= 1'b0;
			pending_req_pc  <= 32'b0;

			// axi_araddr		<= 32'b0;
			inst_F 			<= 32'b0;
		end else begin
			// -------------------------
			// FSM: 发 ar -> 等 arready -> 等 rd 返回
			// -------------------------
			case (state)
                S_IDLE: begin
                    if (can_accept_new) begin
                        // 发新的 ar 请求：如果本拍 redirect_valid 为 1，则优先取 npc
                        
                        axi_arvalid <= 1'b1;
                        state       <= S_FETCH;
                    end
                end

                S_FETCH: begin
                    if (axi_arready && axi_arvalid) begin
                        // ar 发出成功：记录 pending request 的世代为 next_fetch_tag
                        axi_arvalid <= 1'b0;
                        axi_rready	<= 1'b1;
                        pending_req <= 1'b1;
                        pending_tag <= next_fetch_tag;   // 关键：标上 next 世代
                        pending_req_pc <= axi_araddr;    // 记录请求的 PC
                        state   	<= S_WAITD;
                    end
                end

                S_WAITD: begin
                    if (axi_rvalid && axi_rready) begin
                        axi_rready	<= 1'b0;

                        // 只有当返回的 request 所属的世代等于当前世代，才接收并产生 if_in_valid
                        // （否则这是旧世代的返回，直接丢弃）
                        if (pending_req && (pending_tag == fetch_tag)) begin
                            inst_F   <= axi_rdata;
                            if_in_valid <= 1'b1;
                        end
                        // 清除 pending 标志（read 完成）
                        pending_req <= 1'b0;
                        state <= S_IDLE;
                    end
                end

                default: state <= S_IDLE;
            endcase

			// 如果下游接走我们准备的 IF 指令，则把 if_in_valid 清 0
            if (if_in_valid && if_in_ready) begin
                if_in_valid <= 1'b0;
            end

			// -------------------------
			// fetch_tag 更新（无条件写入 next_fetch_tag）
			// 如果 redirect_valid=1，本拍 fetch_tag 会变为 fetch_tag+1，从而
			// 使得属于旧世代的 pending 返回被丢弃。
			// -------------------------
			fetch_tag <= next_fetch_tag;

			// 当 redirect_valid 存在时，额外在 IFU 层清除 if_in_valid（双保险）
			// （外层 IF_ID/ID_EXE 也应被 flush）
			if (redirect_valid) begin
				if_in_valid <= 1'b0;
			end
		end
	end
assign axi_araddr = (redirect_valid ? npc : pc_F);
	// ----------------------------
	// 输出端口（保留你原有名称）
	// if_in_valid 已作为 reg 输出
	// inst_F 也已在上面赋值
	// ----------------------------
	// 注意：不再对 axi_araddr 使用 continuous assign，axi_araddr
	// 由 FSM 在发 ar 时写入（上面已实现）。

	// ----------------------------
	// PC 更新使用原来逻辑（如果 redirect_valid 为一拍脉冲可以保持）
	// 但建议顶层保证 redirect_valid 为单拍，否则需要把 PCW 改为用脉冲。
	// ----------------------------
	wire [31:0] npc_temp;
	assign npc_temp = redirect_valid ? npc : pc_F + 4;

	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW((if_in_valid == 1 && if_in_ready == 1) || redirect_valid), // 你说 redirect_valid 已是一拍脉冲
		.Access_Fault(Access_Fault),
		.npc(npc_temp),
		.pc(pc_F)
	);

`ifdef VERILATOR_SIM
	import "DPI-C" function void get_PCW(input bit PCW);
	always @(*) begin
		get_PCW(if_in_valid);
	end
`endif

endmodule
