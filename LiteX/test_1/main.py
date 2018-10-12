#
#  test_1: main.py
#  Script to generate SoC config for Arty A7-35 with specific configuration
#  consisting of buttons, switches and all the LEDs.
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


from migen import *
from litex.build.generic_platform import *
from litex.build.xilinx import XilinxPlatform

from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *

from litex.soc.cores.uart import UARTWishboneBridge

from litex.soc.interconnect.csr import *
from litex.soc.cores import gpio

class Button(gpio.GPIOIn):
    pass

class Switch(gpio.GPIOIn):
    pass

class Led(gpio.GPIOOut):
    pass

class RGBLed(Module, AutoCSR):
    def __init__(self, pads):
        self.submodules.r = PWM(pads.r)
        self.submodules.g = PWM(pads.g)
        self.submodules.b = PWM(pads.b)


###  BEGIN module PWM  ###
class PWM(Module, AutoCSR):
    def __init__(self, LED):
        self.duty = CSRStorage(8)

        counter = Signal(8)  # 0 -- 255 : period

        # sequential code
        self.sync += [ counter.eq(counter + 1) ]

        # concurrent code
        self.comb += [ LED.eq( counter < self.duty.storage ) ]

###  END module PWM  ###



###  BEGIN Describe platform  ###

_io = [ ("CLK100MHZ", 0, Pins("E3"), IOStandard("LVCMOS33")),

        # Buttons
        ("button", 0, Pins("D9"), IOStandard("LVCMOS33")),
        ("button", 1, Pins("C9"), IOStandard("LVCMOS33")),
        ("button", 2, Pins("B9"), IOStandard("LVCMOS33")),
        ("button", 3, Pins("B8"), IOStandard("LVCMOS33")),

        # Switches
        ("switch", 0, Pins("A8"),  IOStandard("LVCMOS33")),  # LD0
        ("switch", 1, Pins("C11"), IOStandard("LVCMOS33")),  # LD1
        ("switch", 2, Pins("C10"), IOStandard("LVCMOS33")),  # LD2
        ("switch", 3, Pins("A10"), IOStandard("LVCMOS33")),  # LD3

        # Monochromatic LEDs
        ("Monoled", 0, Pins("H5"), IOStandard("LVCMOS33")),
        ("Monoled", 1, Pins("J5"), IOStandard("LVCMOS33")),
        ("Monoled", 2, Pins("T9"), IOStandard("LVCMOS33")),
        ("Monoled", 3, Pins("T10"), IOStandard("LVCMOS33")),

        # RGB LED0
        ("RGBled", 0, Subsignal("r", Pins("G6")), # R
                      Subsignal("g", Pins("F6")), # G
                      Subsignal("b", Pins("E1")), # B
                      IOStandard("LVCMOS33")),
        # RGB LED1
        ("RGBled", 1, Subsignal("r", Pins("G3")), # R
                      Subsignal("g", Pins("J4")), # G
                      Subsignal("b", Pins("G4")), # B
                      IOStandard("LVCMOS33")),
        # RGB LED2
        ("RGBled", 2, Subsignal("r", Pins("J3")), # R
                      Subsignal("g", Pins("J2")), # G
                      Subsignal("b", Pins("H4")), # B
                      IOStandard("LVCMOS33")),
        # RGB LED3
        ("RGBled", 3, Subsignal("r", Pins("K1")), # R
                      Subsignal("g", Pins("H6")), # G
                      Subsignal("b", Pins("K2")), # B
                      IOStandard("LVCMOS33")),

        # USB UART
        ("serial", 0, Subsignal("tx", Pins("D10")), # rxd_out
                      Subsignal("rx", Pins("A9")),  # txd_in
                      IOStandard("LVCMOS33"))
        ]


class Platform(XilinxPlatform):
    default_clk_name = "CLK100MHZ"
    default_clk_period = 10.00

    def __init__(self):
        XilinxPlatform.__init__(self, "xc7a35ticsg324-1L", _io, toolchain="vivado")

    def do_finalize(self, fragment):
        XilinxPlatform.do_finalize(self, fragment);

###  END Describe platform  ###



###  BEGIN Design  ###

def csr_map_update(csr_map, csr_peripherals):
    csr_map.update(dict((n, v)
        for v, n in enumerate(csr_peripherals, start=max(csr_map.values()) + 1)))

# create our platform (fpga interface)
platform = Platform()


# create our soc (fpga description)
class BaseSoC(SoCCore):

    # Peripherals CSR declaration
    csr_peripherals = [
        "buttons",
        "switches",
        "leds",
        "rgbled0",
        "rgbled1",
        "rgbled2",
        "rgbled3",
        "serial"
    ]
    csr_map_update(SoCCore.csr_map, csr_peripherals)

    def __init__(self, platform, **kwargs):
        sys_clk_freq = int(100e6)

        # SoC init (No CPU, we control the SoC with UART)
        SoCCore.__init__(self, platform, sys_clk_freq,
            cpu_type=None,
            csr_data_width=32,
            with_uart=False,
            with_timer=False,
            ident="test_1: basic Arty A7-35 System On Chip", ident_version=True,
            )

        # Clock Reset Generation
        self.submodules.crg = CRG(platform.request("CLK100MHZ"))


        # No CPU, use Serial to control Wishbone bus
        self.add_cpu_or_bridge(UARTWishboneBridge(platform.request("serial"), sys_clk_freq, baudrate=115200))
        self.add_wb_master(self.cpu_or_bridge.wishbone)

        # Buttons
        user_buttons = Cat(*[platform.request("button", i) for i in range(0,4)])
        self.submodules.buttons = Button(user_buttons)

        # Switches
        user_switches = Cat(*[platform.request("switch", i) for i in range(0,4)])
        self.submodules.switches = Switch(user_switches)

        # Monochromatic LEDs
        user_leds = Cat(*[platform.request("Monoled", i) for i in range(0,4)])
        self.submodules.leds = Led(user_leds)

        # RGB LED
        self.submodules.rgbled0 = RGBLed(platform.request("RGBled", 0))
        self.submodules.rgbled1 = RGBLed(platform.request("RGBled", 1))
        self.submodules.rgbled2 = RGBLed(platform.request("RGBled", 2))
        self.submodules.rgbled3 = RGBLed(platform.request("RGBled", 3))

###  END Design  ###


soc = BaseSoC(platform)

#
# build
#
builder = Builder(soc, output_dir="build", csr_csv="csr.csv")
builder.build()
