module MemoryStage (
    input [31:0] mem_alu_result,
    output [31:0] mem_write_data
);
    // Không dùng bộ nhớ dữ liệu, truyền thẳng kết quả
    assign mem_write_data = mem_alu_result;
endmodule