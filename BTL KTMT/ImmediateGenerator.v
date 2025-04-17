module ImmediateGenerator (
    input [31:0] instruction,
    output [31:0] imm_ext
);
    // Chỉ hỗ trợ I-type (addi)
    assign imm_ext = {{20{instruction[31]}}, instruction[31:20]};
endmodule