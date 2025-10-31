/**
  系统寄存器堆（面积优化版）
  - 去除 MuxKey，使用 case 进行译码
  - 仅为可写 CSR 建立寄存器：MTVEC、MEPC、MCAUSE
  - MSTATUS/MVENDORID/MARCHID 直接组合逻辑返回常量
  - 写入与中断处理放在同一 always 块中（irq 优先）
*/
`timescale 1ns/1ps

`define ysyx_24100006_MSTATUS   12'h300
`define ysyx_24100006_MTVEC     12'h305
`define ysyx_24100006_MCAUSE    12'h342
`define ysyx_24100006_MEPC      12'h341
`define ysyx_24100006_MVENDORID 12'hF11   // 厂商 ID（Vendor ID）
`define ysyx_24100006_MARCHID   12'hF12   // 架构 ID（Architecture ID）

module ysyx_24100006_CSR #(
  parameter ADDR_WIDTH = 12,
  parameter DATA_WIDTH = 32
)(
  input                       clk,
  input                       irq,
  input       [DATA_WIDTH-1:0] wdata,
  input       [ADDR_WIDTH-1:0] waddr,
  input                       wen,
  input       [ADDR_WIDTH-1:0] raddr,          // csr 指令的 31-20 位
  output reg  [DATA_WIDTH-1:0] rdata,
  output reg  [DATA_WIDTH-1:0] mtvec,
  output reg  [DATA_WIDTH-1:0] mepc
);

  // ===== 只读/常量 CSR（组合逻辑返回，不占用触发器） =====
  // 与原实现保持一致
  localparam [DATA_WIDTH-1:0] MSTATUS_CONST   = 32'h00001800; // 原代码固定写为 0x1800
  localparam [DATA_WIDTH-1:0] MVENDORID_CONST = 32'h79737978; // 'ysyx'
  localparam [DATA_WIDTH-1:0] MARCHID_CONST   = 32'd24100006; // 工程 ID

  // ===== 写入与中断处理（合并为一个时序块；irq 优先） =====
  always @(posedge clk) begin
    if (irq) begin
      // 中断到来：记录中断返回地址
      mepc   <= wdata;                             // 与原实现一致：irq 时 mepc <- wdata
    end
    else if (wen) begin
      // 普通 CSR 写：仅允许写 MTVEC/MEPC/MCAUSE
      case (waddr)
        `ysyx_24100006_MTVEC:  mtvec  <= wdata;
        `ysyx_24100006_MEPC:   mepc   <= wdata;
        default: ; // 其他 CSR 忽略写（MSTATUS/MVENDORID/MARCHID 为只读/常量）
      endcase
    end
  end

  // ===== CSR 读：组合译码 =====
  always @* begin
    case (raddr)
      `ysyx_24100006_MSTATUS:   rdata = MSTATUS_CONST;    // 只读常量
      `ysyx_24100006_MTVEC:     rdata = mtvec;            // 可写寄存器
      `ysyx_24100006_MCAUSE:    rdata = 32'hb;           // 可写寄存器
      `ysyx_24100006_MEPC:      rdata = mepc;             // 可写寄存器
      `ysyx_24100006_MVENDORID: rdata = MVENDORID_CONST;  // 只读常量
      `ysyx_24100006_MARCHID:   rdata = MARCHID_CONST;    // 只读常量
      default:    rdata = {DATA_WIDTH{1'b0}};
    endcase
  end

`ifndef __ICARUS__
import "DPI-C" function void get_csr(
	input int mstatus, 
	input int mtvec, 
	input int mcause, 
	input int mepc
);
  always @(*) begin
    get_csr(32'h00001800, mtvec, 32'hb, mepc);
  end

`endif




endmodule
