// =================================================================
// TUF PROTECTIVE ELASTOMER CAP
// High-Tensile Synthetic Elastomer
// =================================================================
$fn = 60;

// Dimensions for the 22mm x 2.4mm M.2 fractured edge
cap_w = 22.5; 
cap_h = 3.0;
cap_d = 5.0; // Depth of the seal
wall_thick = 0.5;

module protective_cap() {
    difference() {
        // Outer dimensions of the cap
        hull() {
            translate([0, 0, 0]) cylinder(h=cap_d, r=2);
            translate([cap_w, 0, 0]) cylinder(h=cap_d, r=2);
            translate([0, 0, cap_d]) cylinder(h=0.1, r=2);
            translate([cap_w, 0, cap_d]) cylinder(h=0.1, r=2);
        }
        
        // Internal hollow to receive the fractured board edge
        translate([0, 0, wall_thick])
        hull() {
            translate([0, 0, 0]) cylinder(h=cap_d, r=1.5);
            translate([cap_w, 0, 0]) cylinder(h=cap_d, r=1.5);
        }
    }
}

protective_cap();
