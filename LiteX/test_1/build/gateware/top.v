/* Machine-generated using LiteX gen */
module top(
	input CLK100MHZ,
	output reg serial_tx,
	input serial_rx,
	input button0,
	input button1,
	input button2,
	input button3,
	input switch0,
	input switch1,
	input switch2,
	input switch3,
	output Monoled0,
	output Monoled1,
	output Monoled2,
	output Monoled3,
	output RGBled0_r,
	output RGBled0_g,
	output RGBled0_b,
	output RGBled1_r,
	output RGBled1_g,
	output RGBled1_b,
	output RGBled2_r,
	output RGBled2_g,
	output RGBled2_b,
	output RGBled3_r,
	output RGBled3_g,
	output RGBled3_b
);

wire basesoc_reset_reset_re;
wire basesoc_reset_reset_r;
reg basesoc_reset_reset_w = 1'd0;
reg [31:0] basesoc_storage_full = 32'd305419896;
wire [31:0] basesoc_storage;
reg basesoc_re = 1'd0;
wire [31:0] basesoc_bus_errors_status;
wire basesoc_reset;
wire basesoc_bus_error;
reg [31:0] basesoc_bus_errors = 32'd0;
wire [29:0] basesoc_sram_bus_adr;
wire [31:0] basesoc_sram_bus_dat_w;
wire [31:0] basesoc_sram_bus_dat_r;
wire [3:0] basesoc_sram_bus_sel;
wire basesoc_sram_bus_cyc;
wire basesoc_sram_bus_stb;
reg basesoc_sram_bus_ack = 1'd0;
wire basesoc_sram_bus_we;
wire [2:0] basesoc_sram_bus_cti;
wire [1:0] basesoc_sram_bus_bte;
reg basesoc_sram_bus_err = 1'd0;
wire [9:0] basesoc_sram_adr;
wire [31:0] basesoc_sram_dat_r;
reg [3:0] basesoc_sram_we = 4'd0;
wire [31:0] basesoc_sram_dat_w;
reg [13:0] basesoc_interface_adr = 14'd0;
reg basesoc_interface_we = 1'd0;
reg [31:0] basesoc_interface_dat_w = 32'd0;
wire [31:0] basesoc_interface_dat_r;
wire [29:0] basesoc_wishbone2csr_adr;
wire [31:0] basesoc_wishbone2csr_dat_w;
reg [31:0] basesoc_wishbone2csr_dat_r = 32'd0;
wire [3:0] basesoc_wishbone2csr_sel;
wire basesoc_wishbone2csr_cyc;
wire basesoc_wishbone2csr_stb;
reg basesoc_wishbone2csr_ack = 1'd0;
wire basesoc_wishbone2csr_we;
wire [2:0] basesoc_wishbone2csr_cti;
wire [1:0] basesoc_wishbone2csr_bte;
reg basesoc_wishbone2csr_err = 1'd0;
reg [1:0] basesoc_wishbone2csr_counter = 2'd0;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg int_rst = 1'd1;
reg [31:0] uartwishbonebridge_storage = 32'd4947802;
reg uartwishbonebridge_tx_valid = 1'd0;
reg uartwishbonebridge_tx_ready = 1'd0;
wire uartwishbonebridge_tx_last;
reg [7:0] uartwishbonebridge_tx_payload_data = 8'd0;
reg uartwishbonebridge_tx_uart_clk_txen = 1'd0;
reg [31:0] uartwishbonebridge_tx_phase_accumulator_tx = 32'd0;
reg [7:0] uartwishbonebridge_tx_tx_reg = 8'd0;
reg [3:0] uartwishbonebridge_tx_tx_bitcount = 4'd0;
reg uartwishbonebridge_tx_tx_busy = 1'd0;
reg uartwishbonebridge_rx_valid = 1'd0;
wire uartwishbonebridge_rx_ready;
reg [7:0] uartwishbonebridge_rx_payload_data = 8'd0;
reg uartwishbonebridge_rx_uart_clk_rxen = 1'd0;
reg [31:0] uartwishbonebridge_rx_phase_accumulator_rx = 32'd0;
wire uartwishbonebridge_rx_rx;
reg uartwishbonebridge_rx_rx_r = 1'd0;
reg [7:0] uartwishbonebridge_rx_rx_reg = 8'd0;
reg [3:0] uartwishbonebridge_rx_rx_bitcount = 4'd0;
reg uartwishbonebridge_rx_rx_busy = 1'd0;
wire [29:0] uartwishbonebridge_adr;
wire [31:0] uartwishbonebridge_dat_w;
wire [31:0] uartwishbonebridge_dat_r;
wire [3:0] uartwishbonebridge_sel;
reg uartwishbonebridge_cyc = 1'd0;
reg uartwishbonebridge_stb = 1'd0;
wire uartwishbonebridge_ack;
reg uartwishbonebridge_we = 1'd0;
reg [2:0] uartwishbonebridge_cti = 3'd0;
reg [1:0] uartwishbonebridge_bte = 2'd0;
wire uartwishbonebridge_err;
reg [2:0] uartwishbonebridge_byte_counter = 3'd0;
reg uartwishbonebridge_byte_counter_reset = 1'd0;
reg uartwishbonebridge_byte_counter_ce = 1'd0;
reg [2:0] uartwishbonebridge_word_counter = 3'd0;
reg uartwishbonebridge_word_counter_reset = 1'd0;
reg uartwishbonebridge_word_counter_ce = 1'd0;
reg [7:0] uartwishbonebridge_cmd = 8'd0;
reg uartwishbonebridge_cmd_ce = 1'd0;
reg [7:0] uartwishbonebridge_length = 8'd0;
reg uartwishbonebridge_length_ce = 1'd0;
reg [31:0] uartwishbonebridge_address = 32'd0;
reg uartwishbonebridge_address_ce = 1'd0;
reg [31:0] uartwishbonebridge_data = 32'd0;
reg uartwishbonebridge_rx_data_ce = 1'd0;
reg uartwishbonebridge_tx_data_ce = 1'd0;
wire uartwishbonebridge_reset;
wire uartwishbonebridge_wait;
wire uartwishbonebridge_done;
reg [23:0] uartwishbonebridge_count = 24'd10000000;
reg uartwishbonebridge_is_ongoing = 1'd0;
wire [3:0] buttons_status;
wire [3:0] switches_status;
reg [3:0] leds_storage_full = 4'd0;
wire [3:0] leds_storage;
reg leds_re = 1'd0;
reg [7:0] rgbled0_r_storage_full = 8'd0;
wire [7:0] rgbled0_r_storage;
reg rgbled0_r_re = 1'd0;
reg [7:0] rgbled0_r_counter = 8'd0;
reg [7:0] rgbled0_g_storage_full = 8'd0;
wire [7:0] rgbled0_g_storage;
reg rgbled0_g_re = 1'd0;
reg [7:0] rgbled0_g_counter = 8'd0;
reg [7:0] rgbled0_b_storage_full = 8'd0;
wire [7:0] rgbled0_b_storage;
reg rgbled0_b_re = 1'd0;
reg [7:0] rgbled0_b_counter = 8'd0;
reg [7:0] rgbled1_r_storage_full = 8'd0;
wire [7:0] rgbled1_r_storage;
reg rgbled1_r_re = 1'd0;
reg [7:0] rgbled1_r_counter = 8'd0;
reg [7:0] rgbled1_g_storage_full = 8'd0;
wire [7:0] rgbled1_g_storage;
reg rgbled1_g_re = 1'd0;
reg [7:0] rgbled1_g_counter = 8'd0;
reg [7:0] rgbled1_b_storage_full = 8'd0;
wire [7:0] rgbled1_b_storage;
reg rgbled1_b_re = 1'd0;
reg [7:0] rgbled1_b_counter = 8'd0;
reg [7:0] rgbled2_r_storage_full = 8'd0;
wire [7:0] rgbled2_r_storage;
reg rgbled2_r_re = 1'd0;
reg [7:0] rgbled2_r_counter = 8'd0;
reg [7:0] rgbled2_g_storage_full = 8'd0;
wire [7:0] rgbled2_g_storage;
reg rgbled2_g_re = 1'd0;
reg [7:0] rgbled2_g_counter = 8'd0;
reg [7:0] rgbled2_b_storage_full = 8'd0;
wire [7:0] rgbled2_b_storage;
reg rgbled2_b_re = 1'd0;
reg [7:0] rgbled2_b_counter = 8'd0;
reg [7:0] rgbled3_r_storage_full = 8'd0;
wire [7:0] rgbled3_r_storage;
reg rgbled3_r_re = 1'd0;
reg [7:0] rgbled3_r_counter = 8'd0;
reg [7:0] rgbled3_g_storage_full = 8'd0;
wire [7:0] rgbled3_g_storage;
reg rgbled3_g_re = 1'd0;
reg [7:0] rgbled3_g_counter = 8'd0;
reg [7:0] rgbled3_b_storage_full = 8'd0;
wire [7:0] rgbled3_b_storage;
reg rgbled3_b_re = 1'd0;
reg [7:0] rgbled3_b_counter = 8'd0;
reg [2:0] state = 3'd0;
reg [2:0] next_state = 3'd0;
wire [29:0] shared_adr;
wire [31:0] shared_dat_w;
reg [31:0] shared_dat_r = 32'd0;
wire [3:0] shared_sel;
wire shared_cyc;
wire shared_stb;
reg shared_ack = 1'd0;
wire shared_we;
wire [2:0] shared_cti;
wire [1:0] shared_bte;
wire shared_err;
wire request;
wire grant;
reg [1:0] slave_sel = 2'd0;
reg [1:0] slave_sel_r = 2'd0;
reg error = 1'd0;
wire wait_1;
wire done;
reg [16:0] count = 17'd65536;
wire [13:0] interface0_bank_bus_adr;
wire interface0_bank_bus_we;
wire [31:0] interface0_bank_bus_dat_w;
reg [31:0] interface0_bank_bus_dat_r = 32'd0;
wire csrbank0_in_re;
wire [3:0] csrbank0_in_r;
wire [3:0] csrbank0_in_w;
wire csrbank0_sel;
wire [13:0] interface1_bank_bus_adr;
wire interface1_bank_bus_we;
wire [31:0] interface1_bank_bus_dat_w;
reg [31:0] interface1_bank_bus_dat_r = 32'd0;
wire csrbank1_scratch0_re;
wire [31:0] csrbank1_scratch0_r;
wire [31:0] csrbank1_scratch0_w;
wire csrbank1_bus_errors_re;
wire [31:0] csrbank1_bus_errors_r;
wire [31:0] csrbank1_bus_errors_w;
wire csrbank1_sel;
wire [13:0] sram_bus_adr;
wire sram_bus_we;
wire [31:0] sram_bus_dat_w;
reg [31:0] sram_bus_dat_r = 32'd0;
wire [5:0] adr;
wire [7:0] dat_r;
wire sel;
reg sel_r = 1'd0;
wire [13:0] interface2_bank_bus_adr;
wire interface2_bank_bus_we;
wire [31:0] interface2_bank_bus_dat_w;
reg [31:0] interface2_bank_bus_dat_r = 32'd0;
wire csrbank2_out0_re;
wire [3:0] csrbank2_out0_r;
wire [3:0] csrbank2_out0_w;
wire csrbank2_sel;
wire [13:0] interface3_bank_bus_adr;
wire interface3_bank_bus_we;
wire [31:0] interface3_bank_bus_dat_w;
reg [31:0] interface3_bank_bus_dat_r = 32'd0;
wire csrbank3_r_duty0_re;
wire [7:0] csrbank3_r_duty0_r;
wire [7:0] csrbank3_r_duty0_w;
wire csrbank3_g_duty0_re;
wire [7:0] csrbank3_g_duty0_r;
wire [7:0] csrbank3_g_duty0_w;
wire csrbank3_b_duty0_re;
wire [7:0] csrbank3_b_duty0_r;
wire [7:0] csrbank3_b_duty0_w;
wire csrbank3_sel;
wire [13:0] interface4_bank_bus_adr;
wire interface4_bank_bus_we;
wire [31:0] interface4_bank_bus_dat_w;
reg [31:0] interface4_bank_bus_dat_r = 32'd0;
wire csrbank4_r_duty0_re;
wire [7:0] csrbank4_r_duty0_r;
wire [7:0] csrbank4_r_duty0_w;
wire csrbank4_g_duty0_re;
wire [7:0] csrbank4_g_duty0_r;
wire [7:0] csrbank4_g_duty0_w;
wire csrbank4_b_duty0_re;
wire [7:0] csrbank4_b_duty0_r;
wire [7:0] csrbank4_b_duty0_w;
wire csrbank4_sel;
wire [13:0] interface5_bank_bus_adr;
wire interface5_bank_bus_we;
wire [31:0] interface5_bank_bus_dat_w;
reg [31:0] interface5_bank_bus_dat_r = 32'd0;
wire csrbank5_r_duty0_re;
wire [7:0] csrbank5_r_duty0_r;
wire [7:0] csrbank5_r_duty0_w;
wire csrbank5_g_duty0_re;
wire [7:0] csrbank5_g_duty0_r;
wire [7:0] csrbank5_g_duty0_w;
wire csrbank5_b_duty0_re;
wire [7:0] csrbank5_b_duty0_r;
wire [7:0] csrbank5_b_duty0_w;
wire csrbank5_sel;
wire [13:0] interface6_bank_bus_adr;
wire interface6_bank_bus_we;
wire [31:0] interface6_bank_bus_dat_w;
reg [31:0] interface6_bank_bus_dat_r = 32'd0;
wire csrbank6_r_duty0_re;
wire [7:0] csrbank6_r_duty0_r;
wire [7:0] csrbank6_r_duty0_w;
wire csrbank6_g_duty0_re;
wire [7:0] csrbank6_g_duty0_r;
wire [7:0] csrbank6_g_duty0_w;
wire csrbank6_b_duty0_re;
wire [7:0] csrbank6_b_duty0_r;
wire [7:0] csrbank6_b_duty0_w;
wire csrbank6_sel;
wire [13:0] interface7_bank_bus_adr;
wire interface7_bank_bus_we;
wire [31:0] interface7_bank_bus_dat_w;
reg [31:0] interface7_bank_bus_dat_r = 32'd0;
wire csrbank7_in_re;
wire [3:0] csrbank7_in_r;
wire [3:0] csrbank7_in_w;
wire csrbank7_sel;
reg [29:0] array_muxed0 = 30'd0;
reg [31:0] array_muxed1 = 32'd0;
reg [3:0] array_muxed2 = 4'd0;
reg array_muxed3 = 1'd0;
reg array_muxed4 = 1'd0;
reg array_muxed5 = 1'd0;
reg [2:0] array_muxed6 = 3'd0;
reg [1:0] array_muxed7 = 2'd0;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg xilinxmultiregimpl0_regs0 = 1'd0;
(* async_reg = "true", dont_touch = "true" *) reg xilinxmultiregimpl0_regs1 = 1'd0;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg [3:0] xilinxmultiregimpl1_regs0 = 4'd0;
(* async_reg = "true", dont_touch = "true" *) reg [3:0] xilinxmultiregimpl1_regs1 = 4'd0;
wire xilinxmultiregimpl1;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg [3:0] xilinxmultiregimpl2_regs0 = 4'd0;
(* async_reg = "true", dont_touch = "true" *) reg [3:0] xilinxmultiregimpl2_regs1 = 4'd0;
wire xilinxmultiregimpl2;

