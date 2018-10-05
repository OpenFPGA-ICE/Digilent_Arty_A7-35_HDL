//
//  Program to freely choose colour of the RGB LEDs - Verilog
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
// Create Date: 18.09.2018 14:02:09
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Program to simultaneously light up the 4 RGB LEDs to a colour
//              which the user chooses. The level of each colour is adjusted
//              using the buttons.
//              BTN2: R, BTN1: G, BTN0: B.
//
//              The position of the switches of the same index determine if
//              the change is an increment or decrement. If the switch is up
//              the corresponding level will be increased when the button is
//              pressed, and decreased otherwise.
//              SW2: R, SW1: G, SW0: B.
//
//              e.g. If SW2 and SW0 are up while SW1 is down,
//              when BTN2 will be pressed, level of R will increase,
//              when BNT0 will be pressed, level of B will increase,
//              when BTN1 will be pressed, level of G will decrease.
//
//              Initially, all the LEDs are off, i.e. PWM duty level 0.
//
//
// Dependencies: debounce.v, PWMLED.v
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input CLK100MHZ,
    input btn0, btn1, btn2, btn3,
    input sw0, sw1, sw2,
    output led0_r, led0_g, led0_b,
    output led1_r, led1_g, led1_b,
    output led2_r, led2_g, led2_b,
    output led3_r, led3_g, led3_b
    );

    // Variables local to main
    reg [5:0] duty_R = 6'b000000;
    reg [5:0] duty_G = 6'b000000;
    reg [5:0] duty_B = 6'b000000;
    wire btn0_state, btn1_state, btn2_state, btn3_state;
    
    
    // Catch input from buttons 0, 1 and 2
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

    debounce deb_btn2(
        .clock(CLK100MHZ),
        .button(btn2),
        .deb_state(btn2_state)
        );

    debounce deb_btn3(
        .clock(CLK100MHZ),
        .button(btn3),
        .deb_state(btn3_state)
        );

    always @ (posedge(CLK100MHZ))
    begin
        // Reset
        if (btn3_state)
        begin
            duty_R <= 6'b000000;
            duty_G <= 6'b000000;
            duty_B <= 6'b000000;
        end
        
        // R
        if (btn2_state)
        begin
            if (sw2)
                duty_R <= duty_R + 6'b000010;
            else
                duty_R <= duty_R - 6'b000010;
        end
        
        // G
        if (btn1_state)
        begin
            if (sw1)
                duty_G <= duty_G + 6'b000010;
            else
                duty_G <= duty_G - 6'b000010;
        end
        
        // B
        if (btn0_state)
        begin
            if (sw0)
                duty_B <= duty_B + 6'b000010;
            else
                duty_B <= duty_B - 6'b000010;
        end
    end


    // Light up the LEDs
    // RGB LED0
    PWMLED pwmled0_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_R),
        .pwm_state(led0_r)
        );
    PWMLED pwmled0_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_G),
        .pwm_state(led0_g)
        );
    PWMLED pwmled0_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_B),
        .pwm_state(led0_b)
        );

    // RGB LED1
    PWMLED pwmled1_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_R),
        .pwm_state(led1_r)
        );
    PWMLED pwmled1_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_G),
        .pwm_state(led1_g)
        );
    PWMLED pwmled1_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_B),
        .pwm_state(led1_b)
        );

    // RGB LED2
    PWMLED pwmled2_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_R),
        .pwm_state(led2_r)
        );
    PWMLED pwmled2_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_G),
        .pwm_state(led2_g)
        );
    PWMLED pwmled2_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_B),
        .pwm_state(led2_b)
        );

    // RGB LED3
    PWMLED pwmled3_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_R),
        .pwm_state(led3_r)
        );
    PWMLED pwmled3_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_G),
        .pwm_state(led3_g)
        );
    PWMLED pwmled3_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_B),
        .pwm_state(led3_b)
        );

endmodule