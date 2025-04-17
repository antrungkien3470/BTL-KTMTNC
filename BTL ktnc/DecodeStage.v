module DecodeStage (
    input [31:0] id_instruction,
    input clk,
    input [4:0] wb_rd,
    input [31:0] wb_write_data,
    input wb_reg_write,
    output [31:0] id_read_data1,
    output [31:0] id_read_data2,
    output [31:0] id_imm_ext,
    output [4:0] id_rd,
    output id_reg_write,
    output id_alu_src,
    output [1:0] id_alu_op
);
    // Trích xuất các trường từ lệnh
    wire [4:0] rs1, rs2;
    assign rs1 = id_instruction[19:15];
    assign rs2 = id_instruction[24:20];
    assign id_rd = id_instruction[11:7];

    // Đọc thanh ghi
    RegisterFile reg_file (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(wb_rd),
        .write_data(wb_write_data),
        .reg_write(wb_reg_write),
        .read_data1(id_read_data1),
        .read_data2(id_read_data2)
    );

    // Tạo số tức thời
    ImmediateGenerator imm_gen (
        .instruction(id_instruction),
        .imm_ext(id_imm_ext)
    );

    // Tạo tín hiệu điều khiển
    ControlUnit control (
        .opcode(id_instruction[6:0]),
        .reg_write(id_reg_write),
        .alu_src(id_alu_src),
        .alu_op(id_alu_op)
    );
endmodule