module led_driver (
    input wire clk_i,
    input wire rst_i,
    input wire [31:0] leds_i,
    output reg [3:0] led7_an_o,
    output reg [7:0] led7_seg_o
);
    parameter COUNTER_LIMIT = 18'd199999;
    reg [17:0] counter;
    reg [1:0] current_anode;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            counter <= 18'b0;
            current_anode <= 2'b00;
        end else begin
            if (counter == COUNTER_LIMIT) begin
                counter <= 18'b0;
                current_anode <= current_anode + 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    always @(*) begin
        case (current_anode)
            2'b00: begin
                led7_an_o = 4'b1110;
                led7_seg_o = leds_i[7:0];
            end
            2'b01: begin
                led7_an_o = 4'b1101;
                led7_seg_o = leds_i[15:8];
            end
            2'b10: begin
                led7_an_o = 4'b1011;
                led7_seg_o = leds_i[23:16];
            end
            2'b11: begin
                led7_an_o = 4'b0111;
                led7_seg_o = leds_i[31:24];
            end
            default: begin
                led7_an_o = 4'b1111;
                led7_seg_o = 8'b0;
            end
        endcase
    end
endmodule