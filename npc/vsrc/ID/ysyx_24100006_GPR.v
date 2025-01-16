/**
  通用寄存器堆
*/
module ysyx_24100006_GPR #(ADDR_WIDTH = 5, DATA_WIDTH = 32) (
  input clk,
  input [DATA_WIDTH-1:0] wdata,
  input [ADDR_WIDTH-1:0] waddr,
  input wen,
  input [ADDR_WIDTH-1:0] rs1,
  input [ADDR_WIDTH-1:0] rs2,
  output [DATA_WIDTH-1:0] rs1_data,
  output [DATA_WIDTH-1:0] rs2_data
);
  reg [DATA_WIDTH-1:0] rf [2**ADDR_WIDTH-1:0];
  
  always @(posedge clk) begin
    if (wen)begin
      rf[waddr] <= wdata;
    end
    rf[0] <= 32'b0;
  end

  assign rs1_data = rf[rs1];
  assign rs2_data = rf[rs2];

endmodule
