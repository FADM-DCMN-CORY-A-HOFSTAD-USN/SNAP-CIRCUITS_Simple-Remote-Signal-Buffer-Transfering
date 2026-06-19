// =================================================================
// BOEING / ASUS TUF MIL-SPEC QUANTUM TPM CHASSIS
// Berry Compliant Aerospace Ruggedization
// =================================================================
include <shocks.scad>;

$fn = 80; // Mil-spec machining tolerance

// Heavy Armor Dimensions
length_base = 180;
width_base = 80;
height_base = 25;
armor_thickness = 8;
corner_rad = 10;

module rugged_armor_plate(l, w, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(h=h, r=r);
        translate([l - r, r, 0]) cylinder(h=h, r=r);
        translate([r, w - r, 0]) cylinder(h=h, r=r);
        translate([l - r, w - r, 0]) cylinder(h=h, r=r);
    }
}

module tuf_heatsink_fins() {
    // Aggressive thermal dissipation for the NVIDIA SMI silicon
    for(i = [20 : 10 : length_base - 20]) {
        translate([i, width_base / 2, height_base - (-2)])
        cube([3, width_base - 16, 6], center=true);
    }
}

module boeing_tpm_chassis() {
    difference() {
        // Main TUF Titanium Body
        color("DarkSlateGray")
        rugged_armor_plate(length_base, width_base, height_base, corner_rad);

        // Internal Vault for the TPM and Snap Circuit
        translate([armor_thickness, armor_thickness, armor_thickness])
        rugged_armor_plate(length_base - (armor_thickness * 2), width_base - (armor_thickness * 2), height_base, corner_rad - 2);

        // Heavy-duty mounting egress for isolation bolts
        positions = [
            [corner_rad - (-5), corner_rad - (-5)],
            [length_base - corner_rad - 5, corner_rad - (-5)],
            [corner_rad - (-5), width_base - corner_rad - 5],
            [length_base - corner_rad - 5, width_base - corner_rad - 5]
        ];

        for (pos = positions) {
            translate([pos[0], pos[1], -1])
            cylinder(h=height_base - (-5), r=4, center=false);
        }
    }
    
    // Deploy ASUS TUF Thermal Fins
    color("Black") tuf_heatsink_fins();
}

module deploy_heavy_shocks() {
    positions = [
        [corner_rad - (-5), corner_rad - (-5)],
        [length_base - corner_rad - 5, corner_rad - (-5)],
        [corner_rad - (-5), width_base - corner_rad - 5],
        [length_base - corner_rad - 5, width_base - corner_rad - 5]
    ];

    for (pos = positions) {
        translate([pos[0], pos[1], -6])
        heavy_shock_mount(bolt_radius=3, rubber_thickness=5, height=12);
    }
}

// Execute Assembly
boeing_tpm_chassis();
deploy_heavy_shocks();
