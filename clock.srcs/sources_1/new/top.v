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
    
    wire rst;
    debouncer #(100_000_000, 10000) db_rst (
        .clk_i(clk_i),
        .noisy_i(rst_i),
        .debounced_o(rst)
        );
        
    wire button_hr;
    debouncer #(100_000_000, 10000) db_hr (
        .clk_i(clk_i),
        .noisy_i(button_hr_i),
        .debounced_o(button_hr)
        );    
    
    wire button_min;
    debouncer #(100_000_000, 10000) db_min (
        .clk_i(clk_i),
        .noisy_i(button_min_i),
        .debounced_o(button_min)
        ); 
        
    wire button_test;
    debouncer #(100_000_000, 10000) db_test (
        .clk_i(clk_i),
        .noisy_i(button_test_i),
        .debounced_o(button_test)
        ); 
    
    wire [4:0] hours;
    wire [5:0] minutes;
    wire [5:0] seconds;
    wire blink;
    clock clock (
        .clk_i(clk_i),
        .rst_i(rst),
        .fast_i(button_test),
        .hours_o(hours),
        .minutes_o(minutes),
        .seconds_o(seconds),
        .blink_o(blink)
        );
        
endmodule
