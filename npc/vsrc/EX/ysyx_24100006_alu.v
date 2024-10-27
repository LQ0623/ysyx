module ysyx_24100006_alu(
    input[31:0]     rs_data,
    input[31:0]     rt_data,
    input[3:0]      aluop,
    output[31:0]    result,
    output          of,
    output          cf,
    output          zf //  是否为0
);

    wire [31:0]     complement;  // 补码
    wire [31:0]     add_sub_result;
    wire [31:0]     and_result;
	wire [31:0]     or_result;
	wire [31:0]     xor_result;
	wire [31:0]     cmp_result;
	wire [31:0]     cmpu_result;
	wire [31:0]     sra_result;
	wire [31:0]     srl_result;
	wire [31:0]     sll_result;

    assign complement   = rt_data^{32{aluop[0]}};
	/* verilator lint_off WIDTHEXPAND */
	assign {cf,add_sub_result} = rs_data + complement + aluop[0];
	/* verilator lint_off WIDTHEXPAND */
    assign of           = (~(rs_data[31]^complement[31]))&(rs_data[31]^add_sub_result[31]);
    assign and_result   = rs_data&rt_data;
	assign or_result    = rs_data|rt_data;
	assign xor_result   = rs_data^rt_data;
	assign cmpu_result  = (|rt_data) ? {31'b0,{~cf}} : 32'b0; 
	assign cmp_result   = {31'b0,{add_sub_result[31]^of}};
	assign sra_result   = ($signed(rs_data)) >>> rt_data[4:0];
	assign srl_result   = rs_data >> rt_data[4:0];
	assign sll_result   = rs_data << rt_data[4:0];

    ysyx_24100006_MuxKey #(2,4,32)  alumux(result,aluop,{
        4'b0000,add_sub_result,
        4'b0001,add_sub_result,
        4'b0010,cmpu_result,
		4'b0011,cmp_result,
		4'b0100,srl_result,
		4'b0101,sra_result,
		4'b0110,sll_result,
		4'b0111,and_result,
		4'b1000,xor_result,
		4'b1001,or_result
    });

    assign zf = ~(|result);

endmodule
