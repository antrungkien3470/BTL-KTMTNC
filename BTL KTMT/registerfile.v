module RegisterFile (
    input clk,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    input reg_write,
    output [31:0] read_data1, read_data2
);
    reg [31:0] regs[0:31]; // 32 thanh ghi

    // Đọc đồng bộ
    assign read_data1 = (rs1 == 0) ? 32'b0 : regs[rs1];
    assign read_data2 = (rs2 == 0) ? 32'b0 : regs[rs2];

    // Ghi đồng bộ
    always @(posedge clk) begin
        if (reg_write && rd != 0)
            regs[rd] <= write_data;
    end
endmodule