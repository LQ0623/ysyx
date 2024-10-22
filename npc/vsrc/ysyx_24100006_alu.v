module ysyx_24100006_alu(
    input[31:0] rs_data,
    input[31:0] rt_data,
    output[31:0] rd_data
);

    assign rd_data = rs_data + rt_data;

endmodule
