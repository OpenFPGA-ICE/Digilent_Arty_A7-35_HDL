//
//  8-bit binary stopwatch using 4 monochromatic LEDs and
//  4 RGB LEDs - Verilog
//
//  Copyright (C) 2018  Nitish Ragoomundun, Mauritius
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
//
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2018 13:23:20
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Binary stopwatch implemented using the 4 monochromatic LEDs, 4 RGB
//              LEDs. SW3 is used to start and stop the counter. When the switch is
//              in the up position, the counter proceeds and the binary number
//              represented by the LEDs increase. When the switch is brought to the
//              bottom position the counter stops. BTN3 is used to reset the
//              counter to 0, meaning that all LEDs are switched off.
//              LD4 to LD7 represent respectively bits 0,1,2,3 of an 8-bit number.
//              LD0 to LD3 represent respectively bits 4,5,6,7. Thus, a total of
//              255 seconds can be shown using the LEDs.
// 
// Dependencies: clockdivider.v, debounce.v, PWMLED.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input CLK100MHZ,
    input sw3,
    input btn3,
    output led0, led1, led2, led3,
    output led0_r, led1_r, led2_r, led3_r,
    output led0_g, led1_g, led2_g, led3_g,
    output led0_b, led1_b, led2_b, led3_b
    );
    
    wire SLOWCLK;
    wire btn3_state;
    reg run = 0;
    reg reset = 1;
    reg [7:0] counter;
    
    // Make slow clock with 1s time period
    clockdivider CLK_NEW(
        .clock(CLK100MHZ),
        .half_T(50000000),
        .T(99999999),
        .slowclock(SLOWCLK)
        );
    
    
    // Check button status
    debounce BUTTON3(
        .clock(CLK100MHZ),
        .button(btn3),
        .deb_state(btn3_state)
        );

    
    always @ (posedge(CLK100MHZ))
    begin
        if (sw3)
        begin
            run <= 1;
            reset <= 0;
        end
        else
            run <= 0;
        
        if (btn3_state)
        begin
            run <= 0;
            reset <= 1;
        end
    end

    always @ (posedge(SLOWCLK))
    begin
        if (run == 1)
            counter <= counter + 1;
        if (reset == 1)
            counter <= 0;
    end
    
    assign led0 = counter[0];
    assign led1 = counter[1];
    assign led2 = counter[2];
    assign led3 = counter[3];
    
    // RGB LED0
    PWMLED pwmled0_r(
        .clock(CLK100MHZ),
        .pwm_duty(counter[4] * 24),
        .pwm_state(led0_r)
        );
    PWMLED pwmled0_g(
        .clock(CLK100MHZ),
        .pwm_duty(counter[4] * 1),
        .pwm_state(led0_g)
        );
    PWMLED pwmled0_b(
        .clock(CLK100MHZ),
        .pwm_duty(counter[4] * 32),
        .pwm_state(led0_b)
        );

    // RGB LED1
    PWMLED pwmled1_r(
        .clock(CLK100MHZ),
        .pwm_duty(counter[5] * 24),
        .pwm_state(led1_r)
        );
    PWMLED pwmled1_g(
        .clock(CLK100MHZ),
        .pwm_duty(counter[5] * 1),
        .pwm_state(led1_g)
        );
    PWMLED pwmled1_b(
        .clock(CLK100MHZ),
        .pwm_duty(counter[5] * 32),
        .pwm_state(led1_b)
        );

    // RGB LED2
    PWMLED pwmled2_r(
        .clock(CLK100MHZ),
        .pwm_duty(counter[6] * 24),
        .pwm_state(led2_r)
        );
    PWMLED pwmled2_g(
        .clock(CLK100MHZ),
        .pwm_duty(counter[6] * 1),
        .pwm_state(led2_g)
        );
    PWMLED pwmled2_b(
        .clock(CLK100MHZ),
        .pwm_duty(counter[6] * 32),
        .pwm_state(led2_b)
        );

    // RGB LED3
    PWMLED pwmled3_r(
        .clock(CLK100MHZ),
        .pwm_duty(counter[7] * 24),
        .pwm_state(led3_r)
        );
    PWMLED pwmled3_g(
        .clock(CLK100MHZ),
        .pwm_duty(counter[7] * 1),
        .pwm_state(led3_g)
        );
    PWMLED pwmled3_b(
        .clock(CLK100MHZ),
        .pwm_duty(counter[7] * 32),
        .pwm_state(led3_b)
        );

endmodule
