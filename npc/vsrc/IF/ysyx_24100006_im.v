/**
    模拟指令存储，使用DPI-C进行读取指令
*/
module ysyx_24100006_im(
    input clk,
    input reset,

    // axi使用的地址和数据
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

    parameter IDLE = 2'b00,READ_ADDR = 2'b01,READ_DATA = 2'b10;


    reg [1:0] state;
    reg [31:0] addr_reg;
    reg [31:0] data_reg;

    always @(posedge clk) begin
        if(reset)begin
            state           <= IDLE;
            axi_rvalid      <= 1'b0;
            axi_arready     <= 1'b0;
            addr_reg        <= 32'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    axi_arready     <= 1'b0;
                    if(axi_arvalid == 1'b1)begin
                        axi_arready     <= 1'b1;
                        addr_reg        <= axi_araddr;
                        state           <= READ_ADDR;
                    end
                end

                READ_ADDR: begin
                    axi_arready         <= 1'b0;
                    if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
                        data_reg        <= pmem_read(axi_araddr);
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
