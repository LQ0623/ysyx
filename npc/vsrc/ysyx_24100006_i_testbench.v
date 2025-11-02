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
    // initial begin
    //     $dumpfile("wave.vcd");
    //     $dumpvars(0, testbench);
    // end

    // 监控
    initial begin
        $display("Starting simulation at time %t", $time);
        @(negedge reset);
        $display("Reset released at time %t", $time);
    end

    // ========= X 检查器 =========
    localparam XCHK_START = 50;

    `define ASSERT_NO_X(sig) \
        if ((^sig) === 1'bx) begin \
            $display("[%0t] **X detected**: %s", $time, `"sig`"); \
            $stop; \
        end

    // 成功检测
    always @(posedge clock) begin
        if (!reset && u_npc.is_break_M && u_npc.mem_in_valid) begin
            $display();
            $display("==========================================");
            $display("Test completed");
            $display("Exit code (a0): %x", u_npc.u_ID.GPR.rf[10]);
            if(u_npc.u_ID.GPR.rf[10] == 0)begin
                $display("SUCCESS detected at cycle %d", cycle_count);
            end else begin
                $display("FAILURE detected at cycle %d", cycle_count);
            end
            $display("==========================================");
            #100 $finish;
        end
    end
    
    // 检测是否卡死
    localparam MAX_CYCLES = 100;
    reg [31:0] cnt;
    reg [31:0] prev_pc;
    
    always @(posedge clock) begin
        if(reset)begin
            cnt <= 0;
        end else if(prev_pc == u_npc.u_ID.pc_D) begin
            cnt <= cnt + 1;
        end else begin
            cnt <= 0;
        end
    end

    always @(posedge clock) begin
        if(reset)begin
            prev_pc <= 0;
        end else begin
            prev_pc <= u_npc.u_ID.pc_D;
        end
    end

    always @(*) begin
        if(cnt > MAX_CYCLES) begin
            $display("==========================================");
            $display("ERROR: Simulation timed out");
            $display("  PC stuck at: 0x%h", u_npc.u_ID.pc_D);
            $display("  For %d cycles", cnt);
            $display("==========================================");
            $finish;
        end
    end

    // 实例化 DUT
    ysyx_24100006 u_npc(
        .clock(clock),
        .reset(reset)
    );
endmodule