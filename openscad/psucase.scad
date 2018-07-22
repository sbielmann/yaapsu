// all is in millimeters, to be considered when printing
// out STL to 3d printer
//
// work with variables showTop and showBottom to render and export
// either upper or lower part of case to STL
//
// once printed out you need ot do the thread of screw for each of the screw
// wholes.

// number of fragments used to draw primitives like spheres (0..100)
$fn = 50;

// show all or only parts of case
showTop = true;
showBottom = true;

// helper to draw a triangle
// arguments:
//   xLen: length of triangle in x axis
//   yLen: length of triangle in y axis
//   tHeight: height of triangle
module Triangle(xLen, yLen, tHeight)
{
    linear_extrude(height=tHeight)
    {
        polygon(points=[ [0, 0], [xLen, 0], [0, yLen]], paths=[ [0, 1, 2] ]);
    }
}

// base case, rounded, hollow cube, 2 millimeters wall thickness
module BaseCase() {
    // make rounded cube hollow
    difference() {
        // translate rounded cube back to position 0
        translate([2, 2, 2]) {
            // cube with rounded corners
            minkowski()
            {
                cube([141, 84, 61]);
                sphere(2);
            }
        }
        // inner cube, used to make case hollow
        translate([2, 2, 2]) {
            cube([141, 84, 61]);
        }
    }
}

// socket where RPT-60B will be mounted on with M3 screw
// hence 2.5 mm internal hole.
//
// thread of screw to be made manually after print out
//
// arguments:
//   sPosition : position where to draw socket (centered)
module PsuSocket(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        // socket made out of base cylinder and 4 supports
        union() {
            // socket cylinder with hole for M3
            difference() {
                cylinder(h = 8, r = 3);
                translate([0, 0, 1]) {
                    cylinder(h = 8, r = 1.25);
                }
            }
            // supports
            translate([1, 2.5, 0]) {
                rotate([0, -90, 0]) {
                    Triangle(5, 5, 2);
                }
            }

            translate([-2.5, 1, 0]) {
                rotate([0, -90, 90]) {
                    Triangle(5, 5, 2);
                }
            }

            translate([-1, -2.5, 0]) {
                rotate([0, -90, 180]) {
                    Triangle(5, 5, 2);
                }
            }

            translate([2.5, -1, 0]) {
                rotate([0, -90, -90]) {
                    Triangle(5, 5, 2);
                }
            }
        }
    }
}

// upper case bolting where lower case part will fit onto and be screwed
// on it with M3 screw, hence 2.5 mm internal hole.
//
// thread of screw to be made manually after print out
//
// note cylinder does not touch case due to 2-manifold issues, and was
// too lazy to add mounting points to case, should be stable enough.
//
// arguments:
//   sPosition : position where to draw bolting (centered)
module UpperBolting(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        // bolting cylinder with hole for M3
        difference() {
            cylinder(h = 31, r = 4.8);
            translate([0, 0, -1]) {
                cylinder(h = 17, r = 1.25);
            }
        }
    }
}

// lower case bolting where upper case part will fit onto and screw
// passed through from outside to be screwed into upper bolting.
//
// thread of screw to be made manually after print out
//
// note cylinder does not touch case due to 2-manifold issues, and was
// too lazy to add mounting points to case, should be stable enough.
//
// arguments:
//   sPosition : position where to draw bolting (centered)
module LowerBolting(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        // bolting cylinder with hole to let M3 screw
        // pass through with head size of 6 mm diametre
        // and 3.2 mm passage for screw
        difference() {
            cylinder(h = 30, r = 4.8);
            translate([0, 0, -1]) {
                cylinder(h = 28, r = 3);
            }
            translate([0, 0, 26]) {
                cylinder(h = 5, r = 1.6);
            }
        }
    }
}

// stencil to cut out bolting screw passage from case
//
// arguments:
//   sPosition : position where to draw cut out (centered)
module BoltingCutOut(sPosition = [0, 0 ,0]) {
    translate(sPosition) {
        cylinder(h = 4, r = 3);
    }
}

