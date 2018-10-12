#
#  traffic_lights.py
#  Program to simulate traffic lights on the Arty A7 using the RGB LEDs.
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

#
#  LD1-LD3 are for cars while LD0 is for pedestrians and will switch between
#  red and green.  One cycle takes around 1min 20s. The lights are green for
#  cars for around 1 minute. The press of BTN3 can bring this down to 20s as
#  BTN3 is set to be used by pedestrian to request crossing.
#


from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform


###  BEGIN Describe platform  ###

_io = [ ("CLK100MHZ", 0, Pins("E3"), IOStandard("LVCMOS33")),

        # Pedestrian red/green
        ("walk_red_led", 0, Pins("G6"), IOStandard("LVCMOS33")),
        ("walk_green_led", 0, Pins("F6"), IOStandard("LVCMOS33")),

        # Cars red
        ("cars_red_led", 0, Pins("G3"), IOStandard("LVCMOS33")),

        # Cars amber
        ("cars_amber_led_r", 0, Pins("J3"), IOStandard("LVCMOS33")),
        ("cars_amber_led_g", 0, Pins("J2"), IOStandard("LVCMOS33")),
        ("cars_amber_led_b", 0, Pins("H4"), IOStandard("LVCMOS33")),

        # Cars green
        ("cars_green_led", 0, Pins("H6"), IOStandard("LVCMOS33")),

        # For countdown
        ("Monoled", 0, Pins("H5"), IOStandard("LVCMOS33")),
        ("Monoled", 1, Pins("J5"), IOStandard("LVCMOS33")),
        ("Monoled", 2, Pins("T9"), IOStandard("LVCMOS33")),
        ("Monoled", 3, Pins("T10"), IOStandard("LVCMOS33")),

        ("button", 0, Pins("B8"), IOStandard("LVCMOS33")) ]



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



###  BEGIN module Crossing  ###
class LightUpLEDs(Module):
    def __init__(self, traffic_state, countdown, platform):

        # Sequential code
        self.sync += [ ]

        # Concurrent code
        self.comb += [ ]

        # Light up monochromatic LEDs
        for i in range(0,4):
            led = platform.request("Monoled", i)
            self.comb += [ led.eq(countdown[i]) ]

        # Cars red
        pwm_cars_red = PWM(traffic_state[0] * 32, platform.request("cars_red_led"))

        # Cars amber
        pwm_cars_amber_r = PWM(traffic_state[1] * 32, platform.request("cars_amber_led_r"))
        pwm_cars_amber_g = PWM(traffic_state[1] *  8, platform.request("cars_amber_led_g"))
        pwm_cars_amber_b = PWM(traffic_state[1] *  2, platform.request("cars_amber_led_b"))


        # Cars green
        pwm_cars_green = PWM(traffic_state[2] * 12, platform.request("cars_green_led"))

        # Walk red
        pwm_walk_red = PWM(traffic_state[3] * 32, platform.request("walk_red_led"))

        # Walk green
        pwm_walk_green = PWM(traffic_state[4] * 12, platform.request("walk_green_led"))

        self.submodules += [pwm_cars_red, pwm_cars_amber_r, pwm_cars_amber_g, pwm_cars_amber_b, pwm_cars_green, pwm_walk_red, pwm_walk_green ]

###  END module PWMLED  ###



###  BEGIN module main  ###
class main(Module):
    def __init__(self, platform):

        ###  Signals local to main  ###
        btn_state = Signal()
        call_for_crossing = Signal()

        btn_state.eq(0)
        call_for_crossing.eq(0)

        # Debounce button
        debbtn = Debounce(platform.request("button"), btn_state)
        self.submodules += debbtn


        # Array to hold traffic state in 3-bits binary code
        traffic_state = Signal(5)
        # index 0 : Cars red
        # index 1 : Cars amber
        # index 2 : Cars green
        # index 3 : Walk red
        # index 4 : Walk green

        # default : 01100 (cars red and amber off, cars green on, walk green off, walk red on)


        counter = Signal(27)
        count_halfsec = Signal(8)
        countdown = Signal(4)

        counter.eq(0)
        count_halfsec.eq(0)
        countdown.eq(0)



        # Sequential code
        self.sync += [
                # Decimate clock so that we have periods of 0.5s
                If (counter >= int(50e6 - 1),
                    count_halfsec.eq(count_halfsec + 1),
                    counter.eq(0),
                    If (count_halfsec[0] == 1,
                        countdown.eq(countdown >> 1)
                    )
                ).Else (
                    counter.eq(counter + 1)
                ),

                # If button is activated
                If ((btn_state == 1),
                    call_for_crossing.eq(1)
                ),

                # If someone called for crossing at any instant, modify counter
                If ((call_for_crossing == 1) & (count_halfsec > 30) & (count_halfsec < 100),
                    count_halfsec.eq(100),
                    call_for_crossing.eq(0)
                ),

                # Change state of traffic lights depending on time
                If (count_halfsec == 111,
                    countdown.eq(0b1111)

                ).Elif ((count_halfsec >= 120) & (count_halfsec < 124),
                    traffic_state.eq(0b01010)

                ).Elif ((count_halfsec >= 124) & (count_halfsec < 126),
                    traffic_state.eq(0b01001)

                ).Elif ((count_halfsec >= 126) & (count_halfsec < 137),
                    traffic_state.eq(0b10001),

                ).Elif (count_halfsec == 137,
                    countdown.eq(0b1111)

                ).Elif ((count_halfsec > 137) & (count_halfsec < 146),
                    traffic_state.eq(0b10001),

                ).Elif ((count_halfsec >= 146) & (count_halfsec < 158),
                    traffic_state[0].eq(0),
                    traffic_state[1].eq(count_halfsec[0]),
                    traffic_state[2].eq(0),
                    traffic_state[3].eq(0),
                    traffic_state[4].eq(count_halfsec[0]),

                ).Elif ((count_halfsec >= 158) & (count_halfsec < 160),
                    traffic_state.eq(0b01010)

                ).Elif (count_halfsec == 160,
                    count_halfsec.eq(0),
                    counter.eq(0)

                ).Else (
                    traffic_state.eq(0b01100)  # default: Cars green, Walk red
                )
        ]


        # Concurrent code
        self.comb += [ ]

        lights = LightUpLEDs(traffic_state, countdown, platform)
        self.submodules += [ lights ]

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
