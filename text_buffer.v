module text_buffer (
    input clk,
    input reset,
    input confirm_button,   // Confirm button to write the character
    input [7:0] ascii_code, // ASCII character to input
    input [6:0] cursor_x,   // X coordinate from the cursor module
    input [4:0] cursor_y,   // Y coordinate from the cursor module
    output reg [7:0] character,  // Character at current position
    output reg write_enable     // Signal to enable writing to the buffer
);

    reg [7:0] buffer [0:24][0:79]; // 80x25 screen buffer for characters

    // Initialize buffer to spaces (ASCII 32)
    integer i, j;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the entire buffer to ASCII space (32)
            for (i = 0; i < 25; i = i + 1) begin
                for (j = 0; j < 80; j = j + 1) begin
                    buffer[i][j] = 8'h20; // ASCII space
                end
            end
            write_enable <= 0;  // Make sure write_enable is low on reset
        end else if (confirm_button) begin
            write_enable <= 1;  // Enable writing to buffer when confirm_button is pressed
            buffer[cursor_y][cursor_x] <= ascii_code;  // Write the ASCII character to the buffer at the current cursor position
        end else begin
            write_enable <= 0;  // Disable writing when button is not pressed
        end
    end

    always @(*) begin
        character = buffer[cursor_y][cursor_x]; // Output the character at the current position
    end

endmodule
