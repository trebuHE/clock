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
    
    reg [4:0] hours;
    reg [5:0] minutes;
    reg [5:0] seconds;
    reg blink;
    
    clock clock (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .fast_i(button_test_i),
        .hours_o(hours),
        .minutes_o(minutes),
        .seconds_o(seconds),
        .blink_o(blink)
        );
        
endmodule
