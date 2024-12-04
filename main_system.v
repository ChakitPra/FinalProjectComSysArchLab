module main_system (
    input clk,
    input reset,
    input [7:0] switches,    // Switches for ASCII input
    input confirm_button,    // Button to confirm ASCII input
    input move_left,
    input move_right,
    input move_up,
    input move_down,
    input [9:0] h_pos,       // Horizontal position from VGA controller
    input [9:0] v_pos,       // Vertical position from VGA controller
    output pixel_out         // VGA pixel output
);

    wire [7:0] ascii_code;       // ASCII code to be written to the buffer
    wire [7:0] pixels;           // Pixel data for the current row
    wire write_enable;           // Enable signal to write to the buffer
    wire [6:0] cursor_x;        // X-coordinate of the cursor
    wire [4:0] cursor_y;        // Y-coordinate of the cursor
    wire [7:0] character;       // Character to be rendered at cursor position
    wire [3:0] row;             // Row index (0-15) for the current character based on vertical position

    // Switch-to-ASCII Input Module
    switch_to_ascii input_module (
        .switches(switches),
        .confirm_button(confirm_button),
        .clk(clk),
        .reset(reset),
        .ascii_code(ascii_code),
        .write_enable(write_enable)
    );

    // Text Buffer Module
    text_buffer buffer (
        .clk(clk),
        .write_enable(write_enable),
        .x(cursor_x),
        .y(cursor_y),
        .ascii_code(ascii_code),
        .character(character)
    );

    // Cursor Control Module
    cursor cursor_ctrl (
        .clk(clk),
        .reset(reset),
        .move_left(move_left),
        .move_right(move_right),
        .move_up(move_up),
        .move_down(move_down),
        .x(cursor_x),
        .y(cursor_y)
    );

    // ASCII ROM Module
    ascii_rom rom (
        .ascii_code(character),  // Fetch the character from the buffer
        .row(row),                // Row of the character (0 to 15)
        .pixels(pixels)          // Output pixel data for the current row
    );

    // VGA Renderer Module
    vga_renderer renderer (
        .h_pos(h_pos),            // Horizontal position from VGA controller
        .v_pos(v_pos),            // Vertical position from VGA controller
        .character(character),    // Character at the current cursor position
        .row(row),                // Row index of the current character
        .pixels(pixels),          // Pixel data of the current row
        .pixel_out(pixel_out)     // Output pixel to be displayed on VGA
    );

    // Compute row index (0 to 15) based on vertical position
    assign row = v_pos % 16;  // Each character takes 16 rows (height)

endmodule
