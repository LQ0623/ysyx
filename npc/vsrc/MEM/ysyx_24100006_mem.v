/**
    使用DPI-C进行内存读写
*/
module ysyx_24100006_mem(
    input               clk,
    input               reset,

    // axi 写入和读取地址
    input [31:0]        axi_araddr,
    input [31:0]        axi_awaddr,
    // axi 写入数据和写入使用的掩码
    input [31:0]        axi_wdata,
    input [7:0]         axi_wstrb,

    // axi控制信号
    // read data addr
    input               axi_arvalid,
    output  reg         axi_arready,
    // read data
    input               axi_rready,
    output  reg         axi_rvalid,
    // write data addr
	input               axi_awvalid,
	output  reg         axi_awready,
	// write data
	input               axi_wvalid,
	output  reg         axi_wready,
	// response
    input               axi_bready,
	output  reg         axi_bvalid,
    output  reg [1:0]   axi_bresp,

    // axi 读取的回应
    output  reg         axi_rresp,
    output  reg [31:0]  axi_rdata
    
);

    
    import "DPI-C" function int pmem_read(input int raddr);
    import "DPI-C" function void pmem_write(input int waddr, input int wdata,input byte wmask);
    
    parameter   S_IDLE          = 0,
                S_READ_ADDR     = 1, 
                S_READ_DATA     = 2, 
                S_WRITE_ADDR    = 3, 
                S_WRITE_DATA    = 4, 
                S_WRITE_RESP    = 5;


    reg [3:0] state;
    
    always @(posedge clk) begin
        if(reset) begin
            state           <= S_IDLE;
            axi_arready     <= 1'b0;
            axi_awready     <= 1'b0;
            axi_wready      <= 1'b0;
            axi_rvalid      <= 1'b0;
            axi_bvalid      <= 1'b0;
            axi_rdata       <= 32'h00000000;
        end else begin
            case(state)
                S_IDLE: begin
                    if(axi_arvalid == 1'b1) begin
                        axi_arready     <= 1'b1;
                        state           <= S_READ_ADDR;
                    end else if(axi_awvalid == 1'b1 && axi_wvalid == 1'b1) begin
                        axi_awready     <= 1'b1;
                        axi_wready      <= 1'b1;
                        state           <= S_WRITE_ADDR;
                    end
                end
                S_READ_ADDR: begin
                    axi_arready         <= 1'b0;
                    if(axi_arvalid == 1'b1 && axi_arready == 1'b1) begin
                        axi_rvalid      <= 1'b1;
                        axi_rdata       <= pmem_read(axi_araddr);
                        axi_rresp       <= 1;
                        state           <= S_READ_DATA;
                    end
                end
                S_READ_DATA: begin
                    if(axi_rready == 1'b1 && axi_rvalid == 1'b1) begin
                        axi_rvalid      <= 1'b0;
                        state           <= S_IDLE;
                    end
                end
                // 写入地址握手和数据握手放在一起
                S_WRITE_ADDR: begin
                    axi_awready         <= 1'b0;
                    axi_wready          <= 1'b0;
                    if(axi_awvalid == 1'b1 && axi_awready == 1'b1 && axi_wvalid == 1'b1 && axi_wready == 1'b1) begin
                        // 写入数据
                        pmem_write(axi_awaddr,axi_wdata,axi_wstrb);
                        axi_bvalid      <= 1'b1;
                        state           <= S_WRITE_RESP;
                    end
                end
                S_WRITE_RESP: begin
                    if(axi_bready == 1'b1 && axi_bvalid == 1'b1)begin
                        axi_bvalid      <= 1'b0;
                        state           <= S_IDLE;
                    end
                end

                default: state          <= S_IDLE;
            endcase
        end
    end


endmodule

