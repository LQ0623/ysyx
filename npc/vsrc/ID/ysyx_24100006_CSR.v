/**
  系统寄存器堆
*/
`define MSTATUS 12'h300
`define MTVEC   12'h305
`define MCAUSE  12'h342
`define MEPC    12'h341
module ysyx_24100006_CSR #(ADDR_WIDTH = 12, DATA_WIDTH = 32) (
  input clk,
  input irq,
  input [7:0] irq_no,
  input [DATA_WIDTH-1:0] wdata,
  input [ADDR_WIDTH-1:0] waddr,
  input wen,
  input [ADDR_WIDTH-1:0] raddr, //  这个目前实现的几条csr的指令，使用的地址就是指令的31-20位
  output [DATA_WIDTH-1:0] rdata,
  output [DATA_WIDTH-1:0] mtvec,
  output [DATA_WIDTH-1:0] mepc
);
  // 目前只需要使用三个系统寄存器
  reg [DATA_WIDTH-1:0] rf [3:0];

  // 选择写入到哪个寄存器
  wire [1:0]waddr_in;
  wire [1:0]raddr_in;
  
  ysyx_24100006_MuxKey #(4, 12, 2) waddr_mux(
    .out 	(waddr_in  ),
    .key 	(waddr  ),
    .lut 	({
      `MSTATUS, 2'b00,
      `MTVEC  , 2'b01,
      `MCAUSE , 2'b10,
      `MEPC   , 2'b11
    }  )
  );
  ysyx_24100006_MuxKey #(4, 12, 2) raddr_mux(
    .out 	(raddr_in  ),
    .key 	(raddr  ),
    .lut 	({
      `MSTATUS, 2'b00,
      `MTVEC  , 2'b01,
      `MCAUSE , 2'b10,
      `MEPC   , 2'b11
    }  )
  );

  always @(posedge clk) begin
    if (wen)begin
      rf[waddr_in] <= wdata;
    end
  end

  always @(posedge clk) begin
    if(irq)begin
      rf[2] <= {{24'b0},irq_no};
      rf[3] <= wdata;
    end
    rf[0] <= 32'h1800;
  end

  assign rdata = rf[raddr_in];
  assign mtvec = rf[1];
  assign mepc  = rf[3];

endmodule
