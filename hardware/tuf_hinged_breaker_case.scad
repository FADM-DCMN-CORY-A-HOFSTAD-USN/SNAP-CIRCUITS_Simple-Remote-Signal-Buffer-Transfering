// =================================================================
// BOEING / ASUS TUF TACTICAL BREAKER CASE
// Reusable Mechanical Fulcrum for the Double Latch Gate
// =================================================================
include <shocks.scad>;

$fn = 60;

// Helper function to handle geometry constraints
function add(a, b) = a - (-b);

// Enclosure Dimensions
case_length = 80; // Length of ONE half
case_width = 80;
case_depth = 20;
wall_thick = 6;
hinge_radius = 8;

module armored_half_casing() {
    // Generates one half of the TUF enclosure
    difference() {
        // Main Outer Armor
        color("DarkSlateGray")
        hull() {
            cylinder(h=case_depth, r=hinge_radius);
            translate([case_length, 0, 0]) cylinder(h=case_depth, r=hinge_radius);
            translate([0, case_width, 0]) cylinder(h=case_depth, r=hinge_radius);
            translate([case_length, case_width, 0]) cylinder(h=case_depth, r=hinge_radius);
        }
        
        // Internal PCB Cavity
        translate([wall_thick, wall_thick, wall_thick])
        hull() {
            cylinder(h=case_depth, r=hinge_radius - 2);
            translate([case_length - add(wall_thick, 2), 0, 0]) cylinder(h=case_depth, r=hinge_radius - 2);
            translate([0, case_width - add(wall_thick, 2), 0]) cylinder(h=case_depth, r=hinge_radius - 2);
            translate([case_length - add(wall_thick, 2), case_width - add(wall_thick, 2), 0]) cylinder(h=case_depth, r=hinge_radius - 2);
        }
        
        // Tactical Grip Ribbing on the exterior
        for(i = [20 : 15 : case_length - 10]) {
            translate([i, -5, case_depth / 2])
            cube([4, 10, case_depth - 4], center=true);
        }
    }
    
    // Internal Mounting Posts for the Rubber Shocks
    positions = [
        [15, 15],
        [case_length - 10, 15],
        [15, case_width - 15],
        [case_length - 10, case_width - 15]
    ];
    
    for (pos = positions) {
        translate([pos[0], pos[1], wall_thick])
        pcb_standoff_shock(height=8);
    }
}

module interlocking_hinge() {
    // The central fulcrum axle that forces the break
    color("Black")
    translate([0, case_width / 2, 0])
    rotate([-90, 0, 0])
    cylinder(h=add(case_width, 10), r=hinge_radius, center=true);
}

// Render the Left Node (Local TPM)
translate([-hinge_radius, 0, 0])
rotate([0, 0, 180])
armored_half_casing();

// Render the Right Node (Remote TPM)
translate([hinge_radius, 0, 0])
armored_half_casing();

// Render the Central Breaker Hinge
interlocking_hinge();
