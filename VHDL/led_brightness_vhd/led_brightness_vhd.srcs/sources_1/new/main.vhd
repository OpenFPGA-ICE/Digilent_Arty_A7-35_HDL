--
--  Program to vary brightness of 4 RGB LEDs - VHDL
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
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Program to vary brightness of RGB LEDs using debounced input
--              from buttons in VHDL. BTN0 decreases brightness while BTN1
--              increases the brightness of the LEDs. The LEDs are so bright
--              that a maximum brightness of 64 over 255. The brightness is
--              then varied by steps of 4 between 0 and 64 using PWM.
-- 
-- Dependencies: debouncer.vhd, PWMLED.vhd 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( CLK100MHZ : in STD_LOGIC;
           btn0 : in STD_LOGIC;
           btn1 : in STD_LOGIC;
           led0_g : out STD_LOGIC;
           led1_g : out STD_LOGIC;
           led2_g : out STD_LOGIC;
           led3_g : out STD_LOGIC);
end main;

architecture Behavioral of main is
    -- Debounce module  --
    component debounce
        Port ( clock : in STD_LOGIC;
               button : in STD_LOGIC;
               deb_state : out STD_LOGIC);
    end component;
    
    -- PWM module  --
    component PWMLED
        Port ( clock : in STD_LOGIC;
               pwm_duty: in INTEGER range 0 to 64;
               pwm_state : out STD_LOGIC);
    end component;
    
    -- signals local to main
    signal duty_led : INTEGER range 0 to 64 := 32;
    signal btn0_state : STD_LOGIC := '0';
    signal btn1_state : STD_LOGIC := '0';
begin

    -- debounce btn0
    BUTTON0 : debounce port map(clock => CLK100MHZ, button => btn0, deb_state => btn0_state);
    -- debounce btn1
    BUTTON1 : debounce port map(clock => CLK100MHZ, button => btn1, deb_state => btn1_state);

    -- Check for button states and adjust brightness level
    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
        
            -- BUTTON0
            if (btn0_state = '1') then
                duty_led <= duty_led - 4;
            end if;
            -- BUTTON1
            if (btn1_state = '1') then
                duty_led <= duty_led + 4;
            end if;
            
        end if;
    end process;

    -- Light up the RGB LEDs according to the duty level from above
    LED0 : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_led, pwm_state => led0_g);
    LED1 : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_led, pwm_state => led1_g);
    LED2 : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_led, pwm_state => led2_g);
    LED3 : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_led, pwm_state => led3_g);

end Behavioral;
