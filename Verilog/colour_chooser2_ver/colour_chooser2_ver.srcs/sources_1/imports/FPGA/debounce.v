//
//  Debouncer module - Verilog
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
// Create Date: 18.08.2018 10:28:32
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Stand-alone module for debouncing buttons in Verilog
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce(
    input clock,
    input button,
    output deb_state
    );

    reg curr_state = 0;
    reg sync0 = 0, sync1 = 0;
    reg [17:0] counter;
    
        
    // sync with clock
    always @ (posedge(clock))
        sync0 <= button;
    always @ (posedge(clock))
        sync1 <= sync0;
    
    // check if button is in an idle state
    wire idle = (curr_state == sync1);
    
    
    always @ (posedge(clock))
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            
            // since clock frequency is 100MHz,
            // debounce on 2.5 ms <=> 250000 counts
            if (counter >= 249999)
                curr_state <= ~curr_state;
        end
    end
    
    assign deb_state = ~idle & (counter >= 249999) & ~curr_state;
    
endmodule
