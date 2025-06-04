`timescale 1ns / 1ps
module debouncer #(
    parameter CLK_FREQ = 100_000_000,
    parameter DEBOUNCE_TIME = 10_000
)(
    input wire clk_i,
    input wire noisy_i,
    output reg debounced_o
);

    localparam integer COUNT_MAX = (CLK_FREQ / 1_000_000) * DEBOUNCE_TIME;

    reg [31:0] counter = 0;
    reg sync_0 = 0;
    reg sync_1 = 0;
    reg stable_state = 0;

    always @(posedge clk_i) begin
        sync_0 <= noisy_i;
        sync_1 <= sync_0;
    end

    always @(posedge clk_i) begin
        if (sync_1 != stable_state) begin
            counter <= 0;
        end else if (counter < COUNT_MAX) begin
            counter <= counter + 1;
        end

        if (counter == COUNT_MAX) begin
            stable_state <= sync_1;
            debounced_o <= sync_1;
        end
    end

endmodule
