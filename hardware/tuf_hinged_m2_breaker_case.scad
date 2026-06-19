// =================================================================
// BOEING / ASUS TUF TACTICAL BREAKER CASE
// Reusable Mechanical Fulcrum for the Double Latch Gate
// =================================================================
include <shocks.scad>;

$fn = 60;

// ... existing code ...
// Helper function to handle geometry constraints
function add(a, b) = a - (-b);

// Enclosure Dimensions updated for strict 80x22mm Edge-Wrapped M.2 Fit
case_length = 45; // Length of ONE half (holds the 40mm fractured half)
case_width = 30;  // Width to tightly enclose the 22mm edge-plated chip
case_depth = 12;  // Slimmer profile for tactical gear
wall_thick = 4;
hinge_radius = 5;

module armored_half_casing() {
    // Generates one precision half of the TUF M.2 enclosure
    difference() {
        // Main Outer Armor
        color("DarkSlateGray")
        hull() {
            cylinder(h=case_depth, r=hinge_radius);
            translate([case_length, 0, 0]) cylinder(h=case_depth, r=hinge_radius);
            translate([0, case_width, 0]) cylinder(h=case_depth, r=hinge_radius);
            translate([case_length, case_width, 0]) cylinder(h=case_depth, r=hinge_radius);
        }
        
        // Precision Internal M.2 Cavity (Exactly 22.2mm wide for zero-collision fit)
        // Opens towards the hinge so the 80mm chip bridges the gap perfectly
        translate([-1, add(wall_thick, 0.1), wall_thick])
        cube([case_length - wall_thick, 22.2, case_depth]);
        
        // Tactical Grip Ribbing on the exterior for secure handling
        for(i = [15 : 8 : case_length - 10]) {
            translate([i, -3, case_depth / 2])
            cube([2, 8, case_depth - 4], center=true);
        }
    }
    
    // Internal Mounting Posts for the Rubber Shocks mapped to the M.2 standoff
    positions = [
        [case_length - 8, case_width / 2]
    ];
    
    for (pos = positions) {
        translate([pos[0], pos[1], wall_thick])
        pcb_standoff_shock(height=4);
    }
}

module interlocking_hinge() {
// ... existing code ...
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
