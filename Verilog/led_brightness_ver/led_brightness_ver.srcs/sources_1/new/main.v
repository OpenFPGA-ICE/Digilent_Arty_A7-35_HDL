//
//  Program to vary brightness of 4 RGB LEDs - Verilog
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
// Create Date: 17.08.2018 11:13:03
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Program to vary brightness of RGB LEDs using debounced input
//              from buttons in VHDL. BTN0 decreases brightness while BTN1
//              increases the brightness of the LEDs. The LEDs are so bright
//              that a maximum brightness of 64 over 255. The brightness is
//              then varied by steps of 4 between 0 and 64 using PWM.
// 
// Dependencies: debouncer.v, PWMLED.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module main(
    input CLK100MHZ,
    input btn0,
    input btn1,
    output led0_g,
    output led1_g,
    output led2_g,
    output led3_g
    );
    
    reg [7:0] duty_led = 8'b01000000;
    wire btn0_state, btn1_state;
    
    debounce deb_btn0(
        .clock(CLK100MHZ),
        .button(btn0),
        .deb_state(btn0_state)
        );
    
    debounce deb_btn1(
        .clock(CLK100MHZ),
        .button(btn1),
        .deb_state(btn1_state)
        );
    
    always @ (posedge(CLK100MHZ))
    begin
        if (btn0_state)
            duty_led <= duty_led - 8'b00000100;
        if (btn1_state)
            duty_led <= duty_led + 8'b00000100;
    end
    
    PWMLED pwmled0_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_led),
        .pwm_state(led0_g)
        );

    PWMLED pwmled1_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_led),
        .pwm_state(led1_g)
        );

    PWMLED pwmled2_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_led),
        .pwm_state(led2_g)
        );

    PWMLED pwmled3_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_led),
        .pwm_state(led3_g)
        );
    
endmodule
