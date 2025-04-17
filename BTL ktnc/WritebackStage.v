module WritebackStage (
    input [31:0] wb_write_data,
    input [4:0] wb_rd,
    input wb_reg_write,
    output [31:0] wb_write_data_out,
    output [4:0] wb_rd_out,
    output wb_reg_write_out
);
    assign wb_write_data_out = wb_write_data;
    assign wb_rd_out = wb_rd;
    assign wb_reg_write_out = wb_reg_write;
endmodule