module InstructionMemory (
    input [31:0] address,
    output [31:0] instruction
);
    reg [31:0] mem[0:63]; // B? nh? l?nh 64 t?, m?i t? 32-bit

    initial begin
        mem[0] = 32'h00500093; // addi x1, x0, 5
        mem[1] = 32'h00a00113; // addi x2, x0, 10
        mem[2] = 32'h002081b3; // add x3, x1, x2
    end

    assign instruction = mem[address[7:2]]; // Chia ??a ch? cho 4 (byte -> word)
endmodule