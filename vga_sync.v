module vga_sync
    (
        input wire clk, reset, // 25 MHz clock, resettable through button press
        output wire hsync, vsync, video_on,  // Signals for sync and video enable
        output wire [9:0] x, y // Pixel position (x, y)
    );
    
    // Constant declarations for VGA sync parameters (640x480 @ 60Hz)
    localparam H_DISPLAY       = 640;  // Horizontal display area
    localparam H_L_BORDER      = 48;   // Horizontal left border (same as back porch)
    localparam H_R_BORDER      = 16;   // Horizontal right border (same as front porch)
    localparam H_RETRACE       = 96;   // Horizontal retrace (sync pulse)
    localparam H_MAX           = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;  // 799
    localparam START_H_RETRACE = H_DISPLAY + H_R_BORDER; // 640 + 16 = 656
    localparam END_H_RETRACE   = H_DISPLAY + H_R_BORDER + H_RETRACE - 1; // 640 + 16 + 96 - 1 = 751
    
    localparam V_DISPLAY       = 480;  // Vertical display area
    localparam V_T_BORDER      = 10;   // Vertical top border
    localparam V_B_BORDER      = 33;   // Vertical bottom border
    localparam V_RETRACE       = 2;    // Vertical retrace (sync pulse)
    localparam V_MAX           = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1; // 524
    localparam START_V_RETRACE = V_DISPLAY + V_B_BORDER; // 480 + 33 = 513
    localparam END_V_RETRACE   = V_DISPLAY + V_B_BORDER + V_RETRACE - 1; // 514
    
    // Mod-4 counter to generate 25 MHz pixel tick
    reg [1:0] pixel_reg;  // Current state
    wire [1:0] pixel_next; // Next state
    wire pixel_tick;  // Increment signal
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            pixel_reg <= 0;  // Reset pixel counter
        else
            pixel_reg <= pixel_next;  // Update to next state
    end
    
    assign pixel_next = pixel_reg + 1;  // Increment pixel_reg 
    assign pixel_tick = (pixel_reg == 0);  // When pixel_reg becomes 2'b11 it rolls over to 0
    
    // Registers to keep track of current pixel location
    reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
    
    // Registers for hsync and vsync signal states
    reg vsync_reg, hsync_reg;
    wire vsync_next, hsync_next;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            v_count_reg <= 0;
            h_count_reg <= 0;
            vsync_reg   <= 0;
            hsync_reg   <= 0;
        end else begin
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
            vsync_reg   <= vsync_next;
            hsync_reg   <= hsync_next;
        end
    end
    
    // Next-state logic for horizontal and vertical sync counters
    always @* begin
        // Horizontal counter logic
        h_count_next = pixel_tick ? (h_count_reg == H_MAX ? 0 : h_count_reg + 1) : h_count_reg;
        
        // Vertical counter logic
        v_count_next = pixel_tick && h_count_reg == H_MAX ? (v_count_reg == V_MAX ? 0 : v_count_reg + 1) : v_count_reg;
    end
    
    // Horizontal sync signal (active low)
    assign hsync_next = (h_count_reg >= START_H_RETRACE && h_count_reg <= END_H_RETRACE);
    
    // Vertical sync signal (active low)
    assign vsync_next = (v_count_reg >= START_V_RETRACE && v_count_reg <= END_V_RETRACE);
    
    // Video on signal (active within the display area)
    assign video_on = (h_count_reg < H_DISPLAY) && (v_count_reg < V_DISPLAY);
    
    // Output signals
    assign hsync  = hsync_reg;
    assign vsync  = vsync_reg;
    assign x      = h_count_reg;
    assign y      = v_count_reg;
    
endmodule
