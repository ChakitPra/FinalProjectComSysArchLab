module switch_to_ascii (
    input [7:0] switches,        // 8 switches for ASCII input
    input confirm_button,        // Button to confirm ASCII input
    input clk,                   // Clock signal
    input reset,                 // Reset signal
    output reg [7:0] ascii_code, // Output ASCII code
    output reg write_enable      // Write enable for the text buffer
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ascii_code <= 8'b0;   // Reset ASCII code
            write_enable <= 1'b0; // Disable writing
        end else if (confirm_button) begin
            ascii_code <= switches;  // Assign switches directly to ASCII code
            write_enable <= 1'b1;    // Enable writing
        end else begin
            write_enable <= 1'b0;    // Disable writing when confirm button is not pressed
        end
    end

endmodule