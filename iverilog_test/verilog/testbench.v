`timescale 1ns/1ps

module testbench;
    reg clock = 1'b0;
    reg reset = 1'b1;
    integer cycle_count = 0;

    // 时钟
    always #5 clock = ~clock;  // 100MHz

    // 复位（对齐若干个上升沿）
    initial begin
        repeat (20) @(posedge clock);
        reset = 1'b0;
    end

    // 计数
    always @(posedge clock) begin
        cycle_count <= cycle_count + 1;
    end

    // 波形
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
    end

    // 监控
    initial begin
        $display("Starting simulation at time %t", $time);
        @(negedge reset);
        $display("Reset released at time %t", $time);
    end

    // ========= X 检查器（复位后第 N 拍开始）=========
    localparam XCHK_START = 50;

    `define ASSERT_NO_X(sig) \
        if ((^sig) === 1'bx) begin \
            $display("[%0t] **X detected**: %s", $time, `"sig`"); \
            $stop; \
        end

    // always @(posedge clock) begin
    //     if (!reset && cycle_count >= XCHK_START) begin
    //         // 把你关心的信号列出来（举例）：
    //         `ASSERT_NO_X(u_npc.is_break_M)
    //         `ASSERT_NO_X(u_npc.mem_in_valid)
    //         // 若还有流水寄存器/状态机/pc 等，请继续加
    //     end
    // end

    // 成功检测（按你的条件）
    always @(posedge clock) begin
        if (!reset && u_npc.is_break_M && u_npc.mem_in_valid) begin
            $display();
            $display("a0 is %x", u_npc.u_ID.GPR.rf[10]);
            if(u_npc.u_ID.GPR.rf[10] == 0)begin
                $display("SUCCESS detected at cycle %d", cycle_count);
            end else begin
                $display("FAILURE detected at cycle %d", cycle_count);
            end
            #100 $finish;
        end
    end

    // 实例化 DUT —— 按你现有端口保持不变
    ysyx_24100006 u_npc(
        .clock(clock),
        .reset(reset)
    );
endmodule
