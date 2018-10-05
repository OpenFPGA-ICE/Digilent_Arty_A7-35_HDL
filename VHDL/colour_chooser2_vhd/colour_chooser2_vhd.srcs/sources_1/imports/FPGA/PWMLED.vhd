--
--  PWM module - VHDL
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
-- Create Date: 14.08.2018 12:51:56
-- Design Name: 
-- Module Name: PWMLED - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Module which takes an integer level of brightness
--              and outputs PW-modulated logic level for a LED.
--              Integer input ranges from 0 to 255.
--              (VHDL)
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWMLED is
    Port ( clock : in STD_LOGIC;
           pwm_duty: in INTEGER range 0 to 255;
           pwm_state : out STD_LOGIC);
end PWMLED;

architecture Behavioral of PWMLED is
    signal pwm_counter : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin

    process(clock)
    begin
        if rising_edge(clock) then
        
            pwm_counter <= pwm_counter + 1;
            
            if (pwm_counter < pwm_duty) then
                pwm_state <= '1';
            else
                pwm_state <= '0';
            end if;
            
        end if;
    end process;

end Behavioral;
