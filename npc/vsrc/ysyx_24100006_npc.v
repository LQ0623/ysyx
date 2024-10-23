module ysyx_24100006_npc(
    input[31:0] pc,
    output[31:0] npc
);

    assign npc = pc + 4;

endmodule

