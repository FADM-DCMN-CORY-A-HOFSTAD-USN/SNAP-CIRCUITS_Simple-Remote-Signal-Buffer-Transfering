### 3. `docs/AUTOMATED_MACHINING.md`

```markdown
# Automated Machining and Pipeline Execution

The `build_hardware.py` CLI is the direct link between our theoretical physics and the physical factory floor. It uses Typer commands to orchestrate background system processes, specifically the OpenSCAD rendering engine.

## The Bridge Architecture

When an engineer runs a build command, Typer intercepts the request and executes a subprocess call to OpenSCAD. This allows us to use Python to manage variables, logic, and file routing, while OpenSCAD handles the strict geometric compilation.

### The Chassis Compilation

Command: `python src/build_hardware.py build-chassis`

1. Typer validates the command.
2. The script locates `hardware/snap_circuit_double_latch.scad`.
3. OpenSCAD is triggered in the background to compile the three-dimensional aerospace casing.
4. An `.stl` file is exported, ready for CNC toolpath generation or 3D printing.

### The Silicon Profile

Command: `python src/build_hardware.py build-kicad-profile`

1. Typer validates the command.
2. The script locates `hardware/kicad_edge_cuts.scad`.
3. OpenSCAD runs a two-dimensional projection of the chassis geometry.
4. A `.dxf` file is exported.
5. The PCB engineer imports this `.dxf` directly into the KiCad `Edge.Cuts` layer.

This Typer-driven pipeline guarantees that the internal silicon and the external aerospace steel are compiled from the exact same mathematical source of truth, ensuring zero tolerance mismatch during final assembly.
