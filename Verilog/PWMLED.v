//
//  PWM module - Verilog
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
// Create Date: 09.08.2018 15:37:15
// Design Name: 
// Module Name: PWMLED
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: stand alone module which takes a clock and duty value as input
//              and outputs a LED level depending on the the duty brightness.
//              (Verilog)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PWMLED(
    input clock,
    input [7:0] pwm_duty,
    output reg pwm_state
    );
    
    reg [7:0] pwm_counter = 0;
    
    always @ (posedge(clock))
    begin
        pwm_counter <= pwm_counter + 1;
        pwm_state <= (pwm_counter < pwm_duty);
    end
endmodule
