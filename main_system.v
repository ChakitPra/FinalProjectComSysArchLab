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

    wire [7:0] ascii_code;
    wire [7:0] pixels;
    wire write_enable;
    wire [6:0] cursor_x;
    wire [4:0] cursor_y;
    wire [7:0] character;
    wire [3:0] row = v_pos % 16; // Compute the row index (0-15) for current character

    // Switch-to-ASCII Input
    switch_to_ascii input_module (
        .switches(switches),
        .confirm_button(confirm_button),
        .clk(clk),
        .reset(reset),
        .ascii_code(ascii_code),
        .write_enable(write_enable)
    );

    // Text Buffer
    text_buffer buffer (
        .clk(clk),
        .write_enable(write_enable),
        .x(cursor_x),
        .y(cursor_y),
        .ascii_code(ascii_code),
        .character(character)
    );

    // Cursor Control
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

    // ASCII ROM
    ascii_rom rom (
        .ascii_code(character), // Fetch the current character from the buffer
        .row(row),
        .pixels(pixels)         // Output the row's pixel data
    );

    // VGA Renderer
    vga_renderer renderer (
        .h_pos(h_pos),
        .v_pos(v_pos),
        .character(character),
        .row(row),
        .pixels(pixels),
        .pixel_out(pixel_out)
    );

endmodule