module tb_RISC_V_Pipelined;
    reg clk, reset;

    // Instance của RISC_V_Pipelined
    RISC_V_Pipelined uut (
        .clk(clk),
        .reset(reset)
    );

    // Tạo đồng hồ
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ 10 ps
    end

    // Mô phỏng
    initial begin
        reset = 1;
        #10 reset = 0;
        #100; // Chạy đủ để thực thi 3 lệnh qua đường ống
        $display("Final Register x3 (should be 15): %d", uut.decode.reg_file.regs[3]);
        $finish;
    end

    // Theo dõi các thanh ghi đường ống
    initial begin
        $monitor("Time: %0d | PC: %h | IF/ID Instr: %h | ID/EX rs1: %d, rs2: %d, imm: %d | EX/MEM ALU: %d | MEM/WB rd: %d, data: %d",
                 $time, uut.fetch.pc,
                 uut.if_id_reg.id_instruction,
                 uut.id_ex_reg.ex_read_data1, uut.id_ex_reg.ex_read_data2, uut.id_ex_reg.ex_imm_ext,
                 uut.ex_mem_reg.mem_alu_result,
                 uut.mem_wb_reg.wb_rd, uut.mem_wb_reg.wb_write_data);
    end
endmodule