assign basesoc_bus_error = error;
assign basesoc_reset = basesoc_reset_reset_re;
assign basesoc_bus_errors_status = basesoc_bus_errors;
always @(*) begin
	basesoc_sram_we <= 4'd0;
	basesoc_sram_we[0] <= (((basesoc_sram_bus_cyc & basesoc_sram_bus_stb) & basesoc_sram_bus_we) & basesoc_sram_bus_sel[0]);
	basesoc_sram_we[1] <= (((basesoc_sram_bus_cyc & basesoc_sram_bus_stb) & basesoc_sram_bus_we) & basesoc_sram_bus_sel[1]);
	basesoc_sram_we[2] <= (((basesoc_sram_bus_cyc & basesoc_sram_bus_stb) & basesoc_sram_bus_we) & basesoc_sram_bus_sel[2]);
	basesoc_sram_we[3] <= (((basesoc_sram_bus_cyc & basesoc_sram_bus_stb) & basesoc_sram_bus_we) & basesoc_sram_bus_sel[3]);
end
assign basesoc_sram_adr = basesoc_sram_bus_adr[9:0];
assign basesoc_sram_bus_dat_r = basesoc_sram_dat_r;
assign basesoc_sram_dat_w = basesoc_sram_bus_dat_w;
assign sys_clk = CLK100MHZ;
assign por_clk = CLK100MHZ;
assign sys_rst = int_rst;
assign uartwishbonebridge_reset = uartwishbonebridge_done;
assign uartwishbonebridge_rx_ready = 1'd1;
assign uartwishbonebridge_adr = (uartwishbonebridge_address + uartwishbonebridge_word_counter);
assign uartwishbonebridge_dat_w = uartwishbonebridge_data;
assign uartwishbonebridge_sel = 4'd15;
always @(*) begin
	uartwishbonebridge_tx_payload_data <= 8'd0;
	case (uartwishbonebridge_byte_counter)
		1'd0: begin
			uartwishbonebridge_tx_payload_data <= uartwishbonebridge_data[31:24];
		end
		1'd1: begin
			uartwishbonebridge_tx_payload_data <= uartwishbonebridge_data[23:16];
		end
		2'd2: begin
			uartwishbonebridge_tx_payload_data <= uartwishbonebridge_data[15:8];
		end
		default: begin
			uartwishbonebridge_tx_payload_data <= uartwishbonebridge_data[7:0];
		end
	endcase
