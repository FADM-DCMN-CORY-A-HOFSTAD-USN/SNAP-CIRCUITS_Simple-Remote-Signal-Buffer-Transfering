// =================================================================
// REVOLUTIONARY TECHNOLOGY: 3D EDGE-WRAPPED GUARD RING
// Completely wraps the grounded copper over the physical edge of the PCB 
// to create an absolute Faraday barrier against crosstalk.
// =================================================================

$fn = 50;

module edge_wrapped_shield(pcb_length, pcb_width, pcb_thickness, plating_thickness=0.5, wrap_depth=2.0) {
    // Calculates the continuous copper band that shields the top, side, and bottom.
    color("Copper")
    difference() {
        // 1. The outer dimensions of the copper plating
        cube([pcb_length + (plating_thickness * 2), 
              pcb_width + (plating_thickness * 2), 
              pcb_thickness + (plating_thickness * 2)], center=true);

        // 2. Core cutout where the FR4 silicon substrate resides
        cube([pcb_length, pcb_width, pcb_thickness + 0.1], center=true);

        // 3. Cut out the large top and bottom center sections.
        // This leaves only the 'wrap_depth' lip extending onto the top and bottom faces.
        cube([pcb_length - (wrap_depth * 2), 
              pcb_width - (wrap_depth * 2), 
              pcb_thickness + (plating_thickness * 4)], center=true);
    }
}

// Render example for a standard M.2 sized segment of the Snap Circuit
edge_wrapped_shield(pcb_length=80, pcb_width=22, pcb_thickness=2);
