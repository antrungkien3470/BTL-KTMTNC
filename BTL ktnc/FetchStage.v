module FetchStage (
    input clk,
    input reset,
    output [31:0] if_pc,
    output [31:0] if_instruction
);
    // Program Counter
    reg [31:0] pc;
    wire [31:0] pc_next;
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc_next;
    end
    assign pc_next = pc + 4; // Tăng PC, không hỗ trợ nhảy

    // Lấy lệnh từ bộ nhớ
    InstructionMemory instr_mem (
        .address(pc),
        .instruction(if_instruction)
    );

    // Xuất PC
    assign if_pc = pc;
endmodule