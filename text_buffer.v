module text_buffer (
    input clk,
    input write_enable,
    input [6:0] x,           // X-coordinate (column)
    input [4:0] y,           // Y-coordinate (row)
    input [7:0] ascii_code,  // ASCII character to write
    output reg [7:0] character // Character at current position
);

    reg [7:0] buffer [0:79][0:24]; // 80x25 screen buffer for characters

    always @(posedge clk) begin
        if (write_enable) begin
            buffer[x][y] <= ascii_code; // Write character to buffer
        end
    end

    always @(*) begin
        character = buffer[x][y]; // Output the character at current position
    end

endmodule