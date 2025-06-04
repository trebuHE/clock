`timescale 1ns / 1ps

module tb_clock;

    reg clk_i;       
    reg rst_i;
    reg fast_i;

    wire [4:0] hours_o;
    wire [5:0] minutes_o;
    wire [5:0] seconds_o;
    wire blink_o;
    
    clock dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .fast_i(fast_i),
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
        fast_i = 0;
        #100;
        rst_i = 0;
        fast_i = 1;
    end

endmodule

