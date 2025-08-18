// 冲刷流水线就是将所有的存储的数据都置为0
// TODO:PCW信号不用向外暴露了
module ysyx_24100006_IF_ID(
    input           clk,
    input           reset,
    
    input           flush_i,

    // IFU  <----> IF_ID
    input           in_valid,
    output          in_ready,
    input [31:0]    pc_i,
    input [31:0]    instruction_i,

    // IF_ID <----> IDU
    output          out_valid,
    input           out_ready,
    output [31:0]   pc_o,
    output [31:0]   instruction_o
);

    reg [31:0]  pc_temp;
    reg [31:0]  instruction_temp;
    reg         valid_temp;

    // 使用 assign 语句将临时寄存器赋值给输出信号
    assign pc_o             = pc_temp;
    assign instruction_o    = instruction_temp;

    assign out_valid        = valid_temp;
    // 当没有有效存储时，或者当存储并且下游准备好时，可以接受新数据（可以滑动）
    assign in_ready         = (!valid_temp) || (out_ready && valid_temp);

    // 如果 in_valid==0 且 in_ready==1 -> 清除有效（已由 valid_r <= in_valid 完成）
    always @(posedge clk) begin
        if (reset) begin
            valid_temp          <= 1'b0;
            pc_temp             <= 32'h00000000;
            instruction_temp    <= 32'b0;
        end else begin
            if(flush_i)begin
                valid_temp       <= 1'b0; // 冲刷流水线
            end
            
            // 当允许接受新输入时
            else if (in_ready) begin
                valid_temp              <= in_valid;
                if (in_valid)begin
                    pc_temp             <= pc_i;
                    instruction_temp    <= instruction_i;
                end 
            end
            // 没有新数据则一直保持数据
        end
    end

endmodule