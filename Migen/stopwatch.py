#
#  stopwatch.py
#  8-bit binary stopwatch using 4 monochromatic LEDs and
#  4 RGB LEDs
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

#  Program implementing a stopwatch which displays the number
#  of elapsed seconds in binary format using 8 LEDs. Thus,
#  maximum number of seconds which can be counted is 255.
#
#  Switch SW3 is used to start and stop the stopwatch, while
#  BTN3 is the reset button.
#


from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform


###  BEGIN Describe platform  ###

_io = [ ("CLK100MHZ", 0, Pins("E3"), IOStandard("LVCMOS33")),

        ("RGBled_r", 0, Pins("G6"), IOStandard("LVCMOS33")),
        ("RGBled_r", 1, Pins("G3"), IOStandard("LVCMOS33")),
        ("RGBled_r", 2, Pins("J3"), IOStandard("LVCMOS33")),
        ("RGBled_r", 3, Pins("K1"), IOStandard("LVCMOS33")),
        ("RGBled_g", 0, Pins("F6"), IOStandard("LVCMOS33")),
        ("RGBled_g", 1, Pins("J4"), IOStandard("LVCMOS33")),
        ("RGBled_g", 2, Pins("J2"), IOStandard("LVCMOS33")),
        ("RGBled_g", 3, Pins("H6"), IOStandard("LVCMOS33")),
        ("RGBled_b", 0, Pins("E1"), IOStandard("LVCMOS33")),
        ("RGBled_b", 1, Pins("G4"), IOStandard("LVCMOS33")),
        ("RGBled_b", 2, Pins("H4"), IOStandard("LVCMOS33")),
        ("RGBled_b", 3, Pins("K2"), IOStandard("LVCMOS33")),

        ("Monoled", 0, Pins("H5"), IOStandard("LVCMOS33")),
        ("Monoled", 1, Pins("J5"), IOStandard("LVCMOS33")),
        ("Monoled", 2, Pins("T9"), IOStandard("LVCMOS33")),
        ("Monoled", 3, Pins("T10"), IOStandard("LVCMOS33")),

        ("button", 0, Pins("B8"), IOStandard("LVCMOS33")),
        ("switch", 0, Pins("A10"), IOStandard("LVCMOS33")) ]



class Platform(XilinxPlatform):
    default_clk_name = "CLK100MHZ"
    default_clk_period = 10.00

    def __init__(self):
        XilinxPlatform.__init__(self, "xc7a35ticsg324-1L", _io, toolchain="vivado")

    def do_finalize(self, fragment):
        XilinxPlatform.do_finalize(self, fragment);

###  END Describe platform  ###



###  BEGIN module Debounce  ###
class Debounce(Module):
    def __init__(self, button, deb_state):
        curr_state = Signal()
        idle = Signal()
        sync0 = Signal()
        sync1 = Signal()
        counter = Signal(18)

        # Initialise wires
        idle.eq(0)
        sync0.eq(0)
        sync1.eq(0)
        curr_state.eq(0)

        # Sequential code
        self.sync += [
                sync0.eq(button),
                sync1.eq(sync0),

                If ((idle),
                    counter.eq(0)
                ).Else (
                    counter.eq(counter + 1),
                    If (counter >= 249999,  # debounce on delay of 2.5 ms
                        curr_state.eq(~curr_state)
                    )
                )
        ]

        # Concurrent code
        self.comb += [
                idle.eq(curr_state == sync1),
                deb_state.eq(~idle & (counter >= 249999) & ~curr_state)
        ]

###  END module Debounce  ###



###  BEGIN module PWMLED  ###
class PWM(Module):
    def __init__(self, pwm_duty, LED):
        counter = Signal(8)  # 0 -- 255

        # sequential code
        self.sync += [ counter.eq(counter + 1) ]

        # concurrent code
        self.comb += [ LED.eq( counter < pwm_duty ) ]

###  END module PWMLED  ###



###  BEGIN module main  ###
class main(Module):
    def __init__(self, platform):

        # Signals local to main
        counter = Signal(27)
        countsec = Signal(8)
        btn_state = Signal()
        pwm_duty = Signal(8)

        # Initialise button state variables and pwm_duty
        btn_state.eq(0)


        # Debounce button
        debbtn = Debounce(platform.request("button"), btn_state)
        self.submodules += debbtn


        # Sequential code
        self.sync += [
                If (platform.request("switch") == 1,
                    If (counter >= int(100e6 - 1),
                        countsec.eq(countsec + 1),
                        counter.eq(0)
                    ).Else (
                        counter.eq(counter + 1)
                    )
                ),

                If (btn_state == 1,
                    countsec.eq(0),
                    counter.eq(0)
                )
        ]

        # Concurrent code
        for i in range(0,4):
            led = platform.request("Monoled", i)
            self.comb += [ led.eq(countsec[i]) ]

        # Light up RBG LEDs
        # R
        for i in range(0,4):
            led = platform.request("RGBled_r", i)
            pwmledr = PWM(7 * countsec[4+i], led)
            self.submodules += pwmledr
        # G
        for i in range(0,4):
            led = platform.request("RGBled_g", i)
            pwmledg = PWM(1 * countsec[4+i], led)
            self.submodules += pwmledg
        # B
        for i in range(0,4):
            led = platform.request("RGBled_b", i)
            pwmledb = PWM(32 * countsec[4+i], led)
            self.submodules += pwmledb

###  END module main  ###



###  BEGIN Design  ###

# Create the platform
platform = Platform()

# Create the module
module = main(platform)

###  END Design  ###


###  Build  ###
platform.build(module)


exit(0)
