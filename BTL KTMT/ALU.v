module ALU (
    input [31:0] a, b,
    input [1:0] op,
    output [31:0] result
);
    assign result = a + b; // Chỉ hỗ trợ cộng
endmodule