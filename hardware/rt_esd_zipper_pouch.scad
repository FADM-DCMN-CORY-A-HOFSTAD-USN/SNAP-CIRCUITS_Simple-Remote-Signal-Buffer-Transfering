/*
 * REVOLUTIONARY TECHNOLOGY: ESD-SAFE TPU ZIPPER POUCH
 * Material Requirement: Carbon-Nanotube Infused ESD-TPU (Flexible)
 * Surface Resistance Target: 10^6 to 10^9 Ohms
 */

// Parametric Dimensions to fit the RT Motherboard / Snap Circuits
bag_width = 120;
bag_height = 160;
bag_depth = 25;
wall_thickness = 1.2; // 3 perimeters for flexible TPU

// Zipper Mechanism Variables
zip_radius = 2.0;
zip_offset = 1.5;

module esd_zipper_pouch() {
    difference() {
        union() {
            // Main Pouch Body
            translate([-bag_width/2, 0, 0])
                cube([bag_width, bag_height, bag_depth]);
            
            // Top Zipper Assembly (Male / Female Interlocking Rails)
            translate([-bag_width/2, bag_height, 0])
                zipper_rails();
        }
        
        // Hollow out the pouch (leaving the thin flexible walls)
        translate([-(bag_width/2) + wall_thickness, wall_thickness, wall_thickness])
            cube([bag_width - (wall_thickness*2), bag_height + 10, bag_depth - (wall_thickness*2)]);
            
        // Cut the top open so the bag can actually part
        translate([-bag_width/2 - 1, bag_height - 2, bag_depth/2 - 0.5])
            cube([bag_width + 2, 15, 1]);
    }
}

module zipper_rails() {
    // Extrude the mechanical interference profiles across the top of the bag
    rotate([0, 90, 0])
    linear_extrude(height = bag_width) {
        
        // --- FEMALE RECEIVING TRACK ---
        translate([-bag_depth/2 + wall_thickness, 5]) {
            difference() {
                // Outer structural clamp
                square([6, 8], center=true);
                // Inner hollow for the male arrow to snap into
                translate([0, -2])
                    circle(r=zip_radius + 0.2, $fn=32);
                // The gap for the male stalk
                translate([0, -5])
                    square([zip_radius, 6], center=true);
            }
        }
        
        // --- MALE INTERLOCKING ARROW ---
        translate([bag_depth/2 - wall_thickness, 5]) {
            union() {
                // The stalk
                translate([0, -2])
                    square([zip_radius - 0.2, 4], center=true);
                // The locking bulb
                circle(r=zip_radius, $fn=32);
            }
        }
    }
}

// Render the ESD Pouch
color("DarkSlateGray") // ESD Carbon materials are natively matte black/gray
esd_zipper_pouch();
