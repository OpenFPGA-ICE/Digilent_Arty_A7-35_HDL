--
--  Program to light up each of the 4 RGB LEDs with any colour
--  combination - VHDL
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
-- Create Date: 04.10.2018 13:39:18
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: The program allows the user to light up each one of the four RGB
--              LEDs to any colour using different R, G and B combinations on
--              each LED.
--              The switches are used to activate the LEDs. If a switch is in up
--              position, the RGB LED with index corresponding to the switch will
--              be affected when the R, G and B levels are changed, or when the
--              reset button is pressed. If the switch is in the down position,
--              the corresponding LED will not be affected at all.
--              SW3: LD3, SW2: LD2, SW1: LD1, SW0: LD0.
--
--              The buttons are used to change the R, G and B levels, and also to
--              reset active LEDs to 0 level (unlit).
--              BTN3: reset, BTN2: R, BTN1: G, BTN0: B.
-- 
-- Dependencies: debounce.vhd, PWMLED.vhd
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
           btn0, btn1, btn2, btn3 : in STD_LOGIC;
           sw0, sw1, sw2, sw3: in STD_LOGIC;
           led0_r, led0_g, led0_b: out STD_LOGIC;
           led1_r, led1_g, led1_b: out STD_LOGIC;
           led2_r, led2_g, led2_b: out STD_LOGIC;
           led3_r, led3_g, led3_b: out STD_LOGIC);

end main;

architecture Behavioral of main is
    -- Debouncer module
    component debounce
        Port ( clock : in STD_LOGIC;
               button : in STD_LOGIC;
               deb_state : out STD_LOGIC);
    end component;

-- PWM module
    component PWMLED
        Port ( clock : in STD_LOGIC;
               pwm_duty: in INTEGER range 0 to 255;
               pwm_state : out STD_LOGIC);
        end component;

-- signals local to main
    signal reset : STD_LOGIC := '0';
    signal btns_state : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal duty_0r : INTEGER range 0 to 64;
    signal duty_0g : INTEGER range 0 to 64;
    signal duty_0b : INTEGER range 0 to 64;
    signal duty_1r : INTEGER range 0 to 64;
    signal duty_1g : INTEGER range 0 to 64;
    signal duty_1b : INTEGER range 0 to 64;
    signal duty_2r : INTEGER range 0 to 64;
    signal duty_2g : INTEGER range 0 to 64;
    signal duty_2b : INTEGER range 0 to 64;
    signal duty_3r : INTEGER range 0 to 64;
    signal duty_3g : INTEGER range 0 to 64;
    signal duty_3b : INTEGER range 0 to 64;

begin
    -- debounce input from the 4 buttons
    BUTTON0 : debounce port map(clock => CLK100MHZ,
                                button => btn0,
                                deb_state => btns_state(0));

    BUTTON1 : debounce port map(clock => CLK100MHZ,
                                button => btn1,
                                deb_state => btns_state(1));

    BUTTON2 : debounce port map(clock => CLK100MHZ,
                                button => btn2,
                                deb_state => btns_state(2));

    BUTTON3 : debounce port map(clock => CLK100MHZ,
                                button => btn3,
                                deb_state => reset);

    -- Evaluate states of buttons and switches,
    -- and adjust PWM duty levels accordingly
    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
        
            -- BTN3: Reset
            if (reset = '1') then
                if (sw3 = '1') then
                    duty_3r <= 0;
                    duty_3g <= 0;
                    duty_3b <= 0;
                end if;
                if (sw2 = '1') then
                    duty_2r <= 0;
                    duty_2g <= 0;
                    duty_2b <= 0;
                end if;
                if (sw1 = '1') then
                    duty_1r <= 0;
                    duty_1g <= 0;
                    duty_1b <= 0;
                end if;
                if (sw0 = '1') then
                    duty_0r <= 0;
                    duty_0g <= 0;
                    duty_0b <= 0;
                end if;
            end if;            
            
            -- BTN2: R
            if (btns_state(2) = '1') then
                if (sw3 = '1') then
                    duty_3r <= duty_3r + 2;
                end if;
                if (sw2 = '1') then
                    duty_2r <= duty_2r + 2;
                end if;
                if (sw1 = '1') then
                    duty_1r <= duty_1r + 2;
                end if;
                if (sw0 = '1') then
                    duty_0r <= duty_0r + 2;
                end if;
            end if;
            
            -- BTN1: G
            if (btns_state(1) = '1') then
                if (sw3 = '1') then
                    duty_3g <= duty_3g + 2;
                end if;
                if (sw2 = '1') then
                    duty_2g <= duty_2g + 2;
                end if;
                if (sw1 = '1') then
                    duty_1g <= duty_1g + 2;
                end if;
                if (sw0 = '1') then
                    duty_0g <= duty_0g + 2;
                end if;
            end if;

            -- BTN0: B
            if (btns_state(0) = '1') then
                if (sw3 = '1') then
                    duty_3b <= duty_3b + 2;
                end if;
                if (sw2 = '1') then
                    duty_2b <= duty_2b + 2;
                end if;
                if (sw1 = '1') then
                    duty_1b <= duty_1b + 2;
                end if;
                if (sw0 = '1') then
                    duty_0b <= duty_0b + 2;
                end if;
            end if;

        end if;
    end process;


    -- Light up the RGB LEDs
    RGBLED0_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_0r, pwm_state => led0_r);
    RGBLED0_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_0g, pwm_state => led0_g);
    RGBLED0_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_0b, pwm_state => led0_b);
    
    RGBLED1_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_1r, pwm_state => led1_r);
    RGBLED1_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_1g, pwm_state => led1_g);
    RGBLED1_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_1b, pwm_state => led1_b);

    RGBLED2_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2r, pwm_state => led2_r);
    RGBLED2_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2g, pwm_state => led2_g);
    RGBLED2_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2b, pwm_state => led2_b);
    
    RGBLED3_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_3r, pwm_state => led3_r);
    RGBLED3_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_3g, pwm_state => led3_g);
    RGBLED3_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_3b, pwm_state => led3_b);

end Behavioral;