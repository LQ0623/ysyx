/**
    取指模块
*/
module ysyx_24100006_ifu(
    input clk,
    input reset,

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

	reg PCW; 

	// TODO:这里思考一下，是选取那种方式取指
	// 是否可以启动新取指
	// wire can_accept_new = (!if_in_valid && if_in_ready);
	// wire can_accept_new = (!if_in_valid) || (if_in_valid && if_in_ready);
	wire can_accept_new = !if_in_valid || if_in_ready;

	// 握手机制
	parameter S_IDLE = 0, S_FETCH = 1, S_WAITD = 3;
	reg [1:0] state;

	always @(posedge clk) begin
		if(reset) begin
			state 			<= S_IDLE;
			// state 			<= S_DELAY_7;
			if_in_valid		<= 1'b0;
			PCW				<= 1'b0;
			// axi_araddr		<= 32'b0;
			axi_arvalid 	<= 1'b0;
			axi_awvalid		<= 1'b0;
			axi_wvalid		<= 1'b0;
			axi_bready		<= 1'b0;
			axi_rready		<= 1'b0;

			axi_arlen		<= 8'b0;
			axi_arsize		<= 3'b010;	// 一次传输四个字节
		end else begin
			case (state)
                S_IDLE: begin
                    if (can_accept_new) begin
                        // axi_araddr  <= pc_F;
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
                        axi_rready	<= 1'b0;
                        inst_F     	<= axi_rdata;
                        if_in_valid	<= 1'b1; // 有新指令可输出
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

	wire [31:0] npc_temp;
	assign npc_temp = redirect_valid ? npc : pc_F + 4;
	assign axi_araddr = pc_F;

	ysyx_24100006_pc PC(
		.clk(clk),
		.reset(reset),
		.PCW(if_in_valid == 1 && if_in_ready == 1),
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