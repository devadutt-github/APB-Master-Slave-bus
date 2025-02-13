# APB-Master-Slave-bus

## Repository Overview
This repository implements an **APB (Advanced Peripheral Bus) Master-Slave** interface along with a **testbench** and **RAM memory module**. The design is structured to support **asynchronous clocking** between the Master and Slave components.

## Features
- **APB Master and Slave** with independent clock domains
- **RAM memory module** for data storage
- **Testbench (TB)** for functional verification
- **Simulation waveforms** included for analysis

## Repository Structure
```plaintext
APB-Master-Slave-bus/
├── apb_master.sv       # APB Master Module
├── apb_slave.sv        # APB Slave Module
├── apb_top_tb.sv       # Top-level Testbench
├── ram_memory.sv       # RAM Memory Module
├── sim_waveforms/      # Simulation results and waveforms
├── README.md           # Project Documentation
```

## APB Master-Slave Design
- The **Master** initiates transactions, generating APB control signals.
- The **Slave** responds to Master requests, handling data read/write operations.
- The design supports **asynchronous clocks** between Master and Slave, making it suitable for multi-clock domain systems.

## Simulation & Verification
- The testbench (`apb_top_tb.sv`) is designed to verify the APB Master-Slave protocol.
- Simulation waveforms included in `sim_waveforms/` provide insights into bus operations.

## Getting Started
### Prerequisites
Ensure you have a Verilog simulator such as:
- **ModelSim / QuestaSim**
- **VCS**
- **iverilog**

### Running the Simulation
```sh
git clone https://github.com/devadutt-github/APB-Master-Slave-bus.git
cd APB-Master-Slave-bus

# Compile the testbench
vlog apb_top_tb.sv

# Run the simulation
vsim -c -do "run -all"
```

## License
This project is released under the MIT License.

---
Contributions and improvements are welcome!

