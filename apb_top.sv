// Code your design here

`include "apb_master.sv"
`include "apb_slave.sv"
`include "single_port_ram.sv"

module apb_top #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  logic M_CLK,
    input  logic S_CLK,
    input  logic RSTn,

    // Master interface 
    input  logic [ADDRESS_WIDTH-1:0] ADDRESS,
    input  logic [DATA_WIDTH-1:0] WDATA,
    input  logic W_ENABLE,
    input  logic R_ENABLE,
    output logic [DATA_WIDTH-1:0] RDATA 
);

    // APB signals
    logic TRANSFER;
    logic [ADDRESS_WIDTH-1:0] PADDR;
    logic [DATA_WIDTH-1:0] PWDATA;
    logic PWRITE;
    logic PSEL;
    logic PENABLE;
    logic PREADY;
    logic [DATA_WIDTH-1:0] PRDATA;

    // Memory signals
    logic mem_we;
    logic mem_enable;
    logic [ADDRESS_WIDTH-1:0] mem_addr;
    logic [DATA_WIDTH-1:0] mem_data_in;
    logic [DATA_WIDTH-1:0] mem_data_out;


    // Instantiate APB Master
    apb_master #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) master (
        .PCLK(M_CLK),
        .PRESETn(RSTn),
        .ADDRESS(ADDRESS),
        .WDATA(WDATA),
        .W_ENABLE(W_ENABLE),
        .R_ENABLE(R_ENABLE),
        .M_PREADY(PREADY),
        .M_PRDATA(PRDATA),
        .M_TRANSFER(TRANSFER),
        .M_PADDR(PADDR),
        .M_PWDATA(PWDATA),
        .M_PWRITE(PWRITE),
        .M_PSEL(PSEL),
        .M_PENABLE(PENABLE),
        .M_RDATA(RDATA)
    );

    // Instantiate APB Slave
    apb_slave #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) slave (
        .PCLK(S_CLK),
        .PRESETn(RSTn),
        .S_PSEL(PSEL),
        .S_PENABLE(PENABLE),
        .S_PWRITE(PWRITE),
        .S_PADDR(PADDR),
        .S_PWDATA(PWDATA),
        .S_PREADY(PREADY),
        .S_PRDATA(PRDATA),
        .mem_we(mem_we),
        .mem_enable(mem_enable),
        .mem_addr(mem_addr),
        .mem_data_in(mem_data_in),
        .mem_data_out(mem_data_out)
    );

    // Instantiate Single Port RAM
    single_port_ram #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) ram (
      .CLK(S_CLK),
        .RSTn(RSTn),
        .we(mem_we),
        .enable(mem_enable),
        .addr(mem_addr),
        .data_in(mem_data_in),
        .data_out(mem_data_out)
    );

endmodule