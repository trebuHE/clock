`timescale 1ns / 1ps

module top #(
    parameter DEBOUNCE_TIME_us = 10_000,
    parameter FAST_TICKS_PER_SEC = 27'd9999999,
    parameter NORMAL_TICKS_PER_SEC =27'd99999999
)(
    input wire clk_i,
    input wire rst_i,
    input wire button_hr_i,
    input wire button_min_i,
    input wire button_test_i,
    output reg [7:0] led7_seg_o,
    output reg [7:0] led7_an_o
    );
    
    wire rst;
    debouncer #(100_000_000, DEBOUNCE_TIME_us) db_rst (
        .clk_i(clk_i),
        .noisy_i(rst_i),
        .debounced_o(rst)
        );
        
    wire button_hr;
    debouncer #(100_000_000, DEBOUNCE_TIME_us) db_hr (
        .clk_i(clk_i),
        .noisy_i(button_hr_i),
        .debounced_o(button_hr)
        );    
    
    wire button_min;
    debouncer #(100_000_000, DEBOUNCE_TIME_us) db_min (
        .clk_i(clk_i),
        .noisy_i(button_min_i),
        .debounced_o(button_min)
        ); 
        
    wire button_test;
    debouncer #(100_000_000, DEBOUNCE_TIME_us) db_test (
        .clk_i(clk_i),
        .noisy_i(button_test_i),
        .debounced_o(button_test)
        ); 
    
    wire [4:0] hours;
    wire [5:0] minutes;
    wire [5:0] seconds;
    wire blink;
    clock #(
        .FAST_TICKS_PER_SEC(FAST_TICKS_PER_SEC),
        .NORMAL_TICKS_PER_SEC(NORMAL_TICKS_PER_SEC)
) clock (
        .clk_i(clk_i),
        .rst_i(rst),
        .fast_i(button_test),
        .button_min_i(button_min),
        .button_hr_i(button_hr),
        .hours_o(hours),
        .minutes_o(minutes),
        .seconds_o(seconds),
        .blink_o(blink)
        );
        
    wire [31:0] leds;
    encoder encoder (
        .hours_i(hours),
        .minutes_i(minutes),
        .blink_i(blink),
        .leds_o(leds)
        ); 
    
    wire [3:0] led_an_muxed;
    wire [7:0] led_seg_muxed; 
    led_driver #(.COUNTER_LIMIT(18'd99999)) led (
        .clk_i(clk_i),
        .rst_i(rst),
        .leds_i(leds),
        .led7_an_o(led_an_muxed),
        .led7_seg_o(led_seg_muxed)
    );
    
    always @(*) begin 
        led7_an_o[7:4] = 4'b1111;
        led7_an_o[3:0] = led_an_muxed;
        led7_seg_o = led_seg_muxed;
    end
        
endmodule
