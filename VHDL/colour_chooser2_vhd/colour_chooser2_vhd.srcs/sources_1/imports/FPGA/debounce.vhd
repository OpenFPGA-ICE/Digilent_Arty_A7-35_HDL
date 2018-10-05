--
--  Debouncer module - VHDL
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
-- Create Date: 21.08.2018 13:17:39
-- Design Name: 
-- Module Name: debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Button debouncing stand-alone module in VHDL
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

entity debounce is
    Port ( clock : in STD_LOGIC;
           button : in STD_LOGIC;
           deb_state : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
    signal idle : STD_LOGIC := '0';
    signal curr_state : STD_LOGIC := '0';
    signal sync0 : STD_LOGIC := '0';
    signal sync1 : STD_LOGIC := '0';
    signal max : STD_LOGIC := '0';
    signal counter : STD_LOGIC_VECTOR (17 downto 0) := (others => '0');
begin

    -- sync with clock --
    process(clock)
    begin
        if rising_edge(clock) then
            sync0 <= button;
            sync1 <= sync0;
        end if;
    end process;
    
    
    -- Check if button is in idle state
    idle <= '1' when (curr_state = sync1) else '0';
    
    
    -- and if not, monitor for 2.5 ms before
    -- confirming state
    process(clock)
    begin
        if rising_edge(clock) then
            if (idle = '1') then
                counter <= (others => '0');
            else
                counter <= counter + 1;
                if (counter >= 249999) then
                    curr_state <= not curr_state;
                end if;
            end if;
        end if;
    end process;
    
    max <= '1' when (counter >= 249999) else '0';
    deb_state <= (not idle) and max and (not curr_state);

end Behavioral;
