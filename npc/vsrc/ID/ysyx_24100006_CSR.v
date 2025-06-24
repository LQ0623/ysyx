/**
  系统寄存器堆
*/
`define MSTATUS   12'h300
`define MTVEC     12'h305
`define MCAUSE    12'h342
`define MEPC      12'h341
`define MVENDORID 12'hF11   // 提供厂商 ID（Vendor ID），标识处理器制造商
`define MARCHID   12'hF12   // 提供架构 ID（Architecture ID），描述处理器架构版本。
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
  reg [DATA_WIDTH-1:0] rf [5:0];

  // 选择写入到哪个寄存器
  wire [2:0]waddr_in;
  wire [2:0]raddr_in;
  
  ysyx_24100006_MuxKey #(4, 12, 3) waddr_mux(
    .out 	(waddr_in  ),
    .key 	(waddr  ),
    .lut 	({
      `MSTATUS, 3'b000,
      `MTVEC  , 3'b001,
      `MCAUSE , 3'b010,
      `MEPC   , 3'b011
    }  )
  );
  ysyx_24100006_MuxKey #(6, 12, 3) raddr_mux(
    .out 	(raddr_in  ),
    .key 	(raddr  ),
    .lut 	({
      `MSTATUS  , 3'b000,
      `MTVEC    , 3'b001,
      `MCAUSE   , 3'b010,
      `MEPC     , 3'b011,
      `MVENDORID, 3'b100,
      `MARCHID  , 3'b101
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
    rf[4] <= 32'h79737978;
    rf[5] <= 32'd24100006;
  end

  assign rdata = rf[raddr_in];
  assign mtvec = rf[1];
  assign mepc  = rf[3];


  // DPI-C传出csr寄存器的值
// `ifdef VERILATOR_SIM
// // 获取GPR通用寄存器的值
// import "DPI-C" context function void get_csr(input logic [31:0] csr[]);  // 32位的寄存器
//   always @(posedge clk) begin
//     get_csr(rf);
//   end
// `endif

endmodule
