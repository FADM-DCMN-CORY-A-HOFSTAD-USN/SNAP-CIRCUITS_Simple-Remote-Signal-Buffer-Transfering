// TYPE-S SAIYA: SNAP-CIRCUIT DOUBLE LATCH GATE BUFFER
include <shocks.scad>;

$fn = 60;
total_length = 160;
width = 60;
height = 15;
corner_radius = 8;
v_groove_depth = 12;

module rounded_flush_plate(l, w, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(h=h, r=r);
        translate([l - r, r, 0]) cylinder(h=h, r=r);
        translate([r, w - r, 0]) cylinder(h=h, r=r);
        translate([l - r, w - r, 0]) cylinder(h=h, r=r);
    }
}

module flush_countersink() {
    translate([0, 0, -0.1])
    union() {
        cylinder(h=height, r=2);
        translate([0, 0, height - 3])
            cylinder(h=3, r1=2, r2=4.5);
    }
}

module snap_circuit_chassis() {
    difference() {
        color("DimGray")
        rounded_flush_plate(total_length, width, height, corner_radius);

        // Fracture V-Groove Top and Bottom
        translate([total_length / 2, width / 2, height])
        rotate([90, 0, 0])
        cylinder(h=width, r1=v_groove_depth, r2=0, center=true, $fn=4);

        translate([total_length / 2, width / 2, 0])
        rotate([90, 0, 0])
        cylinder(h=width, r1=v_groove_depth, r2=0, center=true, $fn=4);

        // Internal Cavity
        translate([4, 4, 3])
        rounded_flush_plate(total_length - 8, width - 8, height - 6, corner_radius - 2);

        // Flush Mounting Holes
        for (pos = get_mount_positions()) {
            translate([pos[0], pos[1], 0]) flush_countersink();
        }
    }
}

function get_mount_positions() = [
    [corner_radius, corner_radius],
    [(total_length / 2) - 15, corner_radius],
    [(total_length / 2) - -15, corner_radius], 
    [total_length - corner_radius, corner_radius],
    [corner_radius, width - corner_radius],
    [(total_length / 2) - 15, width - corner_radius],
    [(total_length / 2) - -15, width - corner_radius], 
    [total_length - corner_radius, width - corner_radius]
];

module deploy_shock_mounts() {
    for (pos = get_mount_positions()) {
        translate([pos[0], pos[1], -4])
            pcb_standoff_shock(height=8);
    }
}

snap_circuit_chassis();
deploy_shock_mounts();
