/**
    访问内存模块
*/
module ysyx_24100006_memu(
    input 				clk,
	input 				reset,
input [31:0] npc_E,
output [31:0] npc_M,

	input           	is_break_i,
    output            	is_break_o,
	input [1:0]			sram_read_write,	// 00:无访存 01:读 10:写

	// from EXE_MEM（上一拍已寄存，但仍需在本级再次锁存）
	input [31:0] 		pc_M,
	input [31:0] 		alu_result_M,
	input [31:0] 		sext_imm_M,
	input [31:0] 		rs1_data_M,
    input [31:0] 		rs2_data_M,
	input [31:0] 		rdata_csr_M,

	// control signal
	input 				irq_M,
	input [7:0] 		irq_no_M,
	input 				Gpr_Write_M,
	input 				Csr_Write_M,
	input [3:0]     	Gpr_Write_Addr_M,
    input [11:0]    	Csr_Write_Addr_M,
	input [2:0] 		Gpr_Write_RD_M,
	input [1:0] 		Csr_Write_RD_M,
	input [7:0] 		Mem_WMask_M,
	input [2:0] 		Mem_RMask_M,

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
output is_load,
	// to MEM_WB（下游）
	output [31:0] 		pc_W,
	output [31:0] 		sext_imm_W,
	output [31:0] 		alu_result_W,
	output [31:0] 		rs1_data_W,
	output [31:0] 		rdata_csr_W,
	output [31:0] 		Mem_rdata_extend,

	// control signal to WBU（经 MEM_WB）
	output 				irq_W,
	output [7:0] 		irq_no_W,
	output 				Gpr_Write_W,
	output 				Csr_Write_W,
	output [3:0]    	Gpr_Write_Addr_W,
    output [11:0]   	Csr_Write_Addr_W,
	output [2:0] 		Gpr_Write_RD_W,
	output [1:0] 		Csr_Write_RD_W
);

	// TAG:也需要使用读写使能来进行状态的转移
	// TAG:读操作、写操作或者不操作内存这三种状态之间的转移的选择是在controller单独拉一条线出来，表示是读操作、写操作还是不操作内存

	// ================= 内部寄存器（在接收上游时一次性锁存） =================
	reg			is_break_r;
    reg [31:0]	pc_r;
    reg [31:0]  alu_result_r;
    reg [31:0]  sext_imm_r;
    reg [31:0]  rs1_data_r;
    reg [31:0]  rs2_data_r;
    reg [31:0]  rdata_csr_r;

    reg         irq_r;
    reg [7:0]   irq_no_r;
    reg         Gpr_Write_r;
    reg         Csr_Write_r;
	reg [3:0]	Gpr_Write_Addr_r;
	reg [11:0]	Csr_Write_Addr_r;
    reg [2:0]   Gpr_Write_RD_r;
    reg [1:0]   Csr_Write_RD_r;

    reg [7:0]   Mem_WMask_r;
    reg [2:0]   Mem_RMask_r;
    reg [1:0]   sram_rw_r;

    // 访存锁存
    reg [31:0]	locked_addr;   // 地址锁存
    reg [31:0]  locked_data;   // 写数据锁存
	reg	[1:0]	locked_sram_read_write;

	// 握手机制
	// ================= 状态机 =================
    localparam  S_IDLE      = 4'd0,		// 只在该态将out_ready拉高
                S_LOCK      = 4'd1,
                READ_ADDR   = 4'd2,
                READ_DATA   = 4'd3,
                WRITE_ADDR  = 4'd4,
                WRITE_DATA  = 4'd5,
                WRITE_RESP  = 4'd6,
                S_SEND      = 4'd7;   	// 只在该态对下游拉高 valid

	reg [3:0] state;

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
		end else begin
			case(state) 
				// 空闲态：等待上游握手，锁存所有信号
				S_IDLE: begin	// S_IDLE阶段用于锁存数据
					locked_sram_read_write<=0;
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
							locked_data 	<= rs2_data_M;
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
						axi_arsize		<= 	(Mem_RMask_r == 0 || Mem_RMask_r == 1) ? 3'b000 :
											(Mem_RMask_r == 2 || Mem_RMask_r == 3) ? 3'b001 :
											(Mem_RMask_r == 4) ? 3'b010 : 3'b010;
						
						axi_addr_suffix	<= locked_addr[1:0];

						// axi握手
						axi_arvalid		<= 1'b1;
						state			<= READ_ADDR;
					end else if(locked_sram_read_write == 2'b10) begin
						// WRITE
						axi_awaddr		<= locked_addr;	// 锁存的地址
						// 传输需要写多少个字节
						axi_awsize		<= 	(Mem_WMask_r == 8'b00000001) ? 3'b000 :
											(Mem_WMask_r == 8'b00000011) ? 3'b001 :
											(Mem_WMask_r == 8'b00001111) ? 3'b010 : 3'b010;

						// 地址和数据同时发送，这样效率最高
						axi_awvalid		<= 1'b1;
						axi_wdata		<= locked_data;
						axi_wvalid		<= 1'b1;
						axi_wlast		<= 1'b1;	// 说明是最后一组数据
						// 写入掩码需要按照实际的指令以及写入的地址来变化
						// 写掩码：按地址低位对齐
						axi_wstrb		<= 	(Mem_WMask_r == 8'b00000001) ? 	// sb指令，存储一个字节
												(	(locked_addr[1:0] == 2'b00) ? 4'b0001 : 
													(locked_addr[1:0] == 2'b01) ? 4'b0010 :
													(locked_addr[1:0] == 2'b10) ? 4'b0100 :
													(locked_addr[1:0] == 2'b11) ? 4'b1000 : 4'b0000) :
											(Mem_WMask_r == 8'b00000011) ?	// sh指令，存储两个字节
												(	(locked_addr[1:0] == 2'b00) ? 4'b0011 : 
													(locked_addr[1:0] == 2'b01) ? 4'b0110 :
													(locked_addr[1:0] == 2'b10) ? 4'b1100 : 4'b0000) :
											(Mem_WMask_r == 8'b00001111) ?	// sh指令，存储两个字节
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
						axi_rready		<= 1'b0;
						// Read data comes from external axi_rdata, extension is done in combinational logic
                        state       	<= S_SEND;

						// 清理可选项
                        axi_arsize  	<= 3'b000;
                        axi_addr_suffix <= 2'b00;
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
						
						// state				<= WRITE_DATA;
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
						// 清理可选项
                        axi_awsize  		<= 3'b010;
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
                        axi_addr_suffix  	<= 2'b00;
                    end
				end
				default: state <= S_IDLE;
			endcase
		end
	end

reg [31:0] npc_r;
	// 所存数据
	always @(posedge clk) begin
		if(reset)begin
			// 本级寄存器复位
			is_break_r      <= 1'b0; // 复位时不可能是ebreak指令
            pc_r            <= 32'b0;
            alu_result_r    <= 32'b0;
            sext_imm_r      <= 32'b0;
            rs1_data_r      <= 32'b0;
            rs2_data_r      <= 32'b0;
            rdata_csr_r     <= 32'b0;

            irq_r           <= 1'b0;
            irq_no_r        <= 8'b0;
            Gpr_Write_r     <= 1'b0;
            Csr_Write_r     <= 1'b0;
			Gpr_Write_Addr_r<= 4'b0;
			Csr_Write_Addr_r<= 12'b0;
            Gpr_Write_RD_r  <= 3'b0;
            Csr_Write_RD_r  <= 2'b0;

            Mem_WMask_r     <= 8'b0;
            Mem_RMask_r     <= 3'b0;
            sram_rw_r       <= 2'b00;

			npc_r			<= 32'b0;
		end else begin
			if(state == S_IDLE)begin
				// 锁存所有将要向下游传递的字段
				is_break_r      <= is_break_i;
				pc_r            <= pc_M;
				alu_result_r    <= alu_result_M;
				sext_imm_r      <= sext_imm_M;
				rs1_data_r      <= rs1_data_M;
				rs2_data_r      <= rs2_data_M;
				rdata_csr_r     <= rdata_csr_M;

				irq_r           <= irq_M;
				irq_no_r        <= irq_no_M;
				Gpr_Write_r     <= Gpr_Write_M;
				Csr_Write_r     <= Csr_Write_M;
				Gpr_Write_Addr_r<= Gpr_Write_Addr_M;
				Csr_Write_Addr_r<= Csr_Write_Addr_M;
				Gpr_Write_RD_r  <= Gpr_Write_RD_M;
				Csr_Write_RD_r  <= Csr_Write_RD_M;

				Mem_WMask_r     <= Mem_WMask_M;
				Mem_RMask_r     <= Mem_RMask_M;
				sram_rw_r       <= sram_read_write;

				npc_r			<= npc_E;
			end
		end
	end
	

    // ================== 对外输出 ==================
	assign is_load = (locked_sram_read_write == 2'b01); // 仅在读操作时为1
    // 向下游的数据（全部来源于本级锁存寄存器）
	assign is_break_o      	= is_break_r;
    assign pc_W            	= pc_r;
    assign sext_imm_W      	= sext_imm_r;
    assign alu_result_W    	= alu_result_r;
    assign rs1_data_W      	= rs1_data_r;
    assign rdata_csr_W     	= rdata_csr_r;

    assign irq_W           	= irq_r;
    assign irq_no_W        	= irq_no_r;
    assign Gpr_Write_W     	= Gpr_Write_r;
    assign Csr_Write_W     	= Csr_Write_r;
    assign Gpr_Write_RD_W  	= Gpr_Write_RD_r;
    assign Csr_Write_RD_W  	= Csr_Write_RD_r;
	assign Gpr_Write_Addr_W	= Gpr_Write_Addr_r;
	assign Csr_Write_Addr_W	= Csr_Write_Addr_r;
assign npc_M = npc_r;

    // 读取数据的扩展：使用已锁存的读掩码
    ysyx_24100006_MuxKey#(5,3,32) mem_rdata_extend_i(
        Mem_rdata_extend, Mem_RMask_r, {
            3'b000, {{24{axi_rdata[7]}},  	axi_rdata[7:0]},
            3'b001, {24'b0,  			axi_rdata[7:0]},
            3'b010, {{16{axi_rdata[15]}}, 	axi_rdata[15:0]},
            3'b011, {16'b0,     		axi_rdata[15:0]},
            3'b100, axi_rdata[31:0]
        }
    );

endmodule