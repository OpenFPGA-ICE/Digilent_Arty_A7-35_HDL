#
#  colour_chooser2.py
#  Program to light up each of the 4 RGB LEDs with any colour combination.
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

#  Program to light up the 4 RGB LEDs individually to different
#  colours set by  the user through the operation of buttons 0, 1
#  and 2, which modify the RGB levels distinctly;
#  BTN2: R, BTN1: G, BTN0: B.
#
#  The position of the switches determine which RGB LED is active.
#  If the switch is in an "up" position, the RGB LED corresponding
#  to the index of the switch will be affected when the RGB levels
#  are modified using the buttons. Several LEDs are allowed to be
#  active at the same time.
#  SW3: LD3, SW2: LD2, SW1: LD1, SW0: LD0.
#
#  When a LED is active, a press on buttons 0, 1 or 2 will increase
#  the R, G or B levels of this button. The PWM duty levels wrap
#  around, i.e. if a level reaches 30, a further increase will bring
#  it back to 0.
#
#  Initially, all the LEDs are off, i.e. PWM duty level 0.
#  Button BTN3 is used to reset the duty level of the active LED(s)
#  to 0.
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

        ("reset", 0, Pins("B8"), IOStandard("LVCMOS33")),  # RESET

        ("switch", 0, Pins("A8"),  IOStandard("LVCMOS33")),  # LD0
        ("switch", 1, Pins("C11"), IOStandard("LVCMOS33")),  # LD1
        ("switch", 2, Pins("C10"), IOStandard("LVCMOS33")),  # LD2
        ("switch", 3, Pins("A10"), IOStandard("LVCMOS33")) ] # LD3


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

        sw_states = Array(Signal() for a in range(4))
        btn_states = Array(Signal() for a in range(3))
        reset_state = Signal()
        pwm_duty = Array(Array(Signal(max=32) for a in range(3)) for b in range(4))
        #                                    4 rows x 3 columns


        # Check for RESET
        debreset = Debounce(platform.request("reset"), reset_state)
        self.submodules += [ debreset ]

        # Concurrent code
        for i in range(0,4):
            # Read states of switches
            self.comb += [ sw_states[i].eq(platform.request("switch", i)) ]

        for j in range(0,3):
            # Debounce buttons for RGB control
            debbtn = Debounce(platform.request("button", j), btn_states[j])
            self.submodules += [ debbtn ]


        for i in range(0,4):  # loop over LEDs
            for j in range(0,3):  # loop over colours

                # Sequential code
                self.sync += [
                        If ((sw_states[i] == 1),
                            If (btn_states[j] == 1,
                                pwm_duty[i][j].eq(pwm_duty[i][j] + 2)
                            ),

                            # Switch off LED if reset is pressed
                            If (reset_state == 1,
                                pwm_duty[i][j].eq(0)
                            )
                        )
                ]

                # Light up the LEDs
                pwmled = PWM(pwm_duty[i][j], platform.request("RGBled", 3*i + j))
                self.submodules += [ pwmled ]

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
