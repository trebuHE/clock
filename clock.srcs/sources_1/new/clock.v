module clock (
    input wire clk_i,       
    input wire rst_i,
    input wire fast_i,
    input wire button_min_i,
    input wire button_hr_i,
    output reg [4:0] hours_o,
    output reg [5:0] minutes_o,
    output reg [5:0] seconds_o,
    output reg blink_o
);

    reg [26:0] tick_counter;
    wire [26:0] tick_limit;

    reg button_min_i_prev;
    reg button_hr_i_prev;

    assign tick_limit = fast_i ? 27'd99999 : 27'd99999999;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            tick_counter <= 0;
            seconds_o <= 0;
            minutes_o <= 0;
            hours_o <= 0;
            blink_o <= 0;
            button_min_i_prev <= 0;
            button_hr_i_prev <= 0;
        end else begin
            button_min_i_prev <= button_min_i;
            button_hr_i_prev <= button_hr_i;

            if (button_min_i && !button_min_i_prev) begin
                if (minutes_o == 59)
                    minutes_o <= 0;
                else
                    minutes_o <= minutes_o + 1;
            end
            else if (button_hr_i && !button_hr_i_prev) begin
                if (hours_o == 23)
                    hours_o <= 0;
                else
                    hours_o <= hours_o + 1;
            end
            else if (tick_counter == tick_limit) begin
                tick_counter <= 0;
                blink_o <= ~blink_o;

                if (seconds_o == 59) begin
                    seconds_o <= 0;
                    if (minutes_o == 59) begin
                        minutes_o <= 0;
                        if (hours_o == 23)
                            hours_o <= 0;
                        else
                            hours_o <= hours_o + 1;
                    end else begin
                        minutes_o <= minutes_o + 1;
                    end
                end else begin
                    seconds_o <= seconds_o + 1;
                end
            end else begin
                tick_counter <= tick_counter + 1;
            end
        end
    end

endmodule
