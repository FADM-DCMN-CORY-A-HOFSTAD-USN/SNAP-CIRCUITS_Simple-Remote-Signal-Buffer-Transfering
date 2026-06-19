// SNAP CIRCUIT PCB OUTLINE FOR KICAD EDGE.CUTS
include <shocks.scad>;

$fn = 60;
total_length = 160;
width = 60;
corner_radius = 8;
pcb_clearance = 4;

pcb_length = total_length - (pcb_clearance * 2);
pcb_width = width - (pcb_clearance * 2);
pcb_radius = corner_radius - 2;

module pcb_outline_2d() {
    projection(cut = false) {
        difference() {
            // Main PCB Board outline
            translate([pcb_clearance, pcb_clearance, 0])
            hull() {
                translate([pcb_radius, pcb_radius, 0]) cylinder(h=1, r=pcb_radius);
                translate([pcb_length - pcb_radius, pcb_radius, 0]) cylinder(h=1, r=pcb_radius);
                translate([pcb_radius, pcb_width - pcb_radius, 0]) cylinder(h=1, r=pcb_radius);
                translate([pcb_length - pcb_radius, pcb_width - pcb_radius, 0]) cylinder(h=1, r=pcb_radius);
            }

            // Score line (V-groove path) to allow the PCB to snap
            translate([total_length / 2, width / 2, 0])
            cube([1, width, 5], center=true);

            // Cut out the drill holes for the rubber shock absorbers
            positions = [
                [corner_radius, corner_radius],
                [(total_length / 2) - 15, corner_radius],
                [(total_length / 2) - -15, corner_radius],
                [total_length - corner_radius, corner_radius],
                [corner_radius, width - corner_radius],
                [(total_length / 2) - 15, width - corner_radius],
                [(total_length / 2) - -15, width - corner_radius],
                [total_length - corner_radius, width - corner_radius]
            ];

            for (pos = positions) {
                translate([pos[0], pos[1], 0])
                    cylinder(h=5, r=3, center=true); // 3mm radius ensures room for the rubber grommet
            }
        }
    }
}

pcb_outline_2d();
