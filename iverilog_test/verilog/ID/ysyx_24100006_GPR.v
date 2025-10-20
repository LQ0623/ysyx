/**
 * 16×32 通用寄存器堆（仅应用优化#1：去除x0物理存储）
 * - 读端口异步；写在clk上升沿；x0恒为0（不占用触发器）
 * - 仅实例化 x1..x15 共15个寄存器
 */
 // TAG: 这里最后可能会导致结果出错，因为综合器会把0号寄存器优化掉，但是如果直接写[1:DEPTH-1]的话，结果就是错的，所以结果错误的话，先怀疑这里
module ysyx_24100006_GPR #(
  parameter ADDR_WIDTH = 4,   // 固定16个寄存器
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

  localparam DEPTH = (1 << ADDR_WIDTH); // = 16

  // 仅为 x1..x15 实例化存储；x0 不占用触发器
  reg [DATA_WIDTH-1:0] rf [1:DEPTH-1];

  // 同步写：当waddr==0时不写入（自然被case的default吞掉）
  always @(posedge clk) begin
    if (wen) begin
      case (waddr)
        4'd1 : rf[1 ] <= wdata;
        4'd2 : rf[2 ] <= wdata;
        4'd3 : rf[3 ] <= wdata;
        4'd4 : rf[4 ] <= wdata;
        4'd5 : rf[5 ] <= wdata;
        4'd6 : rf[6 ] <= wdata;
        4'd7 : rf[7 ] <= wdata;
        4'd8 : rf[8 ] <= wdata;
        4'd9 : rf[9 ] <= wdata;
        4'd10: rf[10] <= wdata;
        4'd11: rf[11] <= wdata;
        4'd12: rf[12] <= wdata;
        4'd13: rf[13] <= wdata;
        4'd14: rf[14] <= wdata;
        4'd15: rf[15] <= wdata;
        default: /* waddr==0 or out of range -> no write */;
      endcase
    end
  end

  // 异步读：避免对 rf[0] 的非法索引，使用case安全选择
  function [DATA_WIDTH-1:0] rf_read;
    input [ADDR_WIDTH-1:0] addr;
    begin
      case (addr)
        4'd0 : rf_read = {DATA_WIDTH{1'b0}}; // x0恒为0
        4'd1 : rf_read = rf[1 ];
        4'd2 : rf_read = rf[2 ];
        4'd3 : rf_read = rf[3 ];
        4'd4 : rf_read = rf[4 ];
        4'd5 : rf_read = rf[5 ];
        4'd6 : rf_read = rf[6 ];
        4'd7 : rf_read = rf[7 ];
        4'd8 : rf_read = rf[8 ];
        4'd9 : rf_read = rf[9 ];
        4'd10: rf_read = rf[10];
        4'd11: rf_read = rf[11];
        4'd12: rf_read = rf[12];
        4'd13: rf_read = rf[13];
        4'd14: rf_read = rf[14];
        4'd15: rf_read = rf[15];
        default: rf_read = {DATA_WIDTH{1'b0}};
      endcase
    end
  endfunction

  assign rs1_data = rf_read(rs1);
  assign rs2_data = rf_read(rs2);

endmodule
