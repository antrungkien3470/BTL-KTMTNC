module tb_RISC_V;
    reg clk, reset;
    wire [31:0] pc;

    // Instance of RISC_V_Single_Cycle
    RISC_V_Single_Cycle uut (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulation
    initial begin
        reset = 1;
        #10 reset = 0;
        #50; // Ch?y ?? 3 l?nh
        $display("Register x3 (should be 15): %d", uut.reg_file.regs[3]);
        $finish;
    end

    // Monitor for debugging
    initial begin
        $monitor("Time: %0d | PC: %h | Instruction: %h | x1: %d | x2: %d | x3: %d",
                 $time, uut.pc, uut.instruction,
                 uut.reg_file.regs[1], uut.reg_file.regs[2], uut.reg_file.regs[3]);
    end
endmodule