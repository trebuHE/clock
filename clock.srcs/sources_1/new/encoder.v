module encoder (
    input wire [4:0] hours_i,
    input wire [5:0] minutes_i,
    input wire blink_i,
    output reg [31:0] leds_o
);

    function [6:0] Encode;
        input [3:0] value;
        begin
            case (value)
                4'b0000: Encode = 7'b0000001;
                4'b0001: Encode = 7'b1001111;
                4'b0010: Encode = 7'b0010010;
                4'b0011: Encode = 7'b0110000;
                4'b0100: Encode = 7'b1001100;
                4'b0101: Encode = 7'b0100100;
                4'b0110: Encode = 7'b0100000;
                4'b0111: Encode = 7'b0001111;
                4'b1000: Encode = 7'b0000000;
                4'b1001: Encode = 7'b0000100;
                default: Encode = 7'b1111111;
            endcase
        end
    endfunction

    reg [3:0] hours_tens, hours_ones;
    reg [3:0] minutes_tens, minutes_ones;

    always @(hours_i, minutes_i) begin
        hours_tens = hours_i / 10;
        hours_ones = hours_i % 10;
        minutes_tens = minutes_i / 10;
        minutes_ones = minutes_i % 10;
    end

    always @(hours_i, minutes_i, blink_i, hours_tens, hours_ones, minutes_tens, minutes_ones) begin
        leds_o[31:25] = Encode(hours_tens);
        leds_o[23:17] = Encode(hours_ones);
        leds_o[15:9]  = Encode(minutes_tens);
        leds_o[7:1]   = Encode(minutes_ones);
        leds_o[24] = blink_i ? 1'b0 : 1'b1;
        leds_o[16] = 1'b1;
        leds_o[8]  = 1'b1;
        leds_o[0]  = 1'b1;
    end

endmodule