`timescale 1ps/1ps

`include "abp_master.v"

module abp_master_tb;
    logic PCLK;
    logic PRESETn;
    logic [31:0] address;
    logic [31:0] W_data;
    logic [31:0] R_data;
    logic W_enable;
    logic R_enable;

    logic PREADY;
    logic [31:0] PRDATA;
    logic TRANSFER;
    logic [31:0] PADDR;
    logic [31:0] PWDATA;
    logic PWRITE;
    logic PSELx;
    logic PENABLE;


    abp_master dut (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .address(address),
        .W_data(W_data),
        .R_data(R_data),
        .W_enable(W_enable),
        .R_enable(R_enable),
        .PREADY(PREADY),
        .PRDATA(PRDATA),
        .TRANSFER(TRANSFER),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PWRITE(PWRITE),
        .PSELx(PSELx),
        .PENABLE(PENABLE)
    );

    initial begin
        PCLK = 0;
        forever #5 PCLK = ~PCLK; // 10ns clock period
    end

    initial begin
        PRESETn = 0;
        address = 0;
        W_data = 0;
        W_enable = 0;
        R_enable = 0;
        PREADY = 0;
        PRDATA = 0;

        #10;
        PRESETn = 1;

        // Write test
        address = 32'h1000;
        W_data = 32'hABCD1234;
        W_enable = 1;
        #10;
        W_enable = 0;
        PREADY = 1; // Simulate slave ready after some delay
        #10;
        PREADY = 0; // Deassert PREADY after transfer
        #10;

        // Read test
        address = 32'h1000;
        R_enable = 1;
        #10;
        R_enable = 0;
        PREADY = 1;
        PRDATA = 32'h5678EF01; // Data from slave
        #10;
        PREADY = 0;
        #10;

        $finish;
    end

endmodule