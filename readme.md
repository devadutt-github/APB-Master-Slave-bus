# APB-Master-Slave-bus

## Repository Overview
This repository implements an **APB (Advanced Peripheral Bus) Master-Slave** interface along with a **testbench** and **RAM memory module**. The design is structured to support **asynchronous clocking** between the Master and Slave components and is verified using **Verilator**.

## Features
- **APB Master and Slave** with independent clock domains
- **RAM memory module** for data storage
- **C++ Testbench** for functional verification with Verilator
- **Simulation waveforms** included for analysis

## Repository Structure
```
APB-Master-Slave-bus/
│── apb_master.sv       # APB Master Module
│── apb_slave.sv        # APB Slave Module
│── apb_top.sv          # Top-level Design
│── ram_memory.sv       # RAM Memory Module
│── tb_apb_top.cpp      # C++ Testbench for Verilator
│── sim_waveforms/      # Simulation results and waveforms
│── README.md           # Project Documentation
```

## APB Master-Slave Design
- The **Master** initiates transactions, generating APB control signals.
- The **Slave** responds to Master requests, handling data read/write operations.
- The design supports **asynchronous clocks** between Master and Slave, making it suitable for multi-clock domain systems.

## Simulation & Verification
- The testbench (`tb_apb_top.cpp`) is designed to verify the APB Master-Slave protocol using **Verilator**.
- Simulation waveforms included in `sim_waveforms/` provide insights into bus operations.

## Getting Started
### Prerequisites
Ensure you have **Verilator** installed:
```sh
sudo apt install verilator  # Ubuntu/Linux
brew install verilator      # macOS
```

### Running the Simulation
1. Clone the repository:
   ```sh
   git clone https://github.com/devadutt-github/APB-Master-Slave-bus.git
   cd APB-Master-Slave-bus
   ```
2. Compile the Verilog design and C++ testbench:
   ```sh
   verilator --cc --exe --build apb_top.sv apb_master.sv apb_slave.sv ram_memory.sv tb_apb_top.cpp -o sim
   ```
3. Run the simulation:
   ```sh
   ./sim
   ```
4. View the generated waveforms:
   ```sh
   gtkwave waveform.vcd
   ```

## License
This project is released under the MIT License.

---
Contributions and improvements are welcome!

