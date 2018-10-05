--
--  Clockdivider module - VHDL
--
--  Copyright (C) 2018  Nitish Ragoomundun, Mauritius
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
--
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2018 10:42:47
-- Design Name: 
-- Module Name: clockdivider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Stand-alone module to divide the rate of an input clock
--              (in VHDL)
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockdivider is
    Port ( clock : in STD_LOGIC;
           half_T : in INTEGER range 0 to 50000000;
           T : in INTEGER range 0 to 100000000;
           slowclock : out STD_LOGIC);
end clockdivider;

architecture Behavioral of clockdivider is
    signal counter : STD_LOGIC_VECTOR (26 downto 0) := (others => '0');
begin

    process(clock)
    begin
        if rising_edge(clock) then
        
            -- Update counter
            if (counter >= T) then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
            
            -- Output new clock
            if (counter < half_T) then
                slowclock <= '0';
            else
                slowclock <= '1';
            end if;
            
        end if;
    end process;

end Behavioral;
