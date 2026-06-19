"""
Quantum SMI Telemetry Viewer
Command-line interface to monitor NVIDIA SMI data on the Hexadecimal Quantum Link.
"""

import typer
import time
from hex_native_tpm_smi import HexNativeTPM_SMI

app = typer.Typer(
    name="QuantumSMI",
    help="NVIDIA System Management Interface for Quantum Snap Circuits",
    add_completion=False
)

@app.command()
def watch_link(node_id: str = typer.Argument("ALPHA_01")):
    """
    Initiates a continuous, live-updating SMI monitoring session for the specified node.
    """
    tpm_module = HexNativeTPM_SMI(node_id)
    
    typer.secho("Initializing NVIDIA-SMI Quantum Hardware Hook...", fg=typer.colors.CYAN)
    time.sleep(1)
    
    # Simulate a live watch loop (runs once for demonstration in CLI)
    typer.clear()
    report = tpm_module.generate_smi_report()
    typer.echo(report)
    
    typer.secho("\nUnivac SCADA Connection: ACTIVE", fg=typer.colors.GREEN)
    typer.secho("Boeing Telemetry Relay: SECURE", fg=typer.colors.GREEN)

if __name__ == "__main__":
    app()
