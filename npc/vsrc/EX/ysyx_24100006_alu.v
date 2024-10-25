module ysyx_24100006_alu(
    input[31:0]     rs_data,
    input[31:0]     rt_data,
    input[3:0]      aluop,
    output[31:0]    result,
    output          of,
    output          cf,
    output          zf //  是否为0
);

    wire[31:0] complement;  // 补码
    wire[31:0] add_sub_result;

    assign complement = rt_data^{32{aluop[0]}};
	/* verilator lint_off WIDTHEXPAND */
	assign {cf,add_sub_result} = rs_data + complement + aluop[0];
	/* verilator lint_off WIDTHEXPAND */
    assign of = (~(rs_data[31]^complement[31]))&(rs_data[31]^add_sub_result[31]);


    ysyx_24100006_MuxKey #(2,4,32)  alumux(result,aluop,{
        4'b0000,add_sub_result,
        4'b0001,add_sub_result
    });

    assign zf = ~(|result);

endmodule
