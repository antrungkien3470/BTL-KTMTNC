module ControlUnit (
    input [6:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg [1:0] alu_op
);
    always @(*) begin
        case (opcode)
            7'b0010011: begin // I-type (addi)
                reg_write = 1;
                alu_src = 1; // Dùng immediate
                alu_op = 2'b00;
            end
            7'b0110011: begin // R-type (add)
                reg_write = 1;
                alu_src = 0; // Dùng thanh ghi
                alu_op = 2'b00;
            end
            default: begin
                reg_write = 0;
                alu_src = 0;
                alu_op = 2'b00;
            end
        endcase
    end
endmodule