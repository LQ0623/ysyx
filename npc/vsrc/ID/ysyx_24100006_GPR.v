module ysyx_24100006_GPR #(
  parameter ADDR_WIDTH = 4,
  parameter DATA_WIDTH = 32
)(
  input                       clk,
  input      [DATA_WIDTH-1:0] wdata,
  input      [ADDR_WIDTH-1:0] waddr,
  input                       wen,
  input      [ADDR_WIDTH-1:0] rs1,
  input      [ADDR_WIDTH-1:0] rs2,
  output     [DATA_WIDTH-1:0] rs1_data,
  output     [DATA_WIDTH-1:0] rs2_data
);

  localparam DEPTH = 16;
  reg [DATA_WIDTH-1:0] rf [1:DEPTH-1];
  
  // 初始化x0为0，其他寄存器可以保持未初始化或初始化为0
  // integer i;
  // initial begin
  //   rf[0] = 0;
  //   // for (i = 1; i < DEPTH; i = i + 1) rf[i] = 0; // 可选：初始化所有寄存器
  // end

  // 同步写：简化写法
  always @(posedge clk) begin
    if (wen && waddr != 0) begin
      rf[waddr] <= wdata;
    end
  end

  // 异步读：直接数组索引（更简洁）
  assign rs1_data = (rs1 == 0) ? 0 : rf[rs1];
  assign rs2_data = (rs2 == 0) ? 0 : rf[rs2];

endmodule