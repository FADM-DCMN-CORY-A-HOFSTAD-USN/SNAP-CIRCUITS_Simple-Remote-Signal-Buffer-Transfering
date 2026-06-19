"""
Snap Circuit Hardware Builder
Automates the compilation of 3D aerospace chassis files and 2D KiCad Edge.Cuts.
"""
import typer
import subprocess
from pathlib import Path

app = typer.Typer(name="SnapCircuitBuilder", add_completion=False)

REPO_ROOT = Path(__file__).parent.parent
HARDWARE_DIR = REPO_ROOT / "hardware"

@app.command()
def build_chassis():
    """Compiles the luxury flush-mount chassis into a 3D STL."""
    scad_file = HARDWARE_DIR / "snap_circuit_double_latch.scad"
    stl_out = HARDWARE_DIR / "snap_circuit_chassis.stl"

    typer.echo(f"Compiling 3D Chassis: {stl_out.name}")
    subprocess.run(["openscad", "-o", str(stl_out), str(scad_file)])
    typer.secho("3D Chassis compilation complete.", fg=typer.colors.GREEN)

@app.command()
def build_kicad_profile():
    """Generates the 2D DXF PCB outline for KiCad Edge.Cuts."""
    scad_file = HARDWARE_DIR / "kicad_edge_cuts.scad"
    dxf_out = HARDWARE_DIR / "snap_circuit_pcb_outline.dxf"

    typer.echo(f"Generating KiCad Edge.Cuts: {dxf_out.name}")
    subprocess.run(["openscad", "-o", str(dxf_out), str(scad_file)])
    typer.secho("KiCad profile generated successfully.", fg=typer.colors.CYAN)
    typer.echo("INSTRUCTIONS: Import this DXF into KiCad PCB Editor on the 'Edge.Cuts' layer.")

if __name__ == "__main__":
    app()
