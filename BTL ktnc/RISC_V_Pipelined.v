module RISC_V_Pipelined (
    input clk,
    input reset
);
    // --- Giai đoạn Fetch (IF) ---
    wire [31:0] if_pc, if_instruction;
    FetchStage fetch (
        .clk(clk),
        .reset(reset),
        .if_pc(if_pc),
        .if_instruction(if_instruction)
    );

    // Thanh ghi IF/ID
    wire [31:0] id_pc, id_instruction;
    IF_ID_Register if_id_reg (
        .clk(clk),
        .reset(reset),
        .if_pc(if_pc),
        .if_instruction(if_instruction),
        .id_pc(id_pc),
        .id_instruction(id_instruction)
    );

    // --- Giai đoạn Decode (ID) ---
    wire [31:0] id_read_data1, id_read_data2, id_imm_ext;
    wire [4:0] id_rd;
    wire id_reg_write, id_alu_src;
    wire [1:0] id_alu_op;
    wire [31:0] wb_write_data;
    wire [4:0] wb_rd;
    wire wb_reg_write;
    DecodeStage decode (
        .id_instruction(id_instruction),
        .clk(clk),
        .wb_rd(wb_rd),
        .wb_write_data(wb_write_data),
        .wb_reg_write(wb_reg_write),
        .id_read_data1(id_read_data1),
        .id_read_data2(id_read_data2),
        .id_imm_ext(id_imm_ext),
        .id_rd(id_rd),
        .id_reg_write(id_reg_write),
        .id_alu_src(id_alu_src),
        .id_alu_op(id_alu_op)
    );

    // Thanh ghi ID/EX
    wire [31:0] ex_read_data1, ex_read_data2, ex_imm_ext;
    wire [4:0] ex_rd;
    wire ex_reg_write, ex_alu_src;
    wire [1:0] ex_alu_op;
    ID_EX_Register id_ex_reg (
        .clk(clk),
        .reset(reset),
        .id_read_data1(id_read_data1),
        .id_read_data2(id_read_data2),
        .id_imm_ext(id_imm_ext),
        .id_rd(id_rd),
        .id_reg_write(id_reg_write),
        .id_alu_src(id_alu_src),
        .id_alu_op(id_alu_op),
        .ex_read_data1(ex_read_data1),
        .ex_read_data2(ex_read_data2),
        .ex_imm_ext(ex_imm_ext),
        .ex_rd(ex_rd),
        .ex_reg_write(ex_reg_write),
        .ex_alu_src(ex_alu_src),
        .ex_alu_op(ex_alu_op)
    );

    // --- Giai đoạn Execute (EX) ---
    wire [31:0] ex_alu_result;
    ExecuteStage execute (
        .ex_read_data1(ex_read_data1),
        .ex_read_data2(ex_read_data2),
        .ex_imm_ext(ex_imm_ext),
        .ex_alu_src(ex_alu_src),
        .ex_alu_op(ex_alu_op),
        .ex_alu_result(ex_alu_result)
    );

    // Thanh ghi EX/MEM
    wire [31:0] mem_alu_result;
    wire [4:0] mem_rd;
    wire mem_reg_write;
    EX_MEM_Register ex_mem_reg (
        .clk(clk),
        .reset(reset),
        .ex_alu_result(ex_alu_result),
        .ex_rd(ex_rd),
        .ex_reg_write(ex_reg_write),
        .mem_alu_result(mem_alu_result),
        .mem_rd(mem_rd),
        .mem_reg_write(mem_reg_write)
    );

    // --- Giai đoạn Memory (MEM) ---
    wire [31:0] mem_write_data;
    MemoryStage memory (
        .mem_alu_result(mem_alu_result),
        .mem_write_data(mem_write_data)
    );

    // Thanh ghi MEM/WB
    wire [31:0] wb_write_data_internal;
    wire [4:0] wb_rd_internal;
    wire wb_reg_write_internal;
    MEM_WB_Register mem_wb_reg (
        .clk(clk),
        .reset(reset),
        .mem_write_data(mem_write_data),
        .mem_rd(mem_rd),
        .mem_reg_write(mem_reg_write),
        .wb_write_data(wb_write_data_internal),
        .wb_rd(wb_rd_internal),
        .wb_reg_write(wb_reg_write_internal)
    );

    // --- Giai đoạn Writeback (WB) ---
    WritebackStage writeback (
        .wb_write_data(wb_write_data_internal),
        .wb_rd(wb_rd_internal),
        .wb_reg_write(wb_reg_write_internal),
        .wb_write_data_out(wb_write_data),
        .wb_rd_out(wb_rd),
        .wb_reg_write_out(wb_reg_write)
    );
endmodule