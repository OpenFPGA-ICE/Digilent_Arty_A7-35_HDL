--
--  8-bit binary stopwatch using 4 monochromatic LEDs and
--  4 RGB LEDs - VHDL
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
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Binary stopwatch implemented using the 4 monochromatic LEDs, 4 RGB
--              LEDs. SW3 is used to start and stop the counter. When the switch is
--              in the up position, the counter proceeds and the binary number
--              represented by the LEDs increase. When the switch is brought to the
--              bottom position the counter stops. BTN3 is used to reset the
--              counter to 0, meaning that all LEDs are switched off.
--              LD4 to LD7 represent respectively bits 0,1,2,3 of an 8-bit number.
--              LD0 to LD3 represent respectively bits 4,5,6,7. Thus, a total of
--              255 seconds can be shown using the LEDs.
--
-- Dependencies: clockdivider.vhd, debouncer.vhd, PWMLED.vhd 
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

entity main is
    Port ( CLK100MHZ : in STD_LOGIC;
           sw3 : in STD_LOGIC;
           btn3 : in STD_LOGIC;
           led0, led1, led2, led3 : out STD_LOGIC;
           led0_r, led0_g, led0_b : out STD_LOGIC;
           led1_r, led1_g, led1_b : out STD_LOGIC;
           led2_r, led2_g, led2_b : out STD_LOGIC;
           led3_r, led3_g, led3_b : out STD_LOGIC);
end main;

architecture Behavioral of main is
    -- Clock divider module
    component clockdivider
        Port ( clock : in STD_LOGIC;
               half_T : in INTEGER range 0 to 50000000;
               T : in INTEGER range 0 to 100000000;
               slowclock : out STD_LOGIC);
    end component;
    
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
    signal SLOWCLK : STD_LOGIC;
    signal btn_state : STD_LOGIC := '0';
    signal run : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';
    signal counter : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal count4_r, count4_g, count4_b : INTEGER range 0 to 32 := 0;
    signal count5_r, count5_g, count5_b : INTEGER range 0 to 32 := 0;
    signal count6_r, count6_g, count6_b : INTEGER range 0 to 32 := 0;
    signal count7_r, count7_g, count7_b : INTEGER range 0 to 32 := 0;
    
begin

    -- Generate slow clock with a rate of 1 cycle per second
    CLKDIV : clockdivider port map(clock => CLK100MHZ,
                                   half_T => 50000000,
                                   T => 99999999,
                                   slowclock => SLOWCLK);

    BUTTON0: debounce port map(clock => CLK100MHZ,
                               button => btn3,
                               deb_state => btn_state);


    -- Set up running mode
    process (CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
        
            if (sw3 = '1') then
                run <= '1';
                reset <= '0';
            else
                run <= '0';
            end if;
            
            if (btn_state = '1') then
                run <= '0';
                reset <= '1';
            end if;
            
        end if;
    end process;

    process(SLOWCLK)
    begin
        if rising_edge(SLOWCLK) then
            if (run = '1') then
                counter <= counter + 1;
            end if;
            
            if (reset = '1') then
                counter <= (others => '0');
            end if;
        end if;
    end process;
    
    -- Monochromatic LEDs
    led0 <= counter(0);
    led1 <= counter(1);
    led2 <= counter(2);
    led3 <= counter(3);
    
    -- RGB LED0
    count4_r <=  7 when (counter(4) = '1') else 0;
    count4_g <=  1 when (counter(4) = '1') else 0;
    count4_b <= 32 when (counter(4) = '1') else 0;
    RGBLED0_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => count4_r, pwm_state => led0_r);
    RGBLED0_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => count4_g, pwm_state => led0_g);
    RGBLED0_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => count4_b, pwm_state => led0_b);
    
    -- RGB LED1
    count5_r <=  7 when (counter(5) = '1') else 0;
    count5_g <=  1 when (counter(5) = '1') else 0;
    count5_b <= 32 when (counter(5) = '1') else 0;
    RGBLED1_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => count5_r, pwm_state => led1_r);
    RGBLED1_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => count5_g, pwm_state => led1_g);
    RGBLED1_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => count5_b, pwm_state => led1_b);
    
    -- RGB LED2
    count6_r <=  7 when (counter(6) = '1') else 0;
    count6_g <=  1 when (counter(6) = '1') else 0;
    count6_b <= 32 when (counter(6) = '1') else 0;
    RGBLED2_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => count6_r, pwm_state => led2_r);
    RGBLED2_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => count6_g, pwm_state => led2_g);
    RGBLED2_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => count6_b, pwm_state => led2_b);
    
    -- RGB LED3
    count7_r <=  7 when (counter(7) = '1') else 0;
    count7_g <=  1 when (counter(7) = '1') else 0;
    count7_b <= 32 when (counter(7) = '1') else 0;
    RGBLED3_R : PWMLED port map(clock => CLK100MHZ, pwm_duty => count7_r, pwm_state => led3_r);
    RGBLED3_G : PWMLED port map(clock => CLK100MHZ, pwm_duty => count7_g, pwm_state => led3_g);
    RGBLED3_B : PWMLED port map(clock => CLK100MHZ, pwm_duty => count7_b, pwm_state => led3_b);

end Behavioral;
