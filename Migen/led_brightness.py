#
#  led_brightness.py
#  Program to vary brightness of 4 RGB LEDs
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

#  Program lights up the 4 RGB LEDs, then use the debounced button response
#  to increase or decrease the brightness.
#
#  Increase brightness: BTN1
#  Decrease brightness: BTN2
#


from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform


###  BEGIN Describe platform  ###

# Digilent Arty A7
#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

## RGB LEDs
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led0_b }]; #IO_L18N_T2_35 Sch=led0_b
#set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { led1_b }]; #IO_L20P_T3_35 Sch=led1_b
#set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { led2_b }]; #IO_L21N_T3_DQS_35 Sch=led2_b
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { led3_b }]; #IO_L23P_T3_35 Sch=led3_b

## Buttons
#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L11N_T1_SRCC_16 Sch=btn[2]

_io = [ ("CLK100MHZ", 0, Pins("E3"), IOStandard("LVCMOS33")),

        ("RGBled", 0, Pins("E1"), IOStandard("LVCMOS33")),
        ("RGBled", 1, Pins("G4"), IOStandard("LVCMOS33")),
        ("RGBled", 2, Pins("H4"), IOStandard("LVCMOS33")),
        ("RGBled", 3, Pins("K2"), IOStandard("LVCMOS33")),

        ("btn", 0, Pins("C9"), IOStandard("LVCMOS33")),
        ("btn", 1, Pins("B9"), IOStandard("LVCMOS33")) ]



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



###  BEGIN module BlinkLEDs  ###
class main(Module):
    def __init__(self, platform):
        # Signals local to main
        btn0_state = Signal()
        btn1_state = Signal()
        pwm_duty = Signal(8);

        # Initialise button state variables and pwm_duty
        btn0_state.eq(0)
        btn1_state.eq(0)


        ##  Submodules  ##
        # Debounce buttons
        debbtn0 = Debounce(platform.request("btn", 0), btn0_state)
        debbtn1 = Debounce(platform.request("btn", 1), btn1_state)

        self.submodules += [debbtn0, debbtn1]


        # Sequential code
        self.sync += [
                If (btn0_state == 1,
                    pwm_duty.eq(pwm_duty - 16)
                ),
                If (btn1_state == 1,
                    pwm_duty.eq(pwm_duty + 16)
                )
        ]

        # Concurrent code
        self.comb += []

        for i in range(0,4):
            led = platform.request("RGBled", i)
            pwmledi = PWM(pwm_duty, led)
            self.submodules += pwmledi

###  END module BlinkLEDs  ###



###  BEGIN Design  ###

# Create the platform
platform = Platform()

# Create the module
module = main(platform)

###  END Design  ###



###  Build  ###
platform.build(module)


exit(0)
