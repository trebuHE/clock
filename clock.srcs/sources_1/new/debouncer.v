module debouncer #(
    parameter CLK_FREQ = 100_000_000,
    parameter DEBOUNCE_TIME = 10_000 // in us
)(
    input wire clk_i,
    input wire noisy_i,
    output reg debounced_o = 0
);

    localparam integer COUNT_MAX = (CLK_FREQ / 1_000_000) * DEBOUNCE_TIME;

    reg [31:0] counter = 0;
    reg sync_0 = 0;
    reg sync_1 = 0;

    always @(posedge clk_i) begin
        sync_0 <= noisy_i;
        sync_1 <= sync_0;
    end

    always @(posedge clk_i) begin
        if (sync_1 != debounced_o) begin
            counter <= counter + 1;
            if (counter == COUNT_MAX) begin
                debounced_o <= sync_1;
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end
    end

endmodule
