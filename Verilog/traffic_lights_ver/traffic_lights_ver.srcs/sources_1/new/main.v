//
//  Program to simulate traffic lights using the RGB LEDs - Verilog
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
// Create Date: 24.08.2018 14:40:28
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Program to control traffic lights. LD1-LD3 are for cars while LD0
//              is for pedestrians and will switch between red and green.
//              One cycle takes around 1min 20s. The lights are green for cars for
//              around 1 minute. The press os BTN3 can bring this down to 20s as
//              BTN3 is set to be used by pedestrian to request crossing.
// 
// Dependencies: PWMLED.v, clockdivider.v, debounce.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input CLK100MHZ,
    input btn3,
    output led0, led1, led2, led3,
    output led0_r, led0_g,
    output led1_r,
    output led2_r, led2_g, led2_b,
    output led3_g
    );
    
    wire SLOWCLK;
    wire btn3_state;
    reg [8:0] longcount = 0;
    reg [3:0] countdown = 4'b0000;
    reg call_for_crossing = 0;
    reg cars_red = 0;
    reg cars_amber = 0;
    reg cars_green = 1;
    reg walk_red = 1;
    reg walk_green = 0;
    
    
    // Generate slow clock with 2 cycles per second
    clockdivider CLKNEW1(
        .clock(CLK100MHZ),
        .half_T(25000000),
        .T(49999999),
        .slowclock(SLOWCLK)
        );

    // Look for input at button 3
    debounce BUTTON3(
        .clock(CLK100MHZ),
        .button(btn3),
        .deb_state(btn3_state)
        );

    always @ (posedge(CLK100MHZ))
    begin
        if (btn3_state)
            call_for_crossing <= 1;
        
        if (longcount == 100)
            call_for_crossing <= 0;
    end


    // General timing
    always @ (posedge(SLOWCLK))
    begin
        if (call_for_crossing == 1 & longcount > 40 & longcount < 100)
            longcount <= 100;
        
        else if (longcount == 111)
        begin
            countdown <= 4'b1111;
            longcount = longcount + 1;
        end
        else if (longcount >= 112 & longcount < 120) // Count down just before cars green ends
        begin
            if (longcount[0] == 1)
                countdown <= countdown >> 1;
            
            longcount <= longcount + 1;
        end
        else if (longcount >= 120 & longcount < 124) // Transition from cars green to cars red
        begin
            cars_red <= 0;
            cars_amber <= 1;
            cars_green <= 0;
            walk_red <= 1;
            walk_green <= 0;
            
            longcount <= longcount + 1;
        end
        else if (longcount >= 124 & longcount < 126) // Cars just became red
        begin
            cars_red <= 1;
            cars_amber <= 0;
            cars_green <= 0;
            walk_red <= 1;
            walk_green <= 0;
            
            longcount <= longcount + 1;
        end
        else if (longcount >= 126 & longcount < 138) // Walk becomes green
        begin
            cars_red <= 1;
            cars_amber <= 0;
            cars_green <= 0;
            walk_red <= 0;
            walk_green <= 1;
            
            countdown <= 4'b1111;
            longcount <= longcount + 1;
        end
        else if (longcount >= 138 & longcount < 146) // Count down at end of walk green
        begin
            cars_red <= 1;
            cars_amber <= 0;
            cars_green <= 0;
            walk_red <= 0;
            walk_green <= 1;
            
            if (longcount[0] == 1)
                countdown <= countdown >> 1;
            
            longcount <= longcount + 1;
        end
        else if (longcount >= 146 & longcount < 158) // Transition from walk green to walk red
        begin            
            cars_red <= 0;
            cars_amber <= longcount[0];
            cars_green <= 0;
            walk_red <= 0;
            walk_green <= longcount[0];
            
            longcount <= longcount + 1;
        end
        else if (longcount >= 158 & longcount < 159) // Walk just became red
        begin
            cars_red <= 0;
            cars_amber <= 1;
            cars_green <= 0;
            walk_red <= 1;
            walk_green <= 0;
            
            longcount <= longcount + 1;
        end
        
        else if (longcount == 159) // Return to initial count, thus default behaviour: cars green
            longcount <= 0;
        
        else
        begin
            cars_red <= 0;
            cars_amber <= 0;
            cars_green <= 1;
            walk_red <= 1;
            walk_green <= 0;
            
            longcount <= longcount + 1;
        end
    end
    
    
    // Light up the RGB LEDs
    // RGB LED0
    PWMLED pwmled0_r(
        .clock(CLK100MHZ),
        .pwm_duty(walk_red * 32),
        .pwm_state(led0_r)
        );
    PWMLED pwmled0_g(
        .clock(CLK100MHZ),
        .pwm_duty(walk_green * 12),
        .pwm_state(led0_g)
        );
    
    // RGB LED1
    PWMLED pwmled1_r(
        .clock(CLK100MHZ),
        .pwm_duty(cars_red * 32),
        .pwm_state(led1_r)
        );
    
    // RGB LED2
    PWMLED pwmled2_r(
        .clock(CLK100MHZ),
        .pwm_duty(cars_amber * 32),
        .pwm_state(led2_r)
        );
    PWMLED pwmled2_g(
        .clock(CLK100MHZ),
        .pwm_duty(cars_amber * 8),
        .pwm_state(led2_g)
        );
    PWMLED pwmled2_b(
        .clock(CLK100MHZ),
        .pwm_duty(cars_amber * 2),
        .pwm_state(led2_b)
        );
        
    // RGB LED3
    PWMLED pwmled3_g(
        .clock(CLK100MHZ),
        .pwm_duty(cars_green * 12),
        .pwm_state(led3_g)
        );
    
    // Light up the monochromatic LEDs for countdown
    assign led0 = countdown[0];
    assign led1 = countdown[1];
    assign led2 = countdown[2];
    assign led3 = countdown[3];
    
endmodule
