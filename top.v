`timescale 1ns / 1ps

module top(
    input clk,          // 100MHz on Basys 3
    input reset,        // btnC on Basys 3
    input btn_u18,       // Button U18 input for triggering
    input [7:0] switches, // 8-bit switch input for ASCII value
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output [11:0] rgb   // to DAC, to VGA connector
    );
    
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    wire btn_debounced;  // Debounced button signal
    wire btn_latched;      // Clean pulse output from button
    reg [7:0] latched_value; // ASCII value based on switches
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    // Text Generation Circuit
    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .rgb(rgb_next),
                  .latched_value (latched_value));  // Pass switch value and button press
    
     // Button debounce
    debounce debounce_inst(
        .clk(clk),
        .reset(reset),
        .btn_in(btn_u18),
        .btn_out(btn_debounced)
    );
    
      // Button pulse generation
    button button_inst(
        .clk(clk),
        .reset(reset),
        .btn_in(btn_debounced),
        .btn_out(btn_latched)
    );

     // Latch the switch value on button press
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            latched_value <= 8'b0; // Reset latched value
        else if (btn_latched)
            latched_value <= switches; // Latch switch value on button press
    end
    
    // rgb buffer
    always @(posedge clk)
        if(w_p_tick)
            rgb_reg <= rgb_next;
            
    // output
    assign rgb = rgb_reg;
      
endmodule
