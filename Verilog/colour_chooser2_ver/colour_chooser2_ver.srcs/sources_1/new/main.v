//
//  Program to light up each of the 4 RGB LEDs with any colour
//  combination - Verilog
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
// Create Date: 04.10.2018 14:48:09
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The program allows the user to light up each one of the four RGB
//              LEDs to any colour using different R, G and B combinations on
//              each LED.
//              The switches are used to activate the LEDs. If a switch is in up
//              position, the RGB LED with index corresponding to the switch will
//              be affected when the R, G and B levels are changed, or when the
//              reset button is pressed. If the switch is in the down position,
//              the corresponding LED will not be affected at all.
//              SW3: LD3, SW2: LD2, SW1: LD1, SW0: LD0.
//
//              The buttons are used to change the R, G and B levels, and also to
//              reset active LEDs to 0 level (unlit).
//              BTN3: reset, BTN2: R, BTN1: G, BTN0: B.
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
    input sw0, sw1, sw2, sw3,
    output led0_r, led0_g, led0_b,
    output led1_r, led1_g, led1_b,
    output led2_r, led2_g, led2_b,
    output led3_r, led3_g, led3_b
    );

    // Variables local to main
    reg [5:0] duty_0r = 6'b000000;
    reg [5:0] duty_0g = 6'b000000;
    reg [5:0] duty_0b = 6'b000000;
    reg [5:0] duty_1r = 6'b000000;
    reg [5:0] duty_1g = 6'b000000;
    reg [5:0] duty_1b = 6'b000000;
    reg [5:0] duty_2r = 6'b000000;
    reg [5:0] duty_2g = 6'b000000;
    reg [5:0] duty_2b = 6'b000000;
    reg [5:0] duty_3r = 6'b000000;
    reg [5:0] duty_3g = 6'b000000;
    reg [5:0] duty_3b = 6'b000000;

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


    // Evaluate states of buttons and switches,
    // and adjust PWM duty levels accordingly
    always @ (posedge(CLK100MHZ))
    begin
        // BTN3: Reset
        if (btn3_state)
        begin
            if (sw3)
            begin
                duty_3r <= 6'b000000;
                duty_3g <= 6'b000000;
                duty_3b <= 6'b000000;
            end
            if (sw2)
            begin
                duty_2r <= 6'b000000;
                duty_2g <= 6'b000000;
                duty_2b <= 6'b000000;
            end
            if (sw1)
            begin
                duty_1r <= 6'b000000;
                duty_1g <= 6'b000000;
                duty_1b <= 6'b000000;
            end
            if (sw0)
            begin
                duty_0r <= 6'b000000;
                duty_0g <= 6'b000000;
                duty_0b <= 6'b000000;
            end
        end
        
        // BTN2: R
        if (btn2_state)
        begin
            if (sw3)
                duty_3r <= duty_3r + 6'b000010;
            if (sw2)
                duty_2r <= duty_2r + 6'b000010;
            if (sw1)
                duty_1r <= duty_1r + 6'b000010;
            if (sw0)
                duty_0r <= duty_0r + 6'b000010;
        end

        // BTN1: G
        if (btn1_state)
        begin
            if (sw3)
                duty_3g <= duty_3g + 6'b000010;
            if (sw2)
                duty_2g <= duty_2g + 6'b000010;
            if (sw1)
                duty_1g <= duty_1g + 6'b000010;
            if (sw0)
                duty_0g <= duty_0g + 6'b000010;
        end

        // BTN1: B
        if (btn0_state)
        begin
            if (sw3)
                duty_3b <= duty_3b + 6'b000010;
            if (sw2)
                duty_2b <= duty_2b + 6'b000010;
            if (sw1)
                duty_1b <= duty_1b + 6'b000010;
            if (sw0)
                duty_0b <= duty_0b + 6'b000010;
        end

    end


    // Light up the LEDs
    // RGB LED0
    PWMLED pwmled0_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_0r),
        .pwm_state(led0_r)
        );
    PWMLED pwmled0_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_0g),
        .pwm_state(led0_g)
        );
    PWMLED pwmled0_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_0b),
        .pwm_state(led0_b)
        );

    // RGB LED1
    PWMLED pwmled1_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_1r),
        .pwm_state(led1_r)
        );
    PWMLED pwmled1_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_1g),
        .pwm_state(led1_g)
        );
    PWMLED pwmled1_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_1b),
        .pwm_state(led1_b)
        );

    // RGB LED2
    PWMLED pwmled2_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_2r),
        .pwm_state(led2_r)
        );
    PWMLED pwmled2_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_2g),
        .pwm_state(led2_g)
        );
    PWMLED pwmled2_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_2b),
        .pwm_state(led2_b)
        );

    // RGB LED3
    PWMLED pwmled3_r(
        .clock(CLK100MHZ),
        .pwm_duty(duty_3r),
        .pwm_state(led3_r)
        );
    PWMLED pwmled3_g(
        .clock(CLK100MHZ),
        .pwm_duty(duty_3g),
        .pwm_state(led3_g)
        );
    PWMLED pwmled3_b(
        .clock(CLK100MHZ),
        .pwm_duty(duty_3b),
        .pwm_state(led3_b)
        );

endmodule