#
#  colour_chooser1.py
#  Program to freely choose colour of the RGB LEDs
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

#  Program to simultaneously light up the 4 RGB LEDs to a colour
#  which the user chooses. The level of each colour is adjusted
#  using the buttons.
#  BTN2: R, BTN1: G, BTN0: B
#
#  The position of the switches of the same index determine if
#  the change is an increment or decrement. If the switch is up
#  the corresponding level will be increased when the button is
#  pressed, but decreased otherwise.
#  SW2: R, SW1: G, SW0: B
#
#  *e.g. If SW2 and SW0 are up, but SW1 is down,<br/>
#  when BTN2 will be pressed, level of R will increase,<br/>
#  when BNT0 will be pressed, level of B will increase,<br/>
#  but when BTN1 will be pressed, level of G will decrease.*
#
#  Initially, all the LEDs are off, i.e. PWM duty level 0.
#


from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform


###  BEGIN Describe platform  ###

_io = [ ("CLK100MHZ", 0, Pins("E3"), IOStandard("LVCMOS33")),

        ("RGBled",  0, Pins("G6"), IOStandard("LVCMOS33")), # RGBLED0 r
        ("RGBled",  1, Pins("F6"), IOStandard("LVCMOS33")), # RGBLED0 g
        ("RGBled",  2, Pins("E1"), IOStandard("LVCMOS33")), # RGBLED0 b

        ("RGBled",  3, Pins("G3"), IOStandard("LVCMOS33")), # RGBLED1 r
        ("RGBled",  4, Pins("J4"), IOStandard("LVCMOS33")), # RGBLED1 g
        ("RGBled",  5, Pins("G4"), IOStandard("LVCMOS33")), # RGBLED1 b

        ("RGBled",  6, Pins("J3"), IOStandard("LVCMOS33")), # RGBLED2 r
        ("RGBled",  7, Pins("J2"), IOStandard("LVCMOS33")), # RGBLED2 g
        ("RGBled",  8, Pins("H4"), IOStandard("LVCMOS33")), # RGBLED2 b

        ("RGBled",  9, Pins("K1"), IOStandard("LVCMOS33")), # RGBLED3 r
        ("RGBled", 10, Pins("H6"), IOStandard("LVCMOS33")), # RGBLED3 g
        ("RGBled", 11, Pins("K2"), IOStandard("LVCMOS33")), # RGBLED3 b

        ("button", 0, Pins("B9"), IOStandard("LVCMOS33")), # R
        ("button", 1, Pins("C9"), IOStandard("LVCMOS33")), # G
        ("button", 2, Pins("D9"), IOStandard("LVCMOS33")), # B

        ("reset", 0, Pins("B8"), IOStandard("LVCMOS33")), # Reset button

        ("switch", 0, Pins("C10"), IOStandard("LVCMOS33")), # R
        ("switch", 1, Pins("C11"), IOStandard("LVCMOS33")), # G
        ("switch", 2, Pins("A8"), IOStandard("LVCMOS33")) ] # B


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

        btn_state = Array(Signal() for a in range(3))
        reset_state = Signal()

        debreset = Debounce(platform.request("reset"), reset_state)
        self.submodules += [ debreset ]

        pwm_duty = Array(Signal(max=32) for b in range(3))


        for i in range(0,3):
            # Debounce buttons
            debbtn = Debounce(platform.request("button", i), btn_state[i])

            self.submodules += [ debbtn ]

            # Sequential code
            self.sync += [
                    If (btn_state[i] == 1,
                        If (platform.request("switch", i) == 1,
                            pwm_duty[i].eq(pwm_duty[i] + 2)
                        ).Else (
                            pwm_duty[i].eq(pwm_duty[i] - 2)
                        )
                    ),

                    # Switch off LEDs if reset is pressed
                    If (reset_state == 1,
                        pwm_duty[i].eq(0)
                    )
            ]

            # Light up RGB LEDs
            for j in range(0,4):
                pwmled = PWM(pwm_duty[i], platform.request("RGBled", 3*j + i))
                self.submodules += [ pwmled ]


        # Concurrent code
        self.comb += [ ]

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
