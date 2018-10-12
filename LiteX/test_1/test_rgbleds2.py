#
#  test_rgbleds2.py
#
#  Test script for all RGB LEDs.
#  RGB LED0 is lit with random values which change every 1 second.
#  Then, these levels are passed to RGB LED1 and new values are
#  generated for LED0. The loop finally slides the PWM levels across
#  all 4 RGB LEDs at intervals of 1 second. Thus, the overall number
#  of steps in the loop determine the total time of execution.
#
#  Copyright (C) 2018  Nitish Ragoomundun, Mauritius
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

import time
import random

from litex.soc.tools.remote import RemoteClient

wb = RemoteClient()
wb.open()


# Initialise all RGB LEDs with PWM duty 0
wb.regs.rgbled0_r_duty.write(0)
wb.regs.rgbled0_g_duty.write(0)
wb.regs.rgbled0_b_duty.write(0)
wb.regs.rgbled1_r_duty.write(0)
wb.regs.rgbled1_g_duty.write(0)
wb.regs.rgbled1_b_duty.write(0)
wb.regs.rgbled2_r_duty.write(0)
wb.regs.rgbled2_g_duty.write(0)
wb.regs.rgbled2_b_duty.write(0)
wb.regs.rgbled3_r_duty.write(0)
wb.regs.rgbled3_g_duty.write(0)
wb.regs.rgbled3_b_duty.write(0)

# Initialise RNG
random.seed()


# Array to hold duty values for each r,g,b of each LED
rand_array = [0 for i in range(12)]

print("Testing RGB Leds (Random)...")
for i in range(300):

    # Change RGB LED0's duty levels
    rand_array[0] = random.randint(0,10)
    rand_array[1] = random.randint(0,10)
    rand_array[2] = random.randint(0,10)

    # Light up the LEDs
    wb.regs.rgbled0_r_duty.write(rand_array[0])
    wb.regs.rgbled0_g_duty.write(rand_array[1])
    wb.regs.rgbled0_b_duty.write(rand_array[2])
    wb.regs.rgbled1_r_duty.write(rand_array[3])
    wb.regs.rgbled1_g_duty.write(rand_array[4])
    wb.regs.rgbled1_b_duty.write(rand_array[5])
    wb.regs.rgbled2_r_duty.write(rand_array[6])
    wb.regs.rgbled2_g_duty.write(rand_array[7])
    wb.regs.rgbled2_b_duty.write(rand_array[8])
    wb.regs.rgbled3_r_duty.write(rand_array[9])
    wb.regs.rgbled3_g_duty.write(rand_array[10])
    wb.regs.rgbled3_b_duty.write(rand_array[11])

    # Slide the duty levels across the RGB LEDs
    for j in range(3, 0, -1):  # loop over 4 LEDs
        for k in range(0, 3):  # loop over R, G and B
            rand_array[3*j + k] = rand_array[3*(j-1) + k]

    time.sleep(1.0)

time.sleep(2.0)

# Switch off RGB LED
wb.regs.rgbled0_r_duty.write(0)
wb.regs.rgbled0_g_duty.write(0)
wb.regs.rgbled0_b_duty.write(0)
wb.regs.rgbled1_r_duty.write(0)
wb.regs.rgbled1_g_duty.write(0)
wb.regs.rgbled1_b_duty.write(0)
wb.regs.rgbled2_r_duty.write(0)
wb.regs.rgbled2_g_duty.write(0)
wb.regs.rgbled2_b_duty.write(0)
wb.regs.rgbled3_r_duty.write(0)
wb.regs.rgbled3_g_duty.write(0)
wb.regs.rgbled3_b_duty.write(0)


wb.close()
