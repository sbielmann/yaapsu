# YAAPSU

Yet another Amiga power supply unit, not the first, not the best, just another one.

Suitable for Amiga 500, 600 and 1200.

Made out of a 3D printed case with a Mean Well RPT-60B and IEC 60320 C14 household
inlet with fuses.

**For experienced users only, incorrect assembling may kill you or your Amiga**

# Build

## Case

Made with OpenSCAD, see file openscad/psucase.scad, resulting STL files and
some pictures may be downloaded here: TODO

## Parts

- Power Supply Unit
  - RPT-60B - Switched-Mode Power Supply 60 W - Mean Well
- Rocker SwitchP
  - 1801.1146 - Rocker SwitchP - Marquardt
- Plug C14
  - 4301.0001 - Plug C14 Faston 4.8 x 0.8 mm 10 A/250 VAC Black Screw Mounting L + N + PE - Schurter
  - Additionally 2 pieces of 5x20 4A fuse fast blow
  - Fuse holde 2-pole (4301.1403 - Fuse holder 2-pole - Schurter)
- Cable
  - Control cable, LIYCY 4 X 0.75 MM2 - Control cable, 4 x 0.75 mm^2, Shielded, Bare Copper Stranded Wire, Grey - Kabeltronik
- Cable relief
  - RND 465-00399 - Cable gland Strain Relief PG9 - RND Components
- Crimp housings
  - Crimp housing 3 poles, VHR-3N - Crimp housing Poles 3 - JST
  - Crimp housing 6 poles, VHR-6N - Crimp housing Poles 6 - JST
  - Crimp contact female, 6 pieces of SVH-21T-P1.1 - Crimp contact Female 22...18 AWG - JST
- Din 5-pin square male connector
  - https://www.soigeneris.com/commodore-128-amiga-500-600-square-din-5-pin-male-connector
- Misc
  - RND 465-00073 - Blade Receptacle Red 4.8 x 0.8 mm PU=Pack of 100 pieces - RND Connect
  - Insulated ring terminals
  - Cables to connect internals (C14 Plug to Switch and to PSU)
  - Shrink tube
  - 4 screws M3x6mm (to RPT-60B)
  - 4 screws M3x8mm (for case)
  - 2 screws M3x6mm with hex nut's to mount C14 plug
  - Bumpers, like SJ5312BL - Bumpon (TM) x 3.5 mm Transparent - 3M

## Assembling

**In any case consult the part datasheet's before continuing**

Assemble square male connector with shielded control cable:
```
  ----v---- 
 | o     o |   - Upper left corner is +12V
 |         |   - Upper right corner is GND
 |    o    |   - Middle is -12V
 |         |   - Lower left is Shield
 |  o   o  |   - Lower right is +5V
  --------- 
```
Solder wires of cable to +12V, GND, -12V, +5V pins. Cable shielding not to shield pin,
however to connector it's frame. Close connector case.

Put other end of cable through cable relief, mount relief on case.

Assemble 6 poles crimp housing to cable:
```
       ___
  -------------
 | o o o o o o |
  -------------
```
1st pin is +5V, 2nd leave empty, 3rd is GND, 4th leave empty, 5th is +12V, 6th is -12V
Cable shielding goes into a ring terminal, you may want to use some shrink tube to 
insulate it.


Assemble C14 plug and rocker switch with cables, blade receptacles and ring terminals
and 3 poles crimp housing. From C14 L pin to switch, from second switch pin to crimp
housing. From C14 N pin to crimp housing. From C14 ground to a ring terminal. 3 poles
crimp housing connections are:
```
    ___
  ------- 
 | o o o |
  -------
```
1st pin is N from C14, 2nd leave empty, 3rd pin is L from switch.


Finally mount RPT-60B. Prepare a cable with ring terminals on both sides the length
a little bit more than the length of the RPT board. Have a look at the RPT-60B
data sheet, mounting holes M1 and M2 are safety grounds and need to be connected
to ground:
```
  -------------------
 |o                 o|
 |                   |
 |                   | This side has 6 poles connector.
 | M1             M2 |
 |o                 o|
  ------------------- 
```

Screw RPT to bottom of 3D printed case by placing ring terminals of cable shield
and prepared short cable under M2, the other end from short cable under M1 and
ground from C14 also to M1.

Screw C14 to case, place switch in case. Connect crimped JST housings to RPT.
Close case and screw upper part on to lower one.

Final check, plug power to PSU and verify voltage levels on square connector.

# Resources

My thanks go to Ian Stedman, which already provides all information you need to build
your own Amiga PSU, see http://ianstedman.co.uk/Amiga/amiga_hacks/Amiga_PSU/amiga_psu.html

And Lemaru with his wonderfully designed case for PSU cases, see https://www.thingiverse.com/thing:1794271
or https://www.thingiverse.com/thing:2701695
