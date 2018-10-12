#
#  test_btn_sw.py
#
#  Test script to test buttons by registering their states.
#  Each button is a bit in hexadecimal, where the power is the
#  index of the button.
#  e.g. BTN2: state x 16**2
#  Same goes for the switches.
#  The total hexadecimal value is printed for both buttons and
#  switches.
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

from litex.soc.tools.remote import RemoteClient

wb = RemoteClient()
wb.open()

# # #

# test buttons
print("Testing Buttons/Switches...")
while True:
    buttons = wb.regs.buttons_in.read()
    switches = wb.regs.switches_in.read()
    print("buttons: {:#3x} -- switches: {:#3x}".format(buttons, switches))
    time.sleep(0.5)

# # #

wb.close()
