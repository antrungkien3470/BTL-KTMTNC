module EX_MEM_Register (
    input clk,
    input reset,
    input [31:0] ex_alu_result,
    input [4:0] ex_rd,
    input ex_reg_write,
    output reg [31:0] mem_alu_result,
    output reg [4:0] mem_rd,
    output reg mem_reg_write
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mem_alu_result <= 0;
            mem_rd <= 0;
            mem_reg_write <= 0;
        end else begin
            mem_alu_result <= ex_alu_result;
            mem_rd <= ex_rd;
            mem_reg_write <= ex_reg_write;
        end
    end
endmodule