
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35ti2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35ti2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
42default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2110.0472default:default2
0.0002default:default2
16572default:default2
76692default:defaultZ17-722h px� 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 168046423
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.01 . Memory (MB): peak = 2110.047 ; gain = 0.000 ; free physical = 1657 ; free virtual = 76692default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2110.0472default:default2
0.0002default:default2
16572default:default2
76692default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 45ccb84e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.58 . Memory (MB): peak = 2110.047 ; gain = 0.000 ; free physical = 1656 ; free virtual = 76692default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
O
:Phase 1.3 Build Placer Netlist Model | Checksum: df1f81aa
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.67 . Memory (MB): peak = 2110.047 ; gain = 0.000 ; free physical = 1655 ; free virtual = 76672default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
L
7Phase 1.4 Constrain Clocks/Macros | Checksum: df1f81aa
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.68 . Memory (MB): peak = 2110.047 ; gain = 0.000 ; free physical = 1655 ; free virtual = 76672default:defaulth px� 
H
3Phase 1 Placer Initialization | Checksum: df1f81aa
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.68 . Memory (MB): peak = 2110.047 ; gain = 0.000 ; free physical = 1655 ; free virtual = 76672default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
C
.Phase 2 Global Placement | Checksum: c65a17a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.91 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1648 ; free virtual = 76612default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
O
:Phase 3.1 Commit Multi Column Macros | Checksum: c65a17a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.92 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1648 ; free virtual = 76612default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
Q
<Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 75651e12
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.96 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1648 ; free virtual = 76612default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
K
6Phase 3.3 Area Swap Optimization | Checksum: 7cc1e285
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.97 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1648 ; free virtual = 76612default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
S
>Phase 3.4 Pipeline Register Optimization | Checksum: 7cc1e285
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.97 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1648 ; free virtual = 76612default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
Q
<Phase 3.5 Small Shape Detail Placement | Checksum: 96c1945b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 18c44438b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 18c44438b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 18c44438b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 17fe1ef67
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
42default:defaultZ32-721h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason.30*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-31h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 17fe1ef67
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
4.8302default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 156dfca5f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 156dfca5f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76592default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 156dfca5f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76602default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 156dfca5f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76602default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 1c3295958
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76602default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 1c3295958
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1647 ; free virtual = 76602default:defaulth px� 
>
)Ending Placer Task | Checksum: 184c80542
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 2158.070 ; gain = 48.023 ; free physical = 1654 ; free virtual = 76662default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
472default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.122default:default2
00:00:00.042default:default2
2158.0702default:default2
0.0002default:default2
16512default:default2
76652default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2e
Q/home/aragorn/colour_chooser1_ver/colour_chooser1_ver.runs/impl_1/main_placed.dcp2default:defaultZ17-1381h px� 
_
%s4*runtcl2C
/Executing : report_io -file main_io_placed.rpt
2default:defaulth px� 
�
�report_io: Time (s): cpu = 00:00:00.06 ; elapsed = 00:00:00.06 . Memory (MB): peak = 2158.070 ; gain = 0.000 ; free physical = 1645 ; free virtual = 7658
*commonh px� 
�
%s4*runtcl2t
`Executing : report_utilization -file main_utilization_placed.rpt -pb main_utilization_placed.pb
2default:defaulth px� 
�
�report_utilization: Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.03 . Memory (MB): peak = 2158.070 ; gain = 0.000 ; free physical = 1652 ; free virtual = 7665
*commonh px� 
|
%s4*runtcl2`
LExecuting : report_control_sets -verbose -file main_control_sets_placed.rpt
2default:defaulth px� 
�
�report_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2158.070 ; gain = 0.000 ; free physical = 1652 ; free virtual = 7665
*commonh px� 


End Record