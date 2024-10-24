module ysyx_24100006_decode(
    input [31:0] instruction,
    output [2:0] aluop,
    output reg_write,
    output mem_write,


);
    wire [:0] op = instruction[:];
    wire [:0] func = instruction[];

    wire add;
    assign add=op[0]== & func[]:
    assign sub=op

    assign aluop=add?0:
                 sub?1:
                 mul?2:
                 sll?

endmodule