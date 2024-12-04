# Clock Signal (100 MHz onboard clock)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset Button (BTN0)
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Confirm Button (BTN1)
set_property PACKAGE_PIN T18 [get_ports confirm_button]
set_property IOSTANDARD LVCMOS33 [get_ports confirm_button]

# Movement Buttons (Cursor Controls)
set_property PACKAGE_PIN W19 [get_ports move_left]   # BTN2
set_property IOSTANDARD LVCMOS33 [get_ports move_left]

set_property PACKAGE_PIN T17 [get_ports move_right]  # BTN3
set_property IOSTANDARD LVCMOS33 [get_ports move_right]

set_property PACKAGE_PIN U17 [get_ports move_up]     # BTN4
set_property IOSTANDARD LVCMOS33 [get_ports move_up]

set_property PACKAGE_PIN W18 [get_ports move_down]   # BTN5 (Unused on Basys 3)
set_property IOSTANDARD LVCMOS33 [get_ports move_down]

# Switches (8 switches for ASCII input)
set_property PACKAGE_PIN V17 [get_ports {switches[0]}]  # SW0
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]

set_property PACKAGE_PIN V16 [get_ports {switches[1]}]  # SW1
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]

set_property PACKAGE_PIN W16 [get_ports {switches[2]}]  # SW2
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]

set_property PACKAGE_PIN W15 [get_ports {switches[3]}]  # SW3
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]

set_property PACKAGE_PIN V15 [get_ports {switches[4]}]  # SW4
set_property IOSTANDARD LVCMOS33 [get_ports {switches[4]}]

set_property PACKAGE_PIN W14 [get_ports {switches[5]}]  # SW5
set_property IOSTANDARD LVCMOS33 [get_ports {switches[5]}]

set_property PACKAGE_PIN W13 [get_ports {switches[6]}]  # SW6
set_property IOSTANDARD LVCMOS33 [get_ports {switches[6]}]

set_property PACKAGE_PIN V14 [get_ports {switches[7]}]  # SW7
set_property IOSTANDARD LVCMOS33 [get_ports {switches[7]}]

# VGA Signals
set_property PACKAGE_PIN A3 [get_ports vga_red[0]]       # R0
set_property IOSTANDARD LVCMOS33 [get_ports vga_red[0]]

set_property PACKAGE_PIN B4 [get_ports vga_red[1]]       # R1
set_property IOSTANDARD LVCMOS33 [get_ports vga_red[1]]

set_property PACKAGE_PIN A4 [get_ports vga_red[2]]       # R2
set_property IOSTANDARD LVCMOS33 [get_ports vga_red[2]]

set_property PACKAGE_PIN C5 [get_ports vga_green[0]]     # G0
set_property IOSTANDARD LVCMOS33 [get_ports vga_green[0]]

set_property PACKAGE_PIN B5 [get_ports vga_green[1]]     # G1
set_property IOSTANDARD LVCMOS33 [get_ports vga_green[1]]

set_property PACKAGE_PIN A5 [get_ports vga_green[2]]     # G2
set_property IOSTANDARD LVCMOS33 [get_ports vga_green[2]]

set_property PACKAGE_PIN C6 [get_ports vga_blue[0]]      # B0
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue[0]]

set_property PACKAGE_PIN A6 [get_ports vga_blue[1]]      # B1
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue[1]]

set_property PACKAGE_PIN B6 [get_ports vga_blue[2]]      # B2
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue[2]]

set_property PACKAGE_PIN D4 [get_ports vga_hsync]        # HSYNC
set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync]

set_property PACKAGE_PIN D3 [get_ports vga_vsync]        # VSYNC
set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync]
