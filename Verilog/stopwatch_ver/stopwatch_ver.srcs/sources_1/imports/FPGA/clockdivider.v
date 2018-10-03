//
//  Clockdivider module - Verilog
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
// Create Date: 22.08.2018 13:26:04
// Design Name: 
// Module Name: clockdivider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Stand-alone module for dividing clock frequency.
//              half_T is an integer input half the frequency,
//              T is an integer input equal to (frequency - 1).
//              (Verilog)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clockdivider(
    input clock,
    input [26:0] half_T,
    input [26:0] T,
    output reg slowclock
    );
    
    reg [26:0] counter = 0;
    
    always @ (posedge(clock))
    begin
        counter <= (counter >= T) ? 0 : counter + 1;
        slowclock <= (counter < half_T) ? 0 : 1;
    end

endmodule
