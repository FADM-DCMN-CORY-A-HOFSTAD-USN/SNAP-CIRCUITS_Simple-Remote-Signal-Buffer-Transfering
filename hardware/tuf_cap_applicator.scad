// =================================================================
// TUF CAP APPLICATOR TOOL
// Manual Fracture-Zone Sealing Tool
// =================================================================
$fn = 60;

module cap_applicator() {
    difference() {
        // Handle and body
        union() {
            cylinder(h=80, r=10); // Handle
            translate([0, 0, 80]) cylinder(h=20, r1=10, r2=12); // Funnel base
        }
        
        // Internal tapered cavity to stretch the cap
        translate([0, 0, 90])
        cylinder(h=20, r1=1, r2=8); 
    }
}

cap_applicator();
