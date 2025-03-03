module ysyx_24100006_cpu(
	input clk,
	input reset
);

	wire [31:0] pc,npc;
	wire [31:0] npc;
    // control signal from IDU
    wire PCW;

    wire [31:0] pc;
    wire [31:0] instruction;   // 读出的指令
	ysyx_24100006_ifu IF(
		.clk(clk),
		.reset(reset),
		.PCW(PCW),
		.pc(pc),
		.instruction(instruction)
	);
	
	always @(posedge PCW) begin
		if(instruction == 32'h00100073)begin
			$display(" %x %x %x %x",Jump,pc,instruction_temp,instruction);
		end
	end

endmodule