end
assign uartwishbonebridge_wait = (~uartwishbonebridge_is_ongoing);
assign uartwishbonebridge_tx_last = ((uartwishbonebridge_byte_counter == 2'd3) & (uartwishbonebridge_word_counter == (uartwishbonebridge_length - 1'd1)));
always @(*) begin
	uartwishbonebridge_tx_valid <= 1'd0;
	uartwishbonebridge_word_counter_ce <= 1'd0;
	uartwishbonebridge_cyc <= 1'd0;
	uartwishbonebridge_is_ongoing <= 1'd0;
	uartwishbonebridge_stb <= 1'd0;
	uartwishbonebridge_cmd_ce <= 1'd0;
	next_state <= 3'd0;
	uartwishbonebridge_length_ce <= 1'd0;
	uartwishbonebridge_we <= 1'd0;
	uartwishbonebridge_address_ce <= 1'd0;
	uartwishbonebridge_rx_data_ce <= 1'd0;
	uartwishbonebridge_byte_counter_reset <= 1'd0;
	uartwishbonebridge_tx_data_ce <= 1'd0;
	uartwishbonebridge_byte_counter_ce <= 1'd0;
	uartwishbonebridge_word_counter_reset <= 1'd0;
	next_state <= state;
	case (state)
		1'd1: begin
			if (uartwishbonebridge_rx_valid) begin
				uartwishbonebridge_length_ce <= 1'd1;
				next_state <= 2'd2;
			end
		end
		2'd2: begin
			if (uartwishbonebridge_rx_valid) begin
				uartwishbonebridge_address_ce <= 1'd1;
				uartwishbonebridge_byte_counter_ce <= 1'd1;
				if ((uartwishbonebridge_byte_counter == 2'd3)) begin
					if ((uartwishbonebridge_cmd == 1'd1)) begin
						next_state <= 2'd3;
					end else begin
						if ((uartwishbonebridge_cmd == 2'd2)) begin
							next_state <= 3'd5;
						end
					end
					uartwishbonebridge_byte_counter_reset <= 1'd1;
				end
			end
		end
		2'd3: begin
			if (uartwishbonebridge_rx_valid) begin
				uartwishbonebridge_rx_data_ce <= 1'd1;
				uartwishbonebridge_byte_counter_ce <= 1'd1;
				if ((uartwishbonebridge_byte_counter == 2'd3)) begin
					next_state <= 3'd4;
					uartwishbonebridge_byte_counter_reset <= 1'd1;
				end
			end
		end
		3'd4: begin
			uartwishbonebridge_stb <= 1'd1;
			uartwishbonebridge_we <= 1'd1;
			uartwishbonebridge_cyc <= 1'd1;
			if (uartwishbonebridge_ack) begin
				uartwishbonebridge_word_counter_ce <= 1'd1;
				if ((uartwishbonebridge_word_counter == (uartwishbonebridge_length - 1'd1))) begin
					next_state <= 1'd0;
				end else begin
					next_state <= 2'd3;
				end
			end
		end
		3'd5: begin
			uartwishbonebridge_stb <= 1'd1;
			uartwishbonebridge_we <= 1'd0;
			uartwishbonebridge_cyc <= 1'd1;
			if (uartwishbonebridge_ack) begin
				uartwishbonebridge_tx_data_ce <= 1'd1;
				next_state <= 3'd6;
			end
		end
		3'd6: begin
			uartwishbonebridge_tx_valid <= 1'd1;
			if (uartwishbonebridge_tx_ready) begin
				uartwishbonebridge_byte_counter_ce <= 1'd1;
				if ((uartwishbonebridge_byte_counter == 2'd3)) begin
					uartwishbonebridge_word_counter_ce <= 1'd1;
					if ((uartwishbonebridge_word_counter == (uartwishbonebridge_length - 1'd1))) begin
						next_state <= 1'd0;
					end else begin
						next_state <= 3'd5;
						uartwishbonebridge_byte_counter_reset <= 1'd1;
					end
				end
			end
		end
		default: begin
			if (uartwishbonebridge_rx_valid) begin
				uartwishbonebridge_cmd_ce <= 1'd1;
				if (((uartwishbonebridge_rx_payload_data == 1'd1) | (uartwishbonebridge_rx_payload_data == 2'd2))) begin
					next_state <= 1'd1;
				end
				uartwishbonebridge_byte_counter_reset <= 1'd1;
				uartwishbonebridge_word_counter_reset <= 1'd1;
			end
			uartwishbonebridge_is_ongoing <= 1'd1;
		end
	endcase
end
assign uartwishbonebridge_done = (uartwishbonebridge_count == 1'd0);
assign {Monoled3, Monoled2, Monoled1, Monoled0} = leds_storage;
assign RGBled0_r = (rgbled0_r_counter < rgbled0_r_storage);
assign RGBled0_g = (rgbled0_g_counter < rgbled0_g_storage);
assign RGBled0_b = (rgbled0_b_counter < rgbled0_b_storage);
assign RGBled1_r = (rgbled1_r_counter < rgbled1_r_storage);
assign RGBled1_g = (rgbled1_g_counter < rgbled1_g_storage);
assign RGBled1_b = (rgbled1_b_counter < rgbled1_b_storage);
assign RGBled2_r = (rgbled2_r_counter < rgbled2_r_storage);
assign RGBled2_g = (rgbled2_g_counter < rgbled2_g_storage);
assign RGBled2_b = (rgbled2_b_counter < rgbled2_b_storage);
assign RGBled3_r = (rgbled3_r_counter < rgbled3_r_storage);
assign RGBled3_g = (rgbled3_g_counter < rgbled3_g_storage);
assign RGBled3_b = (rgbled3_b_counter < rgbled3_b_storage);
assign shared_adr = array_muxed0;
assign shared_dat_w = array_muxed1;
assign shared_sel = array_muxed2;
assign shared_cyc = array_muxed3;
assign shared_stb = array_muxed4;
assign shared_we = array_muxed5;
assign shared_cti = array_muxed6;
assign shared_bte = array_muxed7;
assign uartwishbonebridge_dat_r = shared_dat_r;
assign uartwishbonebridge_ack = (shared_ack & (grant == 1'd0));
assign uartwishbonebridge_err = (shared_err & (grant == 1'd0));
assign request = {uartwishbonebridge_cyc};
assign grant = 1'd0;
always @(*) begin
	slave_sel <= 2'd0;
	slave_sel[0] <= (shared_adr[28:26] == 1'd1);
	slave_sel[1] <= (shared_adr[28:26] == 3'd6);
end
assign basesoc_sram_bus_adr = shared_adr;
assign basesoc_sram_bus_dat_w = shared_dat_w;
assign basesoc_sram_bus_sel = shared_sel;
assign basesoc_sram_bus_stb = shared_stb;
assign basesoc_sram_bus_we = shared_we;
assign basesoc_sram_bus_cti = shared_cti;
assign basesoc_sram_bus_bte = shared_bte;
assign basesoc_wishbone2csr_adr = shared_adr;
assign basesoc_wishbone2csr_dat_w = shared_dat_w;
assign basesoc_wishbone2csr_sel = shared_sel;
assign basesoc_wishbone2csr_stb = shared_stb;
assign basesoc_wishbone2csr_we = shared_we;
assign basesoc_wishbone2csr_cti = shared_cti;
assign basesoc_wishbone2csr_bte = shared_bte;
assign basesoc_sram_bus_cyc = (shared_cyc & slave_sel[0]);
assign basesoc_wishbone2csr_cyc = (shared_cyc & slave_sel[1]);
assign shared_err = (basesoc_sram_bus_err | basesoc_wishbone2csr_err);
assign wait_1 = ((shared_stb & shared_cyc) & (~shared_ack));
always @(*) begin
	shared_dat_r <= 32'd0;
	shared_ack <= 1'd0;
	error <= 1'd0;
	shared_ack <= (basesoc_sram_bus_ack | basesoc_wishbone2csr_ack);
	shared_dat_r <= (({32{slave_sel_r[0]}} & basesoc_sram_bus_dat_r) | ({32{slave_sel_r[1]}} & basesoc_wishbone2csr_dat_r));
	if (done) begin
		shared_dat_r <= 32'd4294967295;
		shared_ack <= 1'd1;
		error <= 1'd1;
	end
end
assign done = (count == 1'd0);
assign csrbank0_sel = (interface0_bank_bus_adr[13:9] == 4'd8);
assign csrbank0_in_r = interface0_bank_bus_dat_w[3:0];
assign csrbank0_in_re = ((csrbank0_sel & interface0_bank_bus_we) & (interface0_bank_bus_adr[0] == 1'd0));
assign csrbank0_in_w = buttons_status[3:0];
assign csrbank1_sel = (interface1_bank_bus_adr[13:9] == 1'd0);
assign basesoc_reset_reset_r = interface1_bank_bus_dat_w[0];
assign basesoc_reset_reset_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 1'd0));
assign csrbank1_scratch0_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_scratch0_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 1'd1));
assign csrbank1_bus_errors_r = interface1_bank_bus_dat_w[31:0];
assign csrbank1_bus_errors_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 2'd2));
assign basesoc_storage = basesoc_storage_full[31:0];
assign csrbank1_scratch0_w = basesoc_storage_full[31:0];
assign csrbank1_bus_errors_w = basesoc_bus_errors_status[31:0];
assign sel = (sram_bus_adr[13:9] == 3'd4);
always @(*) begin
	sram_bus_dat_r <= 32'd0;
	if (sel_r) begin
		sram_bus_dat_r <= dat_r;
	end
end
assign adr = sram_bus_adr[5:0];
assign csrbank2_sel = (interface2_bank_bus_adr[13:9] == 4'd10);
assign csrbank2_out0_r = interface2_bank_bus_dat_w[3:0];
assign csrbank2_out0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[0] == 1'd0));
assign leds_storage = leds_storage_full[3:0];
assign csrbank2_out0_w = leds_storage_full[3:0];
assign csrbank3_sel = (interface3_bank_bus_adr[13:9] == 4'd11);
assign csrbank3_r_duty0_r = interface3_bank_bus_dat_w[7:0];
assign csrbank3_r_duty0_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 1'd0));
assign csrbank3_g_duty0_r = interface3_bank_bus_dat_w[7:0];
assign csrbank3_g_duty0_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 1'd1));
assign csrbank3_b_duty0_r = interface3_bank_bus_dat_w[7:0];
assign csrbank3_b_duty0_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[1:0] == 2'd2));
assign rgbled0_r_storage = rgbled0_r_storage_full[7:0];
assign csrbank3_r_duty0_w = rgbled0_r_storage_full[7:0];
assign rgbled0_g_storage = rgbled0_g_storage_full[7:0];
assign csrbank3_g_duty0_w = rgbled0_g_storage_full[7:0];
assign rgbled0_b_storage = rgbled0_b_storage_full[7:0];
assign csrbank3_b_duty0_w = rgbled0_b_storage_full[7:0];
assign csrbank4_sel = (interface4_bank_bus_adr[13:9] == 4'd12);
assign csrbank4_r_duty0_r = interface4_bank_bus_dat_w[7:0];
assign csrbank4_r_duty0_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 1'd0));
assign csrbank4_g_duty0_r = interface4_bank_bus_dat_w[7:0];
assign csrbank4_g_duty0_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 1'd1));
assign csrbank4_b_duty0_r = interface4_bank_bus_dat_w[7:0];
assign csrbank4_b_duty0_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 2'd2));
assign rgbled1_r_storage = rgbled1_r_storage_full[7:0];
assign csrbank4_r_duty0_w = rgbled1_r_storage_full[7:0];
assign rgbled1_g_storage = rgbled1_g_storage_full[7:0];
assign csrbank4_g_duty0_w = rgbled1_g_storage_full[7:0];
assign rgbled1_b_storage = rgbled1_b_storage_full[7:0];
assign csrbank4_b_duty0_w = rgbled1_b_storage_full[7:0];
assign csrbank5_sel = (interface5_bank_bus_adr[13:9] == 4'd13);
assign csrbank5_r_duty0_r = interface5_bank_bus_dat_w[7:0];
assign csrbank5_r_duty0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[1:0] == 1'd0));
assign csrbank5_g_duty0_r = interface5_bank_bus_dat_w[7:0];
assign csrbank5_g_duty0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[1:0] == 1'd1));
assign csrbank5_b_duty0_r = interface5_bank_bus_dat_w[7:0];
assign csrbank5_b_duty0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[1:0] == 2'd2));
assign rgbled2_r_storage = rgbled2_r_storage_full[7:0];
assign csrbank5_r_duty0_w = rgbled2_r_storage_full[7:0];
assign rgbled2_g_storage = rgbled2_g_storage_full[7:0];
assign csrbank5_g_duty0_w = rgbled2_g_storage_full[7:0];
assign rgbled2_b_storage = rgbled2_b_storage_full[7:0];
assign csrbank5_b_duty0_w = rgbled2_b_storage_full[7:0];
assign csrbank6_sel = (interface6_bank_bus_adr[13:9] == 4'd14);
assign csrbank6_r_duty0_r = interface6_bank_bus_dat_w[7:0];
assign csrbank6_r_duty0_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[1:0] == 1'd0));
assign csrbank6_g_duty0_r = interface6_bank_bus_dat_w[7:0];
assign csrbank6_g_duty0_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[1:0] == 1'd1));
assign csrbank6_b_duty0_r = interface6_bank_bus_dat_w[7:0];
assign csrbank6_b_duty0_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[1:0] == 2'd2));
assign rgbled3_r_storage = rgbled3_r_storage_full[7:0];
assign csrbank6_r_duty0_w = rgbled3_r_storage_full[7:0];
assign rgbled3_g_storage = rgbled3_g_storage_full[7:0];
assign csrbank6_g_duty0_w = rgbled3_g_storage_full[7:0];
assign rgbled3_b_storage = rgbled3_b_storage_full[7:0];
assign csrbank6_b_duty0_w = rgbled3_b_storage_full[7:0];
assign csrbank7_sel = (interface7_bank_bus_adr[13:9] == 4'd9);
assign csrbank7_in_r = interface7_bank_bus_dat_w[3:0];
assign csrbank7_in_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[0] == 1'd0));
assign csrbank7_in_w = switches_status[3:0];
assign interface0_bank_bus_adr = basesoc_interface_adr;
assign interface1_bank_bus_adr = basesoc_interface_adr;
assign interface2_bank_bus_adr = basesoc_interface_adr;
assign interface3_bank_bus_adr = basesoc_interface_adr;
assign interface4_bank_bus_adr = basesoc_interface_adr;
assign interface5_bank_bus_adr = basesoc_interface_adr;
assign interface6_bank_bus_adr = basesoc_interface_adr;
assign interface7_bank_bus_adr = basesoc_interface_adr;
assign sram_bus_adr = basesoc_interface_adr;
assign interface0_bank_bus_we = basesoc_interface_we;
assign interface1_bank_bus_we = basesoc_interface_we;
assign interface2_bank_bus_we = basesoc_interface_we;
assign interface3_bank_bus_we = basesoc_interface_we;
assign interface4_bank_bus_we = basesoc_interface_we;
assign interface5_bank_bus_we = basesoc_interface_we;
assign interface6_bank_bus_we = basesoc_interface_we;
assign interface7_bank_bus_we = basesoc_interface_we;
assign sram_bus_we = basesoc_interface_we;
assign interface0_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface1_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface2_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface3_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface4_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface5_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface6_bank_bus_dat_w = basesoc_interface_dat_w;
assign interface7_bank_bus_dat_w = basesoc_interface_dat_w;
assign sram_bus_dat_w = basesoc_interface_dat_w;
assign basesoc_interface_dat_r = ((((((((interface0_bank_bus_dat_r | interface1_bank_bus_dat_r) | interface2_bank_bus_dat_r) | interface3_bank_bus_dat_r) | interface4_bank_bus_dat_r) | interface5_bank_bus_dat_r) | interface6_bank_bus_dat_r) | interface7_bank_bus_dat_r) | sram_bus_dat_r);
always @(*) begin
	array_muxed0 <= 30'd0;
	case (grant)
		default: begin
			array_muxed0 <= uartwishbonebridge_adr;
		end
	endcase
end
always @(*) begin
	array_muxed1 <= 32'd0;
	case (grant)
		default: begin
			array_muxed1 <= uartwishbonebridge_dat_w;
		end
	endcase
end
always @(*) begin
	array_muxed2 <= 4'd0;
	case (grant)
		default: begin
			array_muxed2 <= uartwishbonebridge_sel;
		end
	endcase
end
always @(*) begin
	array_muxed3 <= 1'd0;
	case (grant)
		default: begin
			array_muxed3 <= uartwishbonebridge_cyc;
		end
	endcase
end
always @(*) begin
	array_muxed4 <= 1'd0;
	case (grant)
		default: begin
			array_muxed4 <= uartwishbonebridge_stb;
		end
	endcase
end
always @(*) begin
	array_muxed5 <= 1'd0;
	case (grant)
		default: begin
			array_muxed5 <= uartwishbonebridge_we;
		end
	endcase
end
always @(*) begin
	array_muxed6 <= 3'd0;
	case (grant)
		default: begin
			array_muxed6 <= uartwishbonebridge_cti;
		end
	endcase
end
always @(*) begin
	array_muxed7 <= 2'd0;
	case (grant)
		default: begin
			array_muxed7 <= uartwishbonebridge_bte;
		end
	endcase
end
assign uartwishbonebridge_rx_rx = xilinxmultiregimpl0_regs1;
assign buttons_status = xilinxmultiregimpl1_regs1;
assign xilinxmultiregimpl1 = {button3, button2, button1, button0};
assign switches_status = xilinxmultiregimpl2_regs1;
assign xilinxmultiregimpl2 = {switch3, switch2, switch1, switch0};

always @(posedge por_clk) begin
	int_rst <= 1'd0;
end

always @(posedge sys_clk) begin
	if ((basesoc_bus_errors != 32'd4294967295)) begin
		if (basesoc_bus_error) begin
			basesoc_bus_errors <= (basesoc_bus_errors + 1'd1);
		end
	end
	basesoc_sram_bus_ack <= 1'd0;
	if (((basesoc_sram_bus_cyc & basesoc_sram_bus_stb) & (~basesoc_sram_bus_ack))) begin
		basesoc_sram_bus_ack <= 1'd1;
	end
	basesoc_interface_we <= 1'd0;
	basesoc_interface_dat_w <= basesoc_wishbone2csr_dat_w;
	basesoc_interface_adr <= basesoc_wishbone2csr_adr;
	basesoc_wishbone2csr_dat_r <= basesoc_interface_dat_r;
	if ((basesoc_wishbone2csr_counter == 1'd1)) begin
		basesoc_interface_we <= basesoc_wishbone2csr_we;
	end
	if ((basesoc_wishbone2csr_counter == 2'd2)) begin
		basesoc_wishbone2csr_ack <= 1'd1;
	end
	if ((basesoc_wishbone2csr_counter == 2'd3)) begin
		basesoc_wishbone2csr_ack <= 1'd0;
	end
	if ((basesoc_wishbone2csr_counter != 1'd0)) begin
		basesoc_wishbone2csr_counter <= (basesoc_wishbone2csr_counter + 1'd1);
	end else begin
		if ((basesoc_wishbone2csr_cyc & basesoc_wishbone2csr_stb)) begin
			basesoc_wishbone2csr_counter <= 1'd1;
		end
	end
	if (uartwishbonebridge_byte_counter_reset) begin
		uartwishbonebridge_byte_counter <= 1'd0;
	end else begin
		if (uartwishbonebridge_byte_counter_ce) begin
			uartwishbonebridge_byte_counter <= (uartwishbonebridge_byte_counter + 1'd1);
		end
	end
	if (uartwishbonebridge_word_counter_reset) begin
		uartwishbonebridge_word_counter <= 1'd0;
	end else begin
		if (uartwishbonebridge_word_counter_ce) begin
			uartwishbonebridge_word_counter <= (uartwishbonebridge_word_counter + 1'd1);
		end
	end
	if (uartwishbonebridge_cmd_ce) begin
		uartwishbonebridge_cmd <= uartwishbonebridge_rx_payload_data;
	end
	if (uartwishbonebridge_length_ce) begin
		uartwishbonebridge_length <= uartwishbonebridge_rx_payload_data;
	end
	if (uartwishbonebridge_address_ce) begin
		uartwishbonebridge_address <= {uartwishbonebridge_address[23:0], uartwishbonebridge_rx_payload_data};
	end
	if (uartwishbonebridge_rx_data_ce) begin
		uartwishbonebridge_data <= {uartwishbonebridge_data[23:0], uartwishbonebridge_rx_payload_data};
	end else begin
		if (uartwishbonebridge_tx_data_ce) begin
			uartwishbonebridge_data <= uartwishbonebridge_dat_r;
		end
	end
	uartwishbonebridge_tx_ready <= 1'd0;
	if (((uartwishbonebridge_tx_valid & (~uartwishbonebridge_tx_tx_busy)) & (~uartwishbonebridge_tx_ready))) begin
		uartwishbonebridge_tx_tx_reg <= uartwishbonebridge_tx_payload_data;
		uartwishbonebridge_tx_tx_bitcount <= 1'd0;
		uartwishbonebridge_tx_tx_busy <= 1'd1;
		serial_tx <= 1'd0;
	end else begin
		if ((uartwishbonebridge_tx_uart_clk_txen & uartwishbonebridge_tx_tx_busy)) begin
			uartwishbonebridge_tx_tx_bitcount <= (uartwishbonebridge_tx_tx_bitcount + 1'd1);
			if ((uartwishbonebridge_tx_tx_bitcount == 4'd8)) begin
				serial_tx <= 1'd1;
			end else begin
				if ((uartwishbonebridge_tx_tx_bitcount == 4'd9)) begin
					serial_tx <= 1'd1;
					uartwishbonebridge_tx_tx_busy <= 1'd0;
					uartwishbonebridge_tx_ready <= 1'd1;
				end else begin
					serial_tx <= uartwishbonebridge_tx_tx_reg[0];
					uartwishbonebridge_tx_tx_reg <= {1'd0, uartwishbonebridge_tx_tx_reg[7:1]};
				end
			end
		end
	end
	if (uartwishbonebridge_tx_tx_busy) begin
		{uartwishbonebridge_tx_uart_clk_txen, uartwishbonebridge_tx_phase_accumulator_tx} <= (uartwishbonebridge_tx_phase_accumulator_tx + uartwishbonebridge_storage);
	end else begin
		{uartwishbonebridge_tx_uart_clk_txen, uartwishbonebridge_tx_phase_accumulator_tx} <= 1'd0;
	end
	uartwishbonebridge_rx_valid <= 1'd0;
	uartwishbonebridge_rx_rx_r <= uartwishbonebridge_rx_rx;
	if ((~uartwishbonebridge_rx_rx_busy)) begin
		if (((~uartwishbonebridge_rx_rx) & uartwishbonebridge_rx_rx_r)) begin
			uartwishbonebridge_rx_rx_busy <= 1'd1;
			uartwishbonebridge_rx_rx_bitcount <= 1'd0;
		end
	end else begin
		if (uartwishbonebridge_rx_uart_clk_rxen) begin
			uartwishbonebridge_rx_rx_bitcount <= (uartwishbonebridge_rx_rx_bitcount + 1'd1);
			if ((uartwishbonebridge_rx_rx_bitcount == 1'd0)) begin
				if (uartwishbonebridge_rx_rx) begin
					uartwishbonebridge_rx_rx_busy <= 1'd0;
				end
			end else begin
				if ((uartwishbonebridge_rx_rx_bitcount == 4'd9)) begin
					uartwishbonebridge_rx_rx_busy <= 1'd0;
					if (uartwishbonebridge_rx_rx) begin
						uartwishbonebridge_rx_payload_data <= uartwishbonebridge_rx_rx_reg;
						uartwishbonebridge_rx_valid <= 1'd1;
					end
				end else begin
					uartwishbonebridge_rx_rx_reg <= {uartwishbonebridge_rx_rx, uartwishbonebridge_rx_rx_reg[7:1]};
				end
			end
		end
	end
	if (uartwishbonebridge_rx_rx_busy) begin
		{uartwishbonebridge_rx_uart_clk_rxen, uartwishbonebridge_rx_phase_accumulator_rx} <= (uartwishbonebridge_rx_phase_accumulator_rx + uartwishbonebridge_storage);
	end else begin
		{uartwishbonebridge_rx_uart_clk_rxen, uartwishbonebridge_rx_phase_accumulator_rx} <= 32'd2147483648;
	end
	state <= next_state;
	if (uartwishbonebridge_reset) begin
		state <= 3'd0;
	end
	if (uartwishbonebridge_wait) begin
		if ((~uartwishbonebridge_done)) begin
			uartwishbonebridge_count <= (uartwishbonebridge_count - 1'd1);
		end
	end else begin
		uartwishbonebridge_count <= 24'd10000000;
	end
	rgbled0_r_counter <= (rgbled0_r_counter + 1'd1);
	rgbled0_g_counter <= (rgbled0_g_counter + 1'd1);
	rgbled0_b_counter <= (rgbled0_b_counter + 1'd1);
	rgbled1_r_counter <= (rgbled1_r_counter + 1'd1);
	rgbled1_g_counter <= (rgbled1_g_counter + 1'd1);
	rgbled1_b_counter <= (rgbled1_b_counter + 1'd1);
	rgbled2_r_counter <= (rgbled2_r_counter + 1'd1);
	rgbled2_g_counter <= (rgbled2_g_counter + 1'd1);
	rgbled2_b_counter <= (rgbled2_b_counter + 1'd1);
	rgbled3_r_counter <= (rgbled3_r_counter + 1'd1);
	rgbled3_g_counter <= (rgbled3_g_counter + 1'd1);
	rgbled3_b_counter <= (rgbled3_b_counter + 1'd1);
	slave_sel_r <= slave_sel;
	if (wait_1) begin
		if ((~done)) begin
			count <= (count - 1'd1);
		end
	end else begin
		count <= 17'd65536;
	end
	interface0_bank_bus_dat_r <= 1'd0;
	if (csrbank0_sel) begin
		case (interface0_bank_bus_adr[0])
			1'd0: begin
				interface0_bank_bus_dat_r <= csrbank0_in_w;
			end
		endcase
	end
	interface1_bank_bus_dat_r <= 1'd0;
	if (csrbank1_sel) begin
		case (interface1_bank_bus_adr[1:0])
			1'd0: begin
				interface1_bank_bus_dat_r <= basesoc_reset_reset_w;
			end
			1'd1: begin
				interface1_bank_bus_dat_r <= csrbank1_scratch0_w;
			end
			2'd2: begin
				interface1_bank_bus_dat_r <= csrbank1_bus_errors_w;
			end
		endcase
	end
	if (csrbank1_scratch0_re) begin
		basesoc_storage_full[31:0] <= csrbank1_scratch0_r;
	end
	basesoc_re <= csrbank1_scratch0_re;
	sel_r <= sel;
	interface2_bank_bus_dat_r <= 1'd0;
	if (csrbank2_sel) begin
		case (interface2_bank_bus_adr[0])
			1'd0: begin
				interface2_bank_bus_dat_r <= csrbank2_out0_w;
			end
		endcase
	end
	if (csrbank2_out0_re) begin
		leds_storage_full[3:0] <= csrbank2_out0_r;
	end
	leds_re <= csrbank2_out0_re;
	interface3_bank_bus_dat_r <= 1'd0;
	if (csrbank3_sel) begin
		case (interface3_bank_bus_adr[1:0])
			1'd0: begin
				interface3_bank_bus_dat_r <= csrbank3_r_duty0_w;
			end
			1'd1: begin
				interface3_bank_bus_dat_r <= csrbank3_g_duty0_w;
			end
			2'd2: begin
				interface3_bank_bus_dat_r <= csrbank3_b_duty0_w;
			end
		endcase
	end
	if (csrbank3_r_duty0_re) begin
		rgbled0_r_storage_full[7:0] <= csrbank3_r_duty0_r;
	end
	rgbled0_r_re <= csrbank3_r_duty0_re;
	if (csrbank3_g_duty0_re) begin
		rgbled0_g_storage_full[7:0] <= csrbank3_g_duty0_r;
	end
	rgbled0_g_re <= csrbank3_g_duty0_re;
	if (csrbank3_b_duty0_re) begin
		rgbled0_b_storage_full[7:0] <= csrbank3_b_duty0_r;
	end
	rgbled0_b_re <= csrbank3_b_duty0_re;
	interface4_bank_bus_dat_r <= 1'd0;
	if (csrbank4_sel) begin
		case (interface4_bank_bus_adr[1:0])
			1'd0: begin
				interface4_bank_bus_dat_r <= csrbank4_r_duty0_w;
			end
			1'd1: begin
				interface4_bank_bus_dat_r <= csrbank4_g_duty0_w;
			end
			2'd2: begin
				interface4_bank_bus_dat_r <= csrbank4_b_duty0_w;
			end
		endcase
	end
	if (csrbank4_r_duty0_re) begin
		rgbled1_r_storage_full[7:0] <= csrbank4_r_duty0_r;
	end
	rgbled1_r_re <= csrbank4_r_duty0_re;
	if (csrbank4_g_duty0_re) begin
		rgbled1_g_storage_full[7:0] <= csrbank4_g_duty0_r;
	end
	rgbled1_g_re <= csrbank4_g_duty0_re;
	if (csrbank4_b_duty0_re) begin
		rgbled1_b_storage_full[7:0] <= csrbank4_b_duty0_r;
	end
	rgbled1_b_re <= csrbank4_b_duty0_re;
	interface5_bank_bus_dat_r <= 1'd0;
	if (csrbank5_sel) begin
		case (interface5_bank_bus_adr[1:0])
			1'd0: begin
				interface5_bank_bus_dat_r <= csrbank5_r_duty0_w;
			end
			1'd1: begin
				interface5_bank_bus_dat_r <= csrbank5_g_duty0_w;
			end
			2'd2: begin
				interface5_bank_bus_dat_r <= csrbank5_b_duty0_w;
			end
		endcase
	end
	if (csrbank5_r_duty0_re) begin
		rgbled2_r_storage_full[7:0] <= csrbank5_r_duty0_r;
	end
	rgbled2_r_re <= csrbank5_r_duty0_re;
	if (csrbank5_g_duty0_re) begin
		rgbled2_g_storage_full[7:0] <= csrbank5_g_duty0_r;
	end
	rgbled2_g_re <= csrbank5_g_duty0_re;
	if (csrbank5_b_duty0_re) begin
		rgbled2_b_storage_full[7:0] <= csrbank5_b_duty0_r;
	end
	rgbled2_b_re <= csrbank5_b_duty0_re;
	interface6_bank_bus_dat_r <= 1'd0;
	if (csrbank6_sel) begin
		case (interface6_bank_bus_adr[1:0])
			1'd0: begin
				interface6_bank_bus_dat_r <= csrbank6_r_duty0_w;
			end
			1'd1: begin
				interface6_bank_bus_dat_r <= csrbank6_g_duty0_w;
			end
			2'd2: begin
				interface6_bank_bus_dat_r <= csrbank6_b_duty0_w;
			end
		endcase
	end
	if (csrbank6_r_duty0_re) begin
		rgbled3_r_storage_full[7:0] <= csrbank6_r_duty0_r;
	end
	rgbled3_r_re <= csrbank6_r_duty0_re;
	if (csrbank6_g_duty0_re) begin
		rgbled3_g_storage_full[7:0] <= csrbank6_g_duty0_r;
	end
	rgbled3_g_re <= csrbank6_g_duty0_re;
	if (csrbank6_b_duty0_re) begin
		rgbled3_b_storage_full[7:0] <= csrbank6_b_duty0_r;
	end
	rgbled3_b_re <= csrbank6_b_duty0_re;
	interface7_bank_bus_dat_r <= 1'd0;
	if (csrbank7_sel) begin
		case (interface7_bank_bus_adr[0])
			1'd0: begin
				interface7_bank_bus_dat_r <= csrbank7_in_w;
			end
		endcase
	end
	if (sys_rst) begin
		basesoc_storage_full <= 32'd305419896;
		basesoc_re <= 1'd0;
		basesoc_bus_errors <= 32'd0;
		basesoc_sram_bus_ack <= 1'd0;
		basesoc_interface_adr <= 14'd0;
		basesoc_interface_we <= 1'd0;
		basesoc_interface_dat_w <= 32'd0;
		basesoc_wishbone2csr_dat_r <= 32'd0;
		basesoc_wishbone2csr_ack <= 1'd0;
		basesoc_wishbone2csr_counter <= 2'd0;
		serial_tx <= 1'd1;
		uartwishbonebridge_tx_ready <= 1'd0;
		uartwishbonebridge_tx_uart_clk_txen <= 1'd0;
		uartwishbonebridge_tx_phase_accumulator_tx <= 32'd0;
		uartwishbonebridge_tx_tx_reg <= 8'd0;
		uartwishbonebridge_tx_tx_bitcount <= 4'd0;
		uartwishbonebridge_tx_tx_busy <= 1'd0;
		uartwishbonebridge_rx_valid <= 1'd0;
		uartwishbonebridge_rx_payload_data <= 8'd0;
		uartwishbonebridge_rx_uart_clk_rxen <= 1'd0;
		uartwishbonebridge_rx_phase_accumulator_rx <= 32'd0;
		uartwishbonebridge_rx_rx_r <= 1'd0;
		uartwishbonebridge_rx_rx_reg <= 8'd0;
		uartwishbonebridge_rx_rx_bitcount <= 4'd0;
		uartwishbonebridge_rx_rx_busy <= 1'd0;
		uartwishbonebridge_count <= 24'd10000000;
		leds_storage_full <= 4'd0;
		leds_re <= 1'd0;
		rgbled0_r_storage_full <= 8'd0;
		rgbled0_r_re <= 1'd0;
		rgbled0_r_counter <= 8'd0;
		rgbled0_g_storage_full <= 8'd0;
		rgbled0_g_re <= 1'd0;
		rgbled0_g_counter <= 8'd0;
		rgbled0_b_storage_full <= 8'd0;
		rgbled0_b_re <= 1'd0;
		rgbled0_b_counter <= 8'd0;
		rgbled1_r_storage_full <= 8'd0;
		rgbled1_r_re <= 1'd0;
		rgbled1_r_counter <= 8'd0;
		rgbled1_g_storage_full <= 8'd0;
		rgbled1_g_re <= 1'd0;
		rgbled1_g_counter <= 8'd0;
		rgbled1_b_storage_full <= 8'd0;
		rgbled1_b_re <= 1'd0;
		rgbled1_b_counter <= 8'd0;
		rgbled2_r_storage_full <= 8'd0;
		rgbled2_r_re <= 1'd0;
		rgbled2_r_counter <= 8'd0;
		rgbled2_g_storage_full <= 8'd0;
		rgbled2_g_re <= 1'd0;
		rgbled2_g_counter <= 8'd0;
		rgbled2_b_storage_full <= 8'd0;
		rgbled2_b_re <= 1'd0;
		rgbled2_b_counter <= 8'd0;
		rgbled3_r_storage_full <= 8'd0;
		rgbled3_r_re <= 1'd0;
		rgbled3_r_counter <= 8'd0;
		rgbled3_g_storage_full <= 8'd0;
		rgbled3_g_re <= 1'd0;
		rgbled3_g_counter <= 8'd0;
		rgbled3_b_storage_full <= 8'd0;
		rgbled3_b_re <= 1'd0;
		rgbled3_b_counter <= 8'd0;
		state <= 3'd0;
		slave_sel_r <= 2'd0;
		count <= 17'd65536;
		interface0_bank_bus_dat_r <= 32'd0;
		interface1_bank_bus_dat_r <= 32'd0;
		sel_r <= 1'd0;
		interface2_bank_bus_dat_r <= 32'd0;
		interface3_bank_bus_dat_r <= 32'd0;
		interface4_bank_bus_dat_r <= 32'd0;
		interface5_bank_bus_dat_r <= 32'd0;
		interface6_bank_bus_dat_r <= 32'd0;
		interface7_bank_bus_dat_r <= 32'd0;
	end
	xilinxmultiregimpl0_regs0 <= serial_rx;
	xilinxmultiregimpl0_regs1 <= xilinxmultiregimpl0_regs0;
	xilinxmultiregimpl1_regs0 <= {button3, button2, button1, button0};
	xilinxmultiregimpl1_regs1 <= xilinxmultiregimpl1_regs0;
	xilinxmultiregimpl2_regs0 <= {switch3, switch2, switch1, switch0};
	xilinxmultiregimpl2_regs1 <= xilinxmultiregimpl2_regs0;
end

reg [31:0] mem[0:1023];
reg [9:0] memadr;
always @(posedge sys_clk) begin
	if (basesoc_sram_we[0])
		mem[basesoc_sram_adr][7:0] <= basesoc_sram_dat_w[7:0];
	if (basesoc_sram_we[1])
		mem[basesoc_sram_adr][15:8] <= basesoc_sram_dat_w[15:8];
	if (basesoc_sram_we[2])
		mem[basesoc_sram_adr][23:16] <= basesoc_sram_dat_w[23:16];
	if (basesoc_sram_we[3])
		mem[basesoc_sram_adr][31:24] <= basesoc_sram_dat_w[31:24];
	memadr <= basesoc_sram_adr;
end

assign basesoc_sram_dat_r = mem[memadr];

reg [7:0] mem_1[0:59];
reg [5:0] memadr_1;
always @(posedge sys_clk) begin
	memadr_1 <= adr;
end

assign dat_r = mem_1[memadr_1];

initial begin
	$readmemh("mem_1.init", mem_1);
end

endmodule
