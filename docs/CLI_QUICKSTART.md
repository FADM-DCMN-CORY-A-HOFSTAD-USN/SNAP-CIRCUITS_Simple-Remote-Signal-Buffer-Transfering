# Command Line Interface (CLI) Quickstart Guide

The Snap Circuit repository utilizes `Typer` to provide a robust, self-documenting command-line interface. This ensures that engineers from various disciplines (Silicon, Aerospace, Datacenter) can interact with the theoretical models and generate hardware blueprints without needing to read the underlying source code.

## Environment Setup

Ensure you have Python 3.8 or newer installed on your system. Install the required dependencies:

`pip install typer`

## 1. The Enterprise Integration CLI
If you are an integration engineer assigned to adapt the Double Latch Gate for your specific industry, use the Enterprise CLI to generate your deployment blueprint.

`python src/enterprise_integration_cli.py generate-blueprint --help`

To output the requirements for an aerospace deployment (e.g., Boeing, Lockheed):
`python src/enterprise_integration_cli.py generate-blueprint aerospace`

## 2. The Educational & USPTO CLI
To review the core physics, the differences between physical fractures and chemical oxidation, and the formal prior art declarations:

`python src/quantum_network_cli.py textbook-theory`
`python src/quantum_network_cli.py priority-claim`

## 3. The Machine Plant Hardware Builder
To execute the automated CNC milling pathways and KiCad PCB boundaries:

`python src/build_hardware.py build-chassis`
`python src/build_hardware.py build-kicad-profile`
