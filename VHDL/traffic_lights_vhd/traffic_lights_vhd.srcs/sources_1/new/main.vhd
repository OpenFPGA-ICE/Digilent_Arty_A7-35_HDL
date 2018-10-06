--
--  Program to simulate traffic lights using the RGB LEDs - VHDL
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
-- Create Date: 30.08.2018 14:53:21
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Program to control traffic lights. LD1-LD3 are for cars while LD0
--              is for pedestrians and will switch between red and green.
--              One cycle takes around 1min 20s. The lights are green for cars for
--              around 1 minute. The press of BTN3 can bring this down to 20s as
--              BTN3 is set to be used by pedestrian to request crossing.
-- 
-- Dependencies: clockdivider.vhd, debounce.vhd, PWMLED.vhd
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( CLK100MHZ : in STD_LOGIC;
           btn3 : in STD_LOGIC;
           led0_r, led0_g : out STD_LOGIC;
           led1_r : out STD_LOGIC;
           led2_r, led2_g, led2_b : out STD_LOGIC;
           led3_g : out STD_LOGIC;
           led0, led1, led2, led3 : out STD_LOGIC
           );
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
    signal btn3_state : STD_LOGIC;
    signal call_for_crossing : STD_LOGIC;
    signal count : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    signal countdown : UNSIGNED (3 downto 0) := (others => '0');
    signal traffic_sig_state : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal duty_0r, duty_0g : INTEGER range 0 to 32 := 0;
    signal duty_1r : INTEGER range 0 to 32 := 0;
    signal duty_2r, duty_2g, duty_2b  : INTEGER range 0 to 32;
    signal duty_3g : INTEGER range 0 to 32;
begin

    -- traffic_sig_state contains the Boolean logic state for each colour
    -- traffic_sig_state(0) : cars_red
    -- traffic_sig_state(1) : cars_amber
    -- traffic_sig_state(2) : cars_green
    -- traffic_sig_state(3) : walk_red
    -- traffic_sig_state(4) : walk_green
    

    -- Generate slow clock with 2 cycles per second
    CLKDIV: clockdivider port map(clock => CLK100MHZ,
                                  half_T => 25000000,
                                  T => 49999999,
                                  slowclock => SLOWCLK);

    -- Debounce input from btn3
    BUTTON3: debounce port map(clock => CLK100MHZ,
                               button => btn3,
                               deb_state => btn3_state);

    -- Check state of btn3
    process (CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            if (btn3_state = '1') then
                call_for_crossing <= '1';
            end if;
            
            if (count = 100) then
                call_for_crossing <= '0';
            end if;
        end if;
    end process;
    
    
    -- Real time operation of the traffic lights
    process (SLOWCLK)
    begin
        if rising_edge(SLOWCLK) then
            -- if someone called for crossing, put 100 in count.
            if (call_for_crossing = '1' and count > 40 and count < 100) then
                count <= (6 => '1', 5 => '1', 2 => '1', others => '0');
                
            elsif (count = 111) then
                countdown <= b"1111";
                count <= count + 1;
                
            -- Count down just before cars green ends
            elsif (count >= 112 and count < 120) then
                traffic_sig_state <= b"01100";
                
                if (count(0) = '1') then
                    countdown <= shift_right(countdown, 1);
                end if;
                
                count <= count + 1;
                
            -- Transition from cars green to cars red
            elsif (count >= 120 and count < 124) then
                traffic_sig_state <= b"01010";
                
                count <= count + 1;
                
            -- Cars just became red
            elsif (count >= 124 and count < 126) then
                traffic_sig_state <= b"01001";
                
                count <= count + 1;
                
            -- Walk becomes green
            elsif (count >= 126 and count < 138) then
                traffic_sig_state <= b"10001";
                
                countdown <= b"1111";
                count <= count + 1;
                
            -- Count down at end of walk green
            elsif (count >= 138 and count < 146) then
                traffic_sig_state <= b"10001";
                
                if (count(0) = '1') then
                    countdown <= shift_right(countdown, 1);
                end if;
                
                count <= count + 1;
                
            -- Transition from walk green to walk red
            elsif (count >= 146 and count < 158) then
                traffic_sig_state(0) <= '0';
                traffic_sig_state(1) <= count(0);
                traffic_sig_state(2) <= '0';
                traffic_sig_state(3) <= '0';
                traffic_sig_state(4) <= count(0);
                
                count <= count + 1;
                
            -- Walk becomes red
            elsif (count >= 158 and count < 159) then
                traffic_sig_state <= b"01010";
                
                count <= count + 1;
                
            -- Return to initial count, thus default behaviour: cars green
            elsif (count = 159) then
                count <= (others => '0');
                
            -- Default
            else
                traffic_sig_state <= b"01100";
                count <= count + 1;
                
            end if;
        
        end if;
    end process;


    -- Light up RGB LEDs
    -- RGB LED0 : Walk red and green
    duty_0r <= 32 when (traffic_sig_state(3) = '1') else 0;
    duty_0g <= 12 when (traffic_sig_state(4) = '1') else 0;
    RGBLED_0R: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_0r, pwm_state => led0_r);
    RGBLED_0G: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_0g, pwm_state => led0_g);
    
    -- RGB LED1 : Cars red
    duty_1r <= 32 when (traffic_sig_state(0) = '1') else 0;
    RGBLED_1R: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_1r, pwm_state => led1_r);

    -- RGB LED2 : Cars amber
    duty_2r <= 32 when (traffic_sig_state(1) = '1') else 0;
    duty_2g <=  8 when (traffic_sig_state(1) = '1') else 0;
    duty_2b <=  2 when (traffic_sig_state(1) = '1') else 0;
    RGBLED_2R: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2r, pwm_state => led2_r);
    RGBLED_2G: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2g, pwm_state => led2_g);
    RGBLED_2B: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_2b, pwm_state => led2_b);
    
    -- RGB LED3 : Cars green
    duty_3g <= 12 when (traffic_sig_state(2) = '1') else 0;
    RGBLED_3G: PWMLED port map(clock => CLK100MHZ, pwm_duty => duty_3g, pwm_state => led3_g);
    
    
    -- Light up monochromatic LEDs
    led0 <= countdown(0);
    led1 <= countdown(1);
    led2 <= countdown(2);
    led3 <= countdown(3);

end Behavioral;
