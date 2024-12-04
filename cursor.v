module cursor (
    input clk,
    input reset,
    input move_left,
    input move_right,
    input move_up,
    input move_down,
    output reg [6:0] x,  // Cursor X position (0 to 79)
    output reg [4:0] y   // Cursor Y position (0 to 24)
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            x <= 0;
            y <= 0; // Reset cursor position to top-left
        end else begin
            if (move_left && x > 0) x <= x - 1;
            if (move_right && x < 79) x <= x + 1;
            if (move_up && y > 0) y <= y - 1;
            if (move_down && y < 24) y <= y + 1;
        end
    end
endmodule