// outlet where power cable to Amiga with pull relief will be mounted.
//
// arguments:
//   sPosition : position where to draw outlet (centered)
module AmigaPowerCableOutlet(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        rotate([0, 90, 0]) {
            cylinder(h = 4, r = 7.8);
        }
    }
}

// outlet where power switch will be mounted
//
// arguments:
//   sPosition : position where to draw outlet
module PowerSwitchOutlet(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        cube([4, 12.9, 19.4]);
    }
}

// outlet where power cable connector will be mounted
// with M3 screws.
//
// arguments:
//   sPosition : position where to draw outlet (centered)
module PowerConnectorOutlet(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        translate([0, -13.4], 0) {
            cube([4, 27.7, 31.5]);
            translate([0, -4.6, 15.75]) {
                rotate([0, 90, 0]) {
                    cylinder(h = 4, r = 1.6);
                }
            }
            translate([0, 31.4, 15.75]) {
                rotate([0, 90, 0]) {
                    cylinder(h = 4, r = 1.6);
                }
            }
        }
    }
}

// amiga logo text
//
// arguments:
//   sPosition : position where to draw text
module AmigaLogo(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        rotate([0, 0, 90]) {
            linear_extrude(height=2) text("AMIGA", size=18, font="Didot:style=Italic", spacing=0.8);
        }
    }
}

// lower case support
//
// arguments:
//   sPosition : position where to draw support
module LowerCaseSupport(sPosition = [0, 0, 0,]) {
    translate(sPosition) {
        translate([23, 0, 0]) {
            cube([100, 1, 6]);
        }
        translate([23, 83, 0]) {
            cube([100, 1, 6]);
        }
        translate([0, 26, 0]) {
            cube([1, 7, 6]);
        }
        translate([140, 12, 0]) {
            cube([1, 15, 6]);
        }
        translate([140, 57, 0]) {
            cube([1, 15, 6]);
        }
    }
}

// air vents, for upper and lower the same
//
// arguments:
//   sPosition: position where to draw vents
module AirVents(sPosition = [0, 0, 0]) {
    translate(sPosition) {
        for(i=[0:7]) {
            translate([i*5, 0, 0]) {
                cube([1, 3, 5]);
            }
        }
        for(i=[0:7]) {
            translate([i*5, 85, 0]) {
                cube([1, 3, 5]);
            }
        }
    }
}

// assemble whole case together
module AssembledCase() {
    // merge psu sockets and boltings on base
    union() {
        // cut out outlets and bolting cut outs and engrave logo
        difference() {
            BaseCase();
            AmigaPowerCableOutlet([142, 44, 32.5]);
            PowerSwitchOutlet([-1, 12, 31.2]);
            PowerConnectorOutlet([-1, 59.15, 25.5]);
            BoltingCutOut([138, 7, 0]);
            BoltingCutOut([17, 7, 0]);
            BoltingCutOut([138, 81, 0]);
            BoltingCutOut([17, 81, 0]);
            AmigaLogo([135, 9, 64]);
            if(!showBottom) {
                translate([-1, -1, -1]) {
                    cube([147, 90, 48]);
                }
            } else {
                AirVents([50, 0, 0]);
            }
            if(!showTop) {
                translate([-1, -1, 47]) {
                    cube([147, 90, 18]);
                }
            } else {
                AirVents([50, 0, 60]);
            }
        }
        if(showBottom) {
            PsuSocket([120, 21.775, 2]);
            PsuSocket([24.75, 21.775, 2]);
            PsuSocket([120, 66.225, 2]);
            PsuSocket([24.75, 66.225, 2]);
            LowerBolting([138, 7, 2]);
            LowerBolting([17, 7, 2]);
            LowerBolting([138, 81, 2]);
            LowerBolting([17, 81, 2]);
            LowerCaseSupport([2, 2, 44]);
        }
        if(showTop) {
            UpperBolting([138, 7, 32]);
            UpperBolting([17, 7, 32]);
            UpperBolting([138, 81, 32]);
            UpperBolting([17, 81, 32]);
        }
    }
}

AssembledCase();
