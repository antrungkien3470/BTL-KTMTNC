module ID_EX_Register (
    input clk,
    input reset,
    input [31:0] id_read_data1,
    input [31:0] id_read_data2,
    input [31:0] id_imm_ext,
    input [4:0] id_rd,
    input id_reg_write,
    input id_alu_src,
    input [1:0] id_alu_op,
    output reg [31:0] ex_read_data1,
    output reg [31:0] ex_read_data2,
    output reg [31:0] ex_imm_ext,
    output reg [4:0] ex_rd,
    output reg ex_reg_write,
    output reg ex_alu_src,
    output reg [1:0] ex_alu_op
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ex_read_data1 <= 0;
            ex_read_data2 <= 0;
            ex_imm_ext <= 0;
            ex_rd <= 0;
            ex_reg_write <= 0;
            ex_alu_src <= 0;
            ex_alu_op <= 0;
        end else begin
            ex_read_data1 <= id_read_data1;
            ex_read_data2 <= id_read_data2;
            ex_imm_ext <= id_imm_ext;
            ex_rd <= id_rd;
            ex_reg_write <= id_reg_write;
            ex_alu_src <= id_alu_src;
            ex_alu_op <= id_alu_op;
        end
    end
endmodule