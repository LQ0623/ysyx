module ysyx_24100006_RegisterFile #(ADDR_WIDTH = 5, DATA_WIDTH = 32) (
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
  
  integer i;
  initial begin
      for(i = 0;i < 2**ADDR_WIDTH;i = i + 1)begin
        rf[i] = 32'b0;
      end
  end
  
  always @(posedge clk) begin
    if (wen) rf[waddr] <= wdata;
    rf[0] <= 32'b0;
  end

  assign rs1_data = rf[rs1];
  assign rs2_data = rf[rs2];

endmodule
