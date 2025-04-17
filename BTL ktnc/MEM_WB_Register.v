module MEM_WB_Register (
    input clk,
    input reset,
    input [31:0] mem_write_data,
    input [4:0] mem_rd,
    input mem_reg_write,
    output reg [31:0] wb_write_data,
    output reg [4:0] wb_rd,
    output reg wb_reg_write
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wb_write_data <= 0;
            wb_rd <= 0;
            wb_reg_write <= 0;
        end else begin
            wb_write_data <= mem_write_data;
            wb_rd <= mem_rd;
            wb_reg_write <= mem_reg_write;
        end
    end
endmodule