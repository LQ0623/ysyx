/**
    模拟指令存储，使用DPI-C进行读取指令
*/
module ysyx_24100006_im(
    input clk,
    input reset,

    
    input [31:0]    axi_araddr,
    input [31:0]    axi_wdata,
    // axi控制信号
    // read data addr
    input           axi_arvalid,
    output  reg     axi_arready,
    // read data
    input           axi_rready,
    output  reg     axi_rvalid,
    // write data addr
	input           axi_awvalid,
	output  reg     axi_awready,
	// write data
	input           axi_wvalid,
	output  reg     axi_wready,
	// response
    input           axi_bready,
	output  reg     axi_bvalid,

    output [31:0] axi_rdata

);

    import "DPI-C" function int pmem_read(input int raddr);

    parameter IDLE = 0,READ_ADDR = 1,READ_DATA = 2,DELAY_WAIT = 3;

    // 新增延迟计数器
    reg [31:0] delay_counter;
    parameter FIXED_DELAY = 5; // 可配置为5/10/20等

    reg [1:0] state;
    reg [31:0] data_reg;

    always @(posedge clk) begin
        if(reset)begin
            state           <= IDLE;
            axi_rvalid      <= 1'b0;
            axi_arready     <= 1'b0;
            delay_counter   <= 32'h0;
        end
        else begin
            case(state)
                IDLE: begin
                    if(axi_arvalid == 1'b1)begin
                        axi_arready     <= 1'b1;
                        state           <= READ_ADDR;
                    end
                end

                READ_ADDR: begin
                    axi_arready         <= 1'b0;
                    if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
                        data_reg        <= pmem_read(axi_araddr);
                        // axi_rvalid      <= 1'b1;
                        delay_counter   <= FIXED_DELAY;
                        // state           <= READ_DATA;
                        state           <= DELAY_WAIT;
                    end
                end

                // 新增延迟等待状态
                DELAY_WAIT: begin
                    if(delay_counter > 0)begin
                        delay_counter   <= delay_counter - 1'b1;
                    end else begin
                        axi_rvalid      <= 1'b1;
                        state           <= READ_DATA;
                    end
                end

                READ_DATA: begin
                    if(axi_rvalid == 1'b1 && axi_rready == 1'b1) begin
                        axi_rvalid      <= 1'b0;
                        state           <= IDLE;
                    end
                end
                default: state       <= IDLE;
            endcase
        end
    end

    assign axi_rdata    = data_reg;

endmodule
