/**
    模拟指令存储，使用DPI-C进行读取指令
*/
module ysyx_24100006_im(
    input clk,  
    input valid,
    input [31:0] pc,
    output reg [31:0] instruction
);

    import "DPI-C" function int pmem_read(input int raddr);
    
    reg [31:0] read_data;  // 用于临时存储指令

    // always@(posedge clk)begin
    //     // if(valid) begin
    //         // 在时钟上升沿读取当前pc对应的指令并缓存
    //         instruction <= pmem_read(pc);
    //     // end
    // end

    always@(*)begin
        read_data = pmem_read(pc);
    end

    always @(posedge clk) begin
        // 延迟一个周期输出缓存的指令
        instruction <= read_data;
    end

endmodule
