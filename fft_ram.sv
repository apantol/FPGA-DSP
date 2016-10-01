`timescale 1ns / 1ps

module fft_ram
#(  parameter WIDTH = 16,
    parameter DEPTH = 1024,
    parameter WDDRM = $clog2(DEPTH))
    (
    input logic                 clk,
    input logic                 ena,
    input logic                 rst,
    input logic                 wren,
    input logic                 arm_read,
    input logic  [WIDTH - 1:0]  wrdata,
    output logic [WIDTH - 1:0]  rddata
    );
    
    int i;
    
    logic                     [WDDRM - 1:0] rd_addr;
    logic                     [WDDRM - 1:0] rd_addr_d;

    logic                     [WDDRM - 1:0] wr_addr;
    logic signed [DEPTH - 1:0][WIDTH - 1:0] wr_mem;
    logic signed [DEPTH - 1:0][WIDTH - 1:0] rd_mem;
    
    logic write_ena;
    logic read_ena;
    
    logic read_rq;
    
    always @(posedge clk)
    begin
        if(rst) begin
            for(i = 0; i < DEPTH; i++) begin
                wr_mem <= 16'd0;
            end
        end else begin
            if(~wren) begin
                wr_addr         <= wr_addr + 10'd1;
                wr_mem[wr_addr] <= wrdata;
            end else begin
                wr_addr         <= 10'd0;
            end
        end
    end
    
    always @(posedge clk)
    begin
        if(rst) begin
            rd_addr_d <= 10'd0;
        end else begin
            rd_addr_d <= rd_addr;
        end
    end
    
    always @(posedge clk)
    begin
        if(rst) begin
            for(i = 0; i < DEPTH; i++) begin
                rd_mem <= 16'd0;
            end
            read_rq <= 1'b0;
            
        end else begin
            if(wren & arm_read) begin
                rd_mem  <= wr_mem;
                read_rq <= 1'b1;
            end else if(read_rq) begin
                if(~rd_addr && rd_addr_d) begin
                    read_rq <= 1'b0;
                end else begin
                    rd_addr <= rd_addr + 1;
                    rddata  <= rd_mem[rd_addr];
                end
            end
        end
    end

    
    
endmodule
