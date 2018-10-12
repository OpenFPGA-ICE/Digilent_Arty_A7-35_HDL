 ## CLK100MHZ:0
set_property LOC E3 [get_ports CLK100MHZ]
set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
 ## serial:0.tx
set_property LOC D10 [get_ports serial_tx]
set_property IOSTANDARD LVCMOS33 [get_ports serial_tx]
 ## serial:0.rx
set_property LOC A9 [get_ports serial_rx]
set_property IOSTANDARD LVCMOS33 [get_ports serial_rx]
 ## button:0
set_property LOC D9 [get_ports button0]
set_property IOSTANDARD LVCMOS33 [get_ports button0]
 ## button:1
set_property LOC C9 [get_ports button1]
set_property IOSTANDARD LVCMOS33 [get_ports button1]
 ## button:2
set_property LOC B9 [get_ports button2]
set_property IOSTANDARD LVCMOS33 [get_ports button2]
 ## button:3
set_property LOC B8 [get_ports button3]
set_property IOSTANDARD LVCMOS33 [get_ports button3]
 ## switch:0
set_property LOC A8 [get_ports switch0]
set_property IOSTANDARD LVCMOS33 [get_ports switch0]
 ## switch:1
set_property LOC C11 [get_ports switch1]
set_property IOSTANDARD LVCMOS33 [get_ports switch1]
 ## switch:2
set_property LOC C10 [get_ports switch2]
set_property IOSTANDARD LVCMOS33 [get_ports switch2]
 ## switch:3
set_property LOC A10 [get_ports switch3]
set_property IOSTANDARD LVCMOS33 [get_ports switch3]
 ## Monoled:0
set_property LOC H5 [get_ports Monoled0]
set_property IOSTANDARD LVCMOS33 [get_ports Monoled0]
 ## Monoled:1
set_property LOC J5 [get_ports Monoled1]
set_property IOSTANDARD LVCMOS33 [get_ports Monoled1]
 ## Monoled:2
set_property LOC T9 [get_ports Monoled2]
set_property IOSTANDARD LVCMOS33 [get_ports Monoled2]
 ## Monoled:3
set_property LOC T10 [get_ports Monoled3]
set_property IOSTANDARD LVCMOS33 [get_ports Monoled3]
 ## RGBled:0.r
set_property LOC G6 [get_ports RGBled0_r]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled0_r]
 ## RGBled:0.g
set_property LOC F6 [get_ports RGBled0_g]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled0_g]
 ## RGBled:0.b
set_property LOC E1 [get_ports RGBled0_b]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled0_b]
 ## RGBled:1.r
set_property LOC G3 [get_ports RGBled1_r]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled1_r]
 ## RGBled:1.g
set_property LOC J4 [get_ports RGBled1_g]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled1_g]
 ## RGBled:1.b
set_property LOC G4 [get_ports RGBled1_b]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled1_b]
 ## RGBled:2.r
set_property LOC J3 [get_ports RGBled2_r]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled2_r]
 ## RGBled:2.g
set_property LOC J2 [get_ports RGBled2_g]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled2_g]
 ## RGBled:2.b
set_property LOC H4 [get_ports RGBled2_b]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled2_b]
 ## RGBled:3.r
set_property LOC K1 [get_ports RGBled3_r]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled3_r]
 ## RGBled:3.g
set_property LOC H6 [get_ports RGBled3_g]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled3_g]
 ## RGBled:3.b
set_property LOC K2 [get_ports RGBled3_b]
set_property IOSTANDARD LVCMOS33 [get_ports RGBled3_b]

create_clock -name CLK100MHZ -period 10.0 [get_nets CLK100MHZ]

set_false_path -quiet -to [get_nets -filter {mr_ff == TRUE}]

set_false_path -quiet -to [get_pins -filter {REF_PIN_NAME == PRE} -of [get_cells -filter {ars_ff1 == TRUE || ars_ff2 == TRUE}]]

set_max_delay 2 -quiet -from [get_pins -filter {REF_PIN_NAME == Q} -of [get_cells -filter {ars_ff1 == TRUE}]] -to [get_pins -filter {REF_PIN_NAME == D} -of [get_cells -filter {ars_ff2 == TRUE}]]