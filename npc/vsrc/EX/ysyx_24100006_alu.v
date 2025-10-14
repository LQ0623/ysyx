module ysyx_24100006_alu (
    input  [31:0] rs_data,
    input  [31:0] rt_data,
    input  [3:0]  aluop,
    output [31:0] result,
    output        of,
    output        cf,
    output        zf
);
    // opcode
    localparam OP_ADD  = 4'b0000;
    localparam OP_SUB  = 4'b0001;
    localparam OP_OR   = 4'b0010;
    localparam OP_SLT  = 4'b0011;
    localparam OP_SRL  = 4'b0100;
    localparam OP_SRA  = 4'b0101;
    localparam OP_SLL  = 4'b0110;
    localparam OP_AND  = 4'b0111;
    localparam OP_XOR  = 4'b1000;
    localparam OP_SLTU = 4'b1001;

    // 加/减共用加法器；slt/sltu 也要减
    wire is_sub = (aluop == OP_SUB) | (aluop == OP_SLT) | (aluop == OP_SLTU);
    wire [31:0] b_sel = rt_data ^ {32{is_sub}};
    wire [31:0] add_sub_result;
    wire        cf_raw;
    assign {cf_raw, add_sub_result} = rs_data + b_sel + {31'b0, is_sub};

    // 溢出只对 add/sub 有意义
    wire of_raw = (~(rs_data[31] ^ b_sel[31])) & (rs_data[31] ^ add_sub_result[31]);

    // 逻辑运算（OR 由 XOR^AND 得到，避免再一棵 OR 树）
    wire [31:0] and_result = rs_data & rt_data;
    wire [31:0] xor_result = rs_data ^ rt_data;
    wire [31:0] or_result  = xor_result ^ and_result;

    // 单套右移桶形 + 位反转实现 SLL
    wire [4:0]  shamt = rt_data[4:0];
    wire        is_sll = (aluop == OP_SLL);
    wire        is_sra = (aluop == OP_SRA);

    wire [31:0] sh_in = is_sll ? bitrev32(rs_data) : rs_data;
    wire        fill  = is_sra ? rs_data[31]       : 1'b0;
    wire [31:0] sh_r  = rshift_var(sh_in, shamt, fill);

    wire [31:0] srl_sra_result = sh_r;
    wire [31:0] sll_result     = bitrev32(sh_r);

    // 比较 1bit 后再扩展
    wire sltu_bit = ~cf_raw;
    wire a31 = rs_data[31], b31 = rt_data[31];
    wire slt_bit = (a31 & ~b31) | ( ~(a31 ^ b31) & add_sub_result[31] );

    // 结果选择
    reg [31:0] res;
    always @* begin
        case (aluop)
            OP_ADD, OP_SUB: res = add_sub_result;
            OP_OR:          res = or_result;
            OP_SLT:         res = {31'b0, slt_bit};
            OP_SRL:         res = srl_sra_result;
            OP_SRA:         res = srl_sra_result;
            OP_SLL:         res = sll_result;
            OP_AND:         res = and_result;
            OP_XOR:         res = xor_result;
            OP_SLTU:        res = {31'b0, sltu_bit};
            default:        res = 32'b0;
        endcase
    end

    assign result = res;
    assign zf     = ~|res;

    // cf/of 只在 add/sub 导出，其他置 0，利于上游剪枝
    wire is_addsub = (aluop == OP_ADD) | (aluop == OP_SUB);
    assign cf = is_addsub ? cf_raw : 1'b0;
    assign of = is_addsub ? of_raw : 1'b0;

    // ===== 工具函数（Verilog-2001 兼容） =====
    function [31:0] rshift_var;
        input [31:0] x;
        input [4:0]  s;
        input        fill;
        reg [31:0] t;
        begin
            t = s[0] ? {fill,       x[31:1]}  : x;
            t = s[1] ? {{2{fill}},  t[31:2]}  : t;
            t = s[2] ? {{4{fill}},  t[31:4]}  : t;
            t = s[3] ? {{8{fill}},  t[31:8]}  : t;
            t = s[4] ? {{16{fill}}, t[31:16]} : t;
            rshift_var = t;
        end
    endfunction

    function [31:0] bitrev32;
        input [31:0] x;
        integer i;
        begin
            for (i = 0; i < 32; i = i + 1)
                bitrev32[i] = x[31 - i];
        end
    endfunction
endmodule
