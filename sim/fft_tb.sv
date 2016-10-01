`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2016 22:03:40
// Design Name: 
// Module Name: fft_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fft_tb();
    
    logic [11:0]    din;
    logic [79:0]    dout;
    logic           start;
    logic           stop;
    logic clk;    
    
    integer file_in;
    integer statusI;
    
    logic [79:0] dout_sig;
    
    
     always  #  0.01 clk = ~clk; 
    
    initial begin
        file_in  = $fopen("D:/userdata/apantol/Desktop/fft/radix2FFT/radix2FFT.srcs/sim_1/new/sine.txt","r");
        clk     <= 1'b0;
        din     <= 12'h000;
                    
     repeat (8) begin
       while ( ! $feof(file_in)) begin
            @ (negedge clk);
            statusI = $fscanf(file_in,"%d\n",din[11:0]);
            @ (negedge clk);
        end
    end
    
    end
    
        //always @(posedge clk) din <= din + 512;
        
        assign dout_sig = ($signed(dout) < 0) ? -$signed(dout) : dout; //absolute value
        
    fft fft_inst
    (
        .clock  (clk),
        .reset  (1'b0),
        .din    (din),
        .start  (start),
        .stop   (stop),
        .dout   (dout)
    );
    
endmodule
