module vga_renderer (
    input [9:0] h_pos,       // Horizontal pixel position
    input [9:0] v_pos,       // Vertical pixel position
    input [7:0] character,   // Current ASCII character from text buffer
    input [3:0] row,         // Row within the character (0-15)
    input [7:0] pixels,      // Pixel data for the current row
    output reg pixel_out     // Output pixel
);

    always @(*) begin
        if (h_pos < 640 && v_pos < 480) begin
            // Determine which pixel in the row to display
            pixel_out = pixels[7 - (h_pos % 8)];
        end else begin
            pixel_out = 0; // Black background outside valid area
        end
    end

endmodule