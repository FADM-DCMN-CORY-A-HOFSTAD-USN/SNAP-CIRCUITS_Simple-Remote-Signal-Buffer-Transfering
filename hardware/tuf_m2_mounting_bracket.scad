// =================================================================
// TYPE-S SAIYA: ASUS TUF M.2 MOUNTING BRACKET
// Secures the Snap Circuit directly to the Motherboard
// =================================================================
include <shocks.scad>;

$fn = 60;

// M.2 2280 Form Factor Dimensions
m2_width = 22;
m2_length = 80;
thickness = 2;
standoff_hole_radius = 1.75;

module m2_snap_circuit_bracket() {
    difference() {
        // Main M.2 PCB Profile
        color("DarkSlateGray")
        hull() {
            translate([m2_width/2, m2_width/2, 0]) cylinder(h=thickness, r=m2_width/2);
            translate([m2_width/2, m2_length - (m2_width/2), 0]) cylinder(h=thickness, r=m2_width/2);
        }
        
        // M.2 Key Notch (M-Key for PCIe/NVMe slots)
        translate([16, -1, -1]) cube([4, 6, 5]);

        // TUF Motherboard Standoff Screw Hole (At the 80mm mark)
        translate([m2_width/2, m2_length - 4, -1])
        cylinder(h=thickness+2, r=standoff_hole_radius+1); // Slightly oversized for the shock washer
        
        // Center scoring line for the Snap Circuit physical break
        translate([m2_width/2, m2_length/2, thickness])
        rotate([0, 90, 0])
        cylinder(h=m2_width+2, r=1.5, center=true, $fn=3);
    }
}

module deploy_m2_shock_washer() {
    // A micro-shock absorber that sits between the bracket and the TUF motherboard screw
    translate([m2_width/2, m2_length - 4, -1.5])
    shock_absorber(bolt_radius=1.5, rubber_thickness=1, height=3);
}

// Render the M.2 Bridge
m2_snap_circuit_bracket();
deploy_m2_shock_washer();
