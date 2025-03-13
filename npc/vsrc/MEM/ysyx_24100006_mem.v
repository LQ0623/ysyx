/**
    使用DPI-C进行内存读写
*/
module ysyx_24100006_mem(
    input clk,
    input Mem_Write,
    input [7:0] Mem_WMask,
    input [31:0] waddr,
    input [31:0] wdata,
    input Mem_Read,
    input [31:0] raddr,
    output reg [31:0] rdata
);

    
    import "DPI-C" function int pmem_read(input int raddr);
    import "DPI-C" function void pmem_write(input int waddr, input int wdata,input byte wmask);
    
    // 内存写
    always@(posedge clk)begin
        if(Mem_Write)begin
            pmem_write(waddr,wdata,Mem_WMask);
        end
    end


    reg [31:0] read_data;  // 用于临时存储数据

    // 内存读
    always @(posedge clk) begin
        if (Mem_Read)begin
            read_data <= pmem_read(raddr);
        end
        else begin
            read_data <= 32'h00000000;
        end
    end

    assign rdata = read_data;


endmodule

