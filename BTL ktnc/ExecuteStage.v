module ExecuteStage (
    input [31:0] ex_read_data1,
    input [31:0] ex_read_data2,
    input [31:0] ex_imm_ext,
    input ex_alu_src,
    input [1:0] ex_alu_op,
    output [31:0] ex_alu_result
);
    ALU alu (
        .a(ex_read_data1),
        .b(ex_alu_src ? ex_imm_ext : ex_read_data2),
        .op(ex_alu_op),
        .result(ex_alu_result)
    );
endmodule