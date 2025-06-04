`timescale 1ns / 1ps


module top(
    input wire clk_i,
    input wire rst_i,
    input wire button_hr_i,
    input wire button_min_i,
    input wire button_test_i,
    output reg [7:0] led7_seg_o,
    output reg [7:0] led7_an_o
    );
    
endmodule
