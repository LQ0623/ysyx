/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input 				clk,
	input 				reset,

`ifdef VERILATOR_SIM
	input [31:0] 		pc_M,
	output [31:0] 		pc_W,
	input  [31:0] 		npc_E,
	output [31:0] 		npc_M,
`endif

	input           	is_break_i,
    output            	is_break_o,
	input [1:0]			sram_read_write,	// 00:无访存 01:读 10:写

	// from EXE_MEM（上一拍已寄存，但仍需在本级再次锁存）
	input [31:0] 		alu_result_M,

	// control signal
	input 				irq_M,
	input [3:0] 		irq_no_M,
	input 				Gpr_Write_M,
	input 				Csr_Write_M,
	input [3:0]     	Gpr_Write_Addr_M,
    input [11:0]    	Csr_Write_Addr_M,
	input [1:0] 		Gpr_Write_RD_M,

	// AXI-Lite接口
    // read_addr
	output	reg [31:0]	axi_araddr,
	input 	reg 		axi_arready,
	output 	reg 		axi_arvalid,
    // read data
	input 	reg [31:0]	axi_rdata,
	input 	reg 		axi_rvalid,
    output 	reg 		axi_rready,
	// write addr
	output 	reg [31:0]	axi_awaddr,
	input 	reg 		axi_awready,
	output 	reg 		axi_awvalid,
	// write data
	input 	reg 		axi_wready,
	output 	reg [31:0]	axi_wdata,
	output 	reg 		axi_wvalid,
	// response
	input 	reg 		axi_bvalid,
	output 	reg 		axi_bready,
	input   [1:0]		axi_bresp,

	// 新增AXI信号
	// 读通道
	output 	reg	[7:0]	axi_arlen,
	output 	reg	[2:0]	axi_arsize,
	input 	reg			axi_rlast,
	// 写通道
	output 	reg	[7:0]	axi_awlen,
	output 	reg	[2:0]	axi_awsize,
	output 	reg [3:0]	axi_wstrb,
	output	reg			axi_wlast,

	// 用于分辨原始的地址的后两位
	output 	reg [1:0]	axi_addr_suffix,


	// 握手机制使用
	input           	mem_out_valid,   // EXE_MEM -> MEMU (上游 valid)
    output          	mem_out_ready,   // MEMU -> EXE_MEM  (上游 ready)
    output          	mem_in_valid,    // MEMU -> MEM_WB (下游 valid)
    input           	mem_in_ready,    // MEM_WB -> MEMU (下游 ready)
	output 				is_load,
	// to MEM_WB（下游）
	// control signal to WBU（经 MEM_WB）
	output 				irq_W,
	output [3:0] 		irq_no_W,
	output 				Gpr_Write_W,
	output 				Csr_Write_W,
	output [3:0]    	Gpr_Write_Addr_W,
    output [11:0]   	Csr_Write_Addr_W

	// 面积优化
	,input 	[31:0]  	wdata_gpr_M
	,input 	[31:0]  	wdata_csr_M
    ,output [31:0]  	wdata_gpr_W
    ,output [31:0]  	wdata_csr_W

	,input  [2:0]   	Mem_Mask_M

	// 前递单元设计
	,output				exe_mem_is_load
	,output	[31:0]		mem_fw_data
);

	// TAG:也需要使用读写使能来进行状态的转移
	// TAG:读操作、写操作或者不操作内存这三种状态之间的转移的选择是在controller单独拉一条线出来，表示是读操作、写操作还是不操作内存

	// ================= 内部寄存器（在接收上游时一次性锁存） =================
	reg			is_break_r;

    reg         irq_r;
    reg [3:0]   irq_no_r;
    reg         Gpr_Write_r;
    reg         Csr_Write_r;
	reg [3:0]	Gpr_Write_Addr_r;
	reg [11:0]	Csr_Write_Addr_r;
    reg [1:0]   Gpr_Write_RD_r;

	// 面积优化
	reg [31:0]	wdata_gpr_r;
	reg [31:0]	wdata_csr_r;

	reg [2:0] 	Mem_Mask_r;

    // 访存锁存
    reg [31:0]	locked_addr;   // 地址锁存
    reg [31:0]  locked_data;   // 写数据锁存
	reg	[1:0]	locked_sram_read_write;
	reg [31:0]	locked_read_data;

	// 握手机制
	// ================= 状态机 =================
    localparam  S_IDLE      = 3'd0,		// 只在该态将out_ready拉高
                S_LOCK      = 3'd1,
                READ_ADDR   = 3'd2,
                READ_DATA   = 3'd3,
                WRITE_ADDR  = 3'd4,
                // WRITE_DATA  = 3'd5,
                WRITE_RESP  = 3'd6,
                S_SEND      = 3'd7;   	// 只在该态对下游拉高 valid

	reg [2:0] state;

	// ----------------- 上下游握手信号（纯组合） -----------------
    assign mem_out_ready = (state == S_IDLE);   // 只有空闲时才接新指令
    assign mem_in_valid  = ((state == S_SEND && locked_sram_read_write == 0) || (locked_sram_read_write !=0 && (axi_rready == 1 && axi_rvalid == 1)) || (axi_bready == 1 && axi_bvalid == 1));   // 完成后仅在发送态有效

	always @(posedge clk) begin
		if(reset) begin
			// axi 握手信号初始化
			axi_arvalid <= 0;
            axi_awvalid <= 0;
            axi_wvalid 	<= 0;
            axi_rready 	<= 0;
            axi_bready 	<= 0;
			axi_wdata	<= 0;

			axi_arlen	<= 8'b0;
			axi_arsize	<= 3'b010;
			axi_awlen	<= 8'b0;
			axi_awsize	<= 3'b010;
			axi_wstrb	<= 4'b0;
			axi_wlast	<= 1'b0;

			axi_addr_suffix<= 2'b0;
			locked_sram_read_write<=0;
			state		<= S_IDLE;
			locked_read_data	<= 0;
		end else begin
			case(state) 
				// 空闲态：等待上游握手，锁存所有信号
				S_IDLE: begin	// S_IDLE阶段用于锁存数据
					locked_sram_read_write	<=0;
					if(mem_out_valid == 1'b1 && mem_out_ready == 1'b1) begin
						if(sram_read_write == 2'b00) begin
							// 锁存地址和数据
							locked_addr 	<= 32'h0;
							locked_data 	<= 32'h0;
							state			<= S_SEND;		// 无访存，直接向下游发送
						end else begin
							locked_sram_read_write<=sram_read_write;
							// 锁存地址和数据
							locked_addr 	<= alu_result_M;
							locked_data 	<= wdata_gpr_M;
							state			<= S_LOCK;		// 锁存地址和数据，准备发起 AXI 访问
						end
					end
				end
				// 根据锁存的类型发起 AXI
				S_LOCK: begin
					// axi 读取
					if(locked_sram_read_write == 2'b01) begin
						axi_araddr		<= locked_addr;	// 锁存的地址
						// 传输需要读多少个字节
						axi_arsize		<= 	(Mem_Mask_r == 0 || Mem_Mask_r == 1) ? 3'b000 :
											(Mem_Mask_r == 2 || Mem_Mask_r == 3) ? 3'b001 :
											(Mem_Mask_r == 4) ? 3'b010 : 3'b010;
						
						axi_addr_suffix	<= locked_addr[1:0];

						// axi握手
						axi_arvalid		<= 1'b1;
						state			<= READ_ADDR;
					end else if(locked_sram_read_write == 2'b10) begin
						// WRITE
						axi_awaddr		<= locked_addr;	// 锁存的地址
						// 传输需要写多少个字节
						axi_awsize		<= 	(Mem_Mask_r == 3'b000) ? 3'b000 :
											(Mem_Mask_r == 3'b001) ? 3'b001 :
											(Mem_Mask_r == 3'b011) ? 3'b010 : 3'b010;

						// 地址和数据同时发送，这样效率最高
						axi_awvalid		<= 1'b1;
						axi_wdata		<= locked_data;
						axi_wvalid		<= 1'b1;
						axi_wlast		<= 1'b1;	// 说明是最后一组数据
						// 写入掩码需要按照实际的指令以及写入的地址来变化
						// 写掩码：按地址低位对齐
						axi_wstrb		<= 	(Mem_Mask_r == 3'b000) ? 	// sb指令，存储一个字节
												(	(locked_addr[1:0] == 2'b00) ? 4'b0001 : 
													(locked_addr[1:0] == 2'b01) ? 4'b0010 :
													(locked_addr[1:0] == 2'b10) ? 4'b0100 :
													(locked_addr[1:0] == 2'b11) ? 4'b1000 : 4'b0000) :
											(Mem_Mask_r == 3'b001) ?	// sh指令，存储两个字节
												(	(locked_addr[1:0] == 2'b00) ? 4'b0011 : 
													(locked_addr[1:0] == 2'b01) ? 4'b0110 :
													(locked_addr[1:0] == 2'b10) ? 4'b1100 : 4'b0000) :
											(Mem_Mask_r == 3'b011) ?	// sw指令，存储两个字节
												(	(locked_addr[1:0] == 2'b00) ? 4'b1111 : 4'b0000) : 4'b0000;
						state			<= WRITE_ADDR;
					end else begin
						// 无访存：直接准备向下游发送
						state			<= S_SEND;
					end
				end

				// 读地址通道握手
				// axi 读地址有效
				READ_ADDR: begin
					if(axi_arready == 1'b1) begin
						axi_arvalid		<= 1'b0;
						axi_rready		<= 1'b1;
						state			<= READ_DATA;
					end
				end

				// 读数据通道
				// axi 读数据有效
				READ_DATA: begin
					if(axi_rvalid == 1'b1) begin
						locked_read_data<=axi_rdata;
						axi_rready		<= 1'b0;
						// Read data comes from external axi_rdata, extension is done in combinational logic
                        state       	<= S_SEND;

						// 清理可选项
						locked_sram_read_write<=0;
					end
				end

				// 写地址/数据通道
				// axi 写使用
				WRITE_ADDR: begin
					if(axi_awready == 1'b1 && axi_wready == 1'b1) begin
						// 因为在MEM的SRAM中，地址和数据是一起将ready置为低的，所以这里还是需要一起无效
						// 若在SRAM中，不一起将ready信号置为低，则还是需要转移到WRITE_DATA状态
						axi_awvalid			<= 1'b0;
						axi_wvalid			<= 1'b0;
						axi_bready			<= 1'b1;
						axi_wlast			<= 1'b0;
						axi_wstrb			<= 4'b0;

						axi_wdata			<= 32'b0;

						state				<= WRITE_RESP;
						
					end
				end

				WRITE_RESP: begin
					if(axi_bvalid == 1'b1) begin
						axi_bready			<= 1'b0;
						// 清理可选项
                        state       		<= S_SEND;
					end
				end

				// 对下游拉高 valid，等待 ready
				S_SEND: begin	// 修改mem_valid信号，用于mem与下一级和上一级模块进行握手
					if (mem_in_ready == 1'b1) begin
                        // 完成与下游握手，回空闲
                        state 				<= S_IDLE;
						
                        // 恢复一些缺省
                        axi_arsize       	<= 3'b010;
                        axi_awsize       	<= 3'b010;
                        // axi_addr_suffix  	<= 2'b00;
                    end
				end
				default: state <= S_IDLE;
			endcase
		end
	end

`ifdef VERILATOR_SIM
	reg [31:0]	pc_r;
	reg [31:0] npc_r;
`endif

	// 所存数据
	always @(posedge clk) begin
		if(reset)begin
			// 本级寄存器复位
			is_break_r      <= 1'b0; // 复位时不可能是ebreak指令

`ifdef VERILATOR_SIM
            pc_r            <= 32'b0;
`endif

            irq_r           <= 1'b0;
            irq_no_r        <= 4'b0;
            Gpr_Write_r     <= 1'b0;
            Csr_Write_r     <= 1'b0;
			Gpr_Write_Addr_r<= 4'b0;
			Csr_Write_Addr_r<= 12'b0;
            Gpr_Write_RD_r  <= 2'b0;
		end else begin
			if(state == S_IDLE)begin
				// 锁存所有将要向下游传递的字段
				is_break_r      <= is_break_i;

				irq_r           <= irq_M;
				irq_no_r        <= irq_no_M;
				Gpr_Write_r     <= Gpr_Write_M;
				Csr_Write_r     <= Csr_Write_M;
				Gpr_Write_Addr_r<= Gpr_Write_Addr_M;
				Csr_Write_Addr_r<= Csr_Write_Addr_M;
				Gpr_Write_RD_r  <= Gpr_Write_RD_M;

				wdata_gpr_r		<= wdata_gpr_M;
				wdata_csr_r		<= wdata_csr_M;

				Mem_Mask_r		<= Mem_Mask_M;

`ifdef VERILATOR_SIM
				pc_r            <= pc_M;
				npc_r			<= npc_E;
`endif
			end
		end
	end
	

    // ================== 对外输出 ==================
	// state==S_IDLE时，就需要锁存数据，因为这里ready的时候，上面一个模块会重新发一批数据，直接在state==S_IDLE时锁存，不然其他模块会以为这个数据其实是state==S_LOCK时锁存的，这样会导致stall的时候不正确
	// 仅在空闲态时，直接将上一级的信号传递下去
	// 否则全部使用本级锁存寄存器的值
	assign is_load = (locked_sram_read_write == 2'b01); // 仅在读操作时为1
    // 向下游的数据（全部来源于本级锁存寄存器）
	assign is_break_o      	= (state == S_IDLE) ? is_break_i : is_break_r;

    assign Gpr_Write_W     	= (state == S_IDLE) ? Gpr_Write_M : Gpr_Write_r;
    assign Csr_Write_W     	= (state == S_IDLE) ? Csr_Write_M : Csr_Write_r;
    wire [1:0] Gpr_Write_RD_W  	= (state == S_IDLE) ? Gpr_Write_RD_M : Gpr_Write_RD_r;
	assign Gpr_Write_Addr_W	= (state == S_IDLE) ? Gpr_Write_Addr_M : Gpr_Write_Addr_r;
	assign Csr_Write_Addr_W	= (state == S_IDLE) ? Csr_Write_Addr_M : Csr_Write_Addr_r;

`ifdef VERILATOR_SIM
	assign pc_W            	= (state == S_IDLE) ? pc_M : pc_r;
	assign npc_M			= (state == S_IDLE) ? npc_E : npc_r;	
`endif

	wire [31:0] Mem_rdata_extend;
    // 读取数据的扩展：使用已锁存的读掩码
    // ysyx_24100006_MuxKey#(5,3,32) mem_rdata_extend_i(
    //     Mem_rdata_extend, Mem_Mask_r, {
    //         3'b000, {{24{axi_rdata[7]}},  	axi_rdata[7:0]},
    //         3'b001, {24'b0,  			axi_rdata[7:0]},
    //         3'b010, {{16{axi_rdata[15]}}, 	axi_rdata[15:0]},
    //         3'b011, {16'b0,     		axi_rdata[15:0]},
    //         3'b100, axi_rdata[31:0]
    //     }
    // );
	wire [31:0] mem_rdata;
    assign mem_rdata = (axi_rvalid) ? axi_rdata : locked_read_data;
	// assign Mem_rdata_extend  = 	(Mem_Mask_r == 3'b000) ? {{24{mem_rdata[7]}}, mem_rdata[7:0]} : 
	// 							(Mem_Mask_r == 3'b010) ? {{16{mem_rdata[15]}}, mem_rdata[15:0]} : 
	// 							mem_rdata;
	
	// 根据锁存的地址低两位，先抽取目标字节/半字
	wire [7:0]  r_byte =
		(axi_addr_suffix == 2'b00) ? mem_rdata[7:0]   :
		(axi_addr_suffix == 2'b01) ? mem_rdata[15:8]  :
		(axi_addr_suffix == 2'b10) ? mem_rdata[23:16] :
									mem_rdata[31:24];

	wire [15:0] r_half =
		(axi_addr_suffix == 2'b00) ? mem_rdata[15:0]  :
		(axi_addr_suffix == 2'b01) ? mem_rdata[23:8]  :
		(axi_addr_suffix == 2'b10) ? mem_rdata[31:16] :
									16'h0000; // 非法半字对齐(…11)时给0或按你异常策略处理

	// 最终扩展（Mem_Mask_r 编码：000=LB, 001=LBU, 010=LH, 011=LHU, 100=LW）
	wire [31:0] Mem_rdata_extend =
		(Mem_Mask_r == 3'b000) ? {{24{r_byte[7]}},  r_byte}  : // LB
		(Mem_Mask_r == 3'b001) ? {24'b0,            r_byte}  : // LBU
		(Mem_Mask_r == 3'b010) ? {{16{r_half[15]}}, r_half}  : // LH
		(Mem_Mask_r == 3'b011) ? {16'b0,            r_half}  : // LHU
								mem_rdata;                  // LW (3'b100)

	
	// 异常处理相关
	wire   store_exc		= (axi_bvalid == 1 && axi_bresp != 0);
	assign irq_W       		= irq_r || store_exc;
	assign irq_no_W    		= store_exc ? 4'd7 : irq_no_r;	// 5号异常为load异常，7号异常为store异常，但是加载异常在xbar还是arbiter就会处理，报错

	// 面积优化
	// 不能直接使用Gpr_Write_RD_r，因为Gpr_Write_RD_r可能缓存的还是上一拍的老数据（直通的情况就不能使用Gpr_Write_RD_r）
	assign wdata_gpr_W		= (Gpr_Write_RD_W == 2'b11) ? Mem_rdata_extend : ((state == S_IDLE) ? wdata_gpr_M : wdata_gpr_r);
	assign wdata_csr_W		= (state == S_IDLE) ? wdata_csr_M : wdata_csr_r;

	// 前递单元设计
	reg [1:0] cnt;
	always @(posedge clk) begin
		if(reset) begin
			cnt <= 2'b0;
		end else begin
			if(mem_out_ready == 1'b1 && sram_read_write == 2'b01)begin
				cnt <= cnt + 1'b1;
			end
			if(axi_rvalid == 1'b1) begin
				cnt <= cnt - 1'b1;
			end
		end
	end

	assign exe_mem_is_load 	= (sram_read_write == 2'b01 && cnt != 0) ? 1'b1 : 1'b0;
	assign mem_fw_data 	= 	wdata_gpr_W;

	// always @(posedge clk) begin
	// 	if(axi_awaddr == 32'ha20913e8) begin
	// 		$display("pc is %x ,memu write addr is %x , op is %x , write data is %x , read data is %x, awvalid is %x, wvalid is %x",pc_r,axi_awaddr,sram_read_write_r,axi_wdata,axi_rdata,axi_awvalid,axi_wvalid);
	// 	end
	// end

endmodule