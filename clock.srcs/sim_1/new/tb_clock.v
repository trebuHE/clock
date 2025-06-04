`timescale 1ns / 1ps

module tb_clock;

    reg clk_i;       
    reg rst_i;
    reg fast_i;
    reg button_min;
    reg button_hr;
 
    wire [4:0] hours_o;
    wire [5:0] minutes_o;
    wire [5:0] seconds_o;
    wire blink_o;
       
    clock dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .fast_i(fast_i),
        .button_min_i(button_min),
        .button_hr_i(button_hr),
        .hours_o(hours_o),
        .minutes_o(minutes_o),
        .seconds_o(seconds_o),
        .blink_o(blink_o)
        );
        
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end

    initial begin
        rst_i = 1;
        button_hr = 0;
        button_min = 0;
        #100
        rst_i = 0;
        #100
        fast_i = 1;
        #100;
        fast_i = 1;
        #10
        button_min = 1;
        #20
        button_min = 0;
        #20
        button_hr = 1;
        #20 
        button_hr = 0;
    end

endmodule

