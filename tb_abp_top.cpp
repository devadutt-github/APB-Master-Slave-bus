#include "Vapb_top.h"   // Include the generated Verilog model
#include "verilated.h"  // Verilator header
#include "verilated_vcd_c.h"  // For waveform dumping (optional)

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vapb_top* dut = new Vapb_top;

    VerilatedVcdC* trace = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    dut->trace(trace, 99);
    trace->open("waveform.vcd");

    // Reset
    dut->RSTn = 0;
    dut->M_CLK = 0;
    dut->S_CLK = 0;
    for (int i = 0; i < 5; i++) {
        dut->eval();
    }
    dut->RSTn = 1;

    // Clocking
    for (int cycle = 0; cycle < 100; cycle++) {
        // Toggle Clocks
        dut->M_CLK = !dut->M_CLK;
        dut->S_CLK = !dut->S_CLK;

        // Write Operation
        if (cycle == 10) {
            dut->ADDRESS = 0x0010;
            dut->WDATA = 0xABCD1234;
            dut->W_ENABLE = 1;
            dut->R_ENABLE = 0;
        }
        if (cycle == 15) {
            dut->W_ENABLE = 0;
        }

        // Read Operation
        if (cycle == 20) {
            dut->ADDRESS = 0x0010;
            dut->W_ENABLE = 0;
            dut->R_ENABLE = 1;
        }
        if (cycle == 25) {
            dut->R_ENABLE = 0;
            printf("Read Data: 0x%08X\n", dut->RDATA);
        }

        dut->eval(); // Evaluate DUT
        trace->dump(cycle);
    }

    trace->close();
    delete dut;
    return 0;
}
