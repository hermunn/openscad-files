$fn=100;

// these are the dimensions of the thing, not the shape

MID_D = 28; // the middle dieameter measurement of the leg
IN_D = 22; // The diameter of what goes inside
OUTER_D = 35; // the diameter of the foot
HOLE_D = 14; // the hole where the screw head and the iron has to fit
SCREW_D = 4; // how wide is the screw (hole)
WHIGGLE = 3; // extra space if you miss when drilling a hole in the ground

IN_HEIGHT = 11; // How long is the thing that goes into the leg
STEP_HEIGHT = 2;
FOOT_HEIGHT = 4;
SCREW_BASE_THICKNESS = 3;

// derived constants for easier living
TOT_HEIGHT = IN_HEIGHT + STEP_HEIGHT + FOOT_HEIGHT;

// the modules help with defining the shape

module OuterShell() {
    cylinder(h = TOT_HEIGHT, r = IN_D / 2, center = false);
    cylinder(h = FOOT_HEIGHT + STEP_HEIGHT, r = MID_D / 2, center = false);
    cylinder(h = FOOT_HEIGHT, r = OUTER_D / 2, center = false);
}

module HoleForScrews() {
    hull() {
        translate([-WHIGGLE / 4,0,0])
        cylinder(h = SCREW_BASE_THICKNESS * 3, r = SCREW_D / 2, center = true);
        translate([WHIGGLE,0,0])
            cylinder(h = SCREW_BASE_THICKNESS * 3, r = SCREW_D / 2, center = true);
    }
}

module HoledOuterShell() {
    difference() {
        OuterShell();
        translate([0,0,SCREW_BASE_THICKNESS]) {
            cylinder(h = TOT_HEIGHT, r = HOLE_D / 2, center = false);
        }
        HoleForScrews();
    }
}

HoledOuterShell();