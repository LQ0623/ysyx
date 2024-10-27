/* verilator lint_off UNUSEDSIGNAL */
module ysyx_24100006_mem(
    input clk,
    input Mem_Write,
    input [7:0] Mem_WMask,
    input [31:0] waddr,
    input [31:0] wdata,
    input Mem_Read,
    input [31:0] raddr,
    output [31:0] rdata
);

    
    import "DPI-C" function int pmem_read(input int raddr);
    import "DPI-C" function void pmem_write(input int waddr, input int wdata,input byte wmask);
    always@(*)begin
        if(Mem_Write)begin
            pmem_write(waddr,wdata,Mem_WMask);
        end
        else if (Mem_Read)begin
            rdata = pmem_read(raddr);
        end
        else begin
            raddr = 0;
        end
    end

endmodule
/* verilator lint_off UNUSEDSIGNAL */