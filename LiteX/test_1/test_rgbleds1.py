#
#  test_rgbleds1.py
#
#  Test script for testing RGB LED 0. Firstly, the brightness
#  is cycled using increasing, then decreasing PWM duty levels.
#  Then, the RGB LED is lit with random levels on R, G and B.
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

# Initialise RGB LED0 with PWM duty 0
wb.regs.rgbled0_r_duty.write(0)

# Cycle through brightness levels for R
print("Testing RGB Led 0 (PWM)...")
for i in range(4):
    for j in range(0, 32):
        wb.regs.rgbled0_r_duty.write(j)
        time.sleep(0.1)
    for j in range(0, 32):
        wb.regs.rgbled0_r_duty.write(32 - j)
        time.sleep(0.1)

# Switch off RGB LED0
wb.regs.rgbled0_r_duty.write(0)
time.sleep(1)


# test RGB LED with random
random.seed()
print("Testing RGB Led 0 (Random)...")
for i in range(128):
	wb.regs.rgbled0_r_duty.write(random.randint(0,10))
	wb.regs.rgbled0_g_duty.write(random.randint(0,10))
	wb.regs.rgbled0_b_duty.write(random.randint(0,10))
	time.sleep(0.2)

# Switch off RGB LED
wb.regs.rgbled0_r_duty.write(0)
wb.regs.rgbled0_g_duty.write(0)
wb.regs.rgbled0_b_duty.write(0)

wb.close()
