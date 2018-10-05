--
--  Program to freely choose colour of the RGB LEDs - VHDL
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
-- Create Date: 18.09.2018 14:27:11
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Program to simultaneously light up the 4 RGB LEDs to a colour
--              which the user chooses. The level of each colour is adjusted
--              using the buttons.
--              BTN2: R, BTN1: G, BTN0: B.
--
--              The position of the switches of the same index determine if
--              the change is an increment or decrement. If the switch is up
--              the corresponding level will be increased when the button is
--              pressed, and decreased otherwise.
--              SW2: R, SW1: G, SW0: B.
--
--              e.g. If SW2 and SW0 are up while SW1 is down,
--              when BTN2 will be pressed, level of R will increase,
--              when BNT0 will be pressed, level of B will increase,
--              when BTN1 will be pressed, level of G will decrease.
--
--              Initially, all the LEDs are off, i.e. PWM duty level 0.
-- 
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
           sw0, sw1, sw2: in STD_LOGIC;
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
    signal duty_r : INTEGER range 0 to 64;
    signal duty_g : INTEGER range 0 to 64;
    signal duty_b : INTEGER range 0 to 64;

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
        
            -- BTN2 : R
            if (btns_state(2) = '1') then
                if (sw2 = '1') then
                    duty_r <= duty_r + 2;
                else
                    duty_r <= duty_r - 2;
                end if;
            end if;
            
            -- BTN1 : G
            if (btns_state(1) = '1') then
                if (sw1 = '1') then
                    duty_g <= duty_g + 2;
                else
                    duty_g <= duty_g - 2;
                end if;
            end if;
            
            -- BTN0 : B
            if (btns_state(0) = '1') then
                if (sw0 = '1') then
                    duty_b <= duty_b + 2;
                else
                    duty_b <= duty_b - 2;
                end if;
            end if;
            
            -- BTN3 : Reset
            if (reset = '1') then
                duty_r <= 0;
                duty_g <= 0;
                duty_b <= 0;
            end if;
            
        end if;
    end process;


    -- Light up the RGB LEDs
    RGBLED0_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_r, pwm_state => led0_r);
    RGBLED0_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_g, pwm_state => led0_g);
    RGBLED0_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_b, pwm_state => led0_b);
    
    RGBLED1_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_r, pwm_state => led1_r);
    RGBLED1_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_g, pwm_state => led1_g);
    RGBLED1_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_b, pwm_state => led1_b);

    RGBLED2_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_r, pwm_state => led2_r);
    RGBLED2_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_g, pwm_state => led2_g);
    RGBLED2_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_b, pwm_state => led2_b);
    
    RGBLED3_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_r, pwm_state => led3_r);
    RGBLED3_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_g, pwm_state => led3_g);
    RGBLED3_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_b, pwm_state => led3_b);

end Behavioral;
