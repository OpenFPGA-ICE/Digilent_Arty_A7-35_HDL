#
#  test_monoleds.py
#
#  Script to light up the monochromatic LEDs using an
#  integer value. The monochromatic LEDs are bound as the
#  bits in a 4 bit value.
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


# test led
print("Testing Led...")
for i in range(0, 64):
    wb.regs.leds_out.write(i)
    time.sleep(0.1)

time.sleep(2.0)

# switch all the LEDs off
wb.regs.leds_out.write(0)

wb.close()
