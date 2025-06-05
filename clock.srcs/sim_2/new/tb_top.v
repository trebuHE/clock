`timescale 1ns / 1ps

module tb_top;

    reg clk;
    reg rst;
    reg button_hr;
    reg button_min;
    reg button_test;
    
    wire [7:0] led_seg;
    wire [7:0] led_an;

    top #(
        .FAST_TICKS_PER_SEC(27'd99),
        .NORMAL_TICKS_PER_SEC(27'd999),
        .DEBOUNCE_TIME_us(0.01)
    )dut(
        .clk_i(clk),
        .rst_i(rst),
        .button_hr_i(button_hr),
        .button_min_i(button_min),
        .button_test_i(button_test),
        .led7_seg_o(led_seg),
        .led7_an_o(led_an)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 0;
        button_hr = 0;
        button_min = 0;
        button_test = 0;
        #1000
        rst = 1;
        #2000
        rst = 0;
        #1000
        button_min = 1;
        #1000
        button_min = 0;
        #1000
        button_hr = 1;
        #1000
        button_hr = 0;
        #1000
        button_test = 1;
        #75000
        button_min = 1;
        #1000
        button_min = 0;
        #1000
        button_hr = 1;
        #1000
        button_hr = 0;
        #1000
        $stop;
    end
endmodule
