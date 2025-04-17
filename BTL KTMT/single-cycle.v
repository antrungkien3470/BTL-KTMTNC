module RISC_V_Single_Cycle (
    input clk,
    input reset,
    output [31:0] pc
);
    // Wires
    wire [31:0] pc_next, instruction, read_data1, read_data2, write_data;
    wire [31:0] alu_result, imm_ext;
    wire reg_write, alu_src;
    wire [1:0] alu_op;

    // Program Counter
    ProgramCounter pc_reg (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );

    // Instruction Memory
    InstructionMemory instr_mem (
        .address(pc),
        .instruction(instruction)
    );

    // Register File
    RegisterFile reg_file (
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Immediate Generator
    ImmediateGenerator imm_gen (
        .instruction(instruction),
        .imm_ext(imm_ext)
    );

    // ALU
    ALU alu (
        .a(read_data1),
        .b(alu_src ? imm_ext : read_data2),
        .op(alu_op),
        .result(alu_result)
    );

    // Control Unit
    ControlUnit control (
        .opcode(instruction[6:0]),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .alu_op(alu_op)
    );

    // PC Next
    assign pc_next = pc + 4; // Chỉ tăng PC, không hỗ trợ nhảy

    // Writeback
    assign write_data = alu_result; // Kết quả ALU ghi thẳng vào thanh ghi
endmodule