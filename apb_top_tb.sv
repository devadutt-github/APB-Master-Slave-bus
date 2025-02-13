`timescale 1ns / 1ps

module apb_top_tb;
    parameter ADDRESS_WIDTH = 32;
    parameter DATA_WIDTH = 32;

    logic M_CLK;
    logic S_CLK;
    logic RSTn;

    // Master interface (for testbench control)
    reg [ADDRESS_WIDTH-1:0] ADDRESS;
    reg [DATA_WIDTH-1:0] WDATA;
    reg W_ENABLE;
    reg R_ENABLE;
    wire [DATA_WIDTH-1:0] RDATA; 

    apb_top #(
        .ADDRESS_WIDTH(ADDRESS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .M_CLK(M_CLK),
        .S_CLK(S_CLK),
        .RSTn(RSTn),
        .ADDRESS(ADDRESS),
        .WDATA(WDATA),
        .W_ENABLE(W_ENABLE),
        .R_ENABLE(R_ENABLE),
        .RDATA(RDATA)
    );

    // Clock generation
    initial begin
        M_CLK = 0;
        forever #5 M_CLK = ~M_CLK; // 10ns clock period
    end
    initial begin
        S_CLK = 0;
        forever #7 S_CLK = ~S_CLK; // 10ns clock period
    end

    // Reset sequence
    initial begin
        RSTn = 0;
        #10;
        RSTn = 1;
    end

    initial begin
        W_ENABLE = 0;
        ADDRESS = 32'h0;
        WDATA = 32'h0;
        #10;
        // Write test
        ADDRESS = 32'h0010;
        WDATA = 32'hABCD1234;
        W_ENABLE = 1;
        R_ENABLE = 0;
        #30;
        W_ENABLE = 0;
      	
      	// Write test
        ADDRESS = 32'h0011;
        WDATA = 32'hBCDA1234;
        W_ENABLE = 1;
        R_ENABLE = 0;
        #30;
        W_ENABLE = 0;
      
      	 // Read test
        ADDRESS = 32'h0011;  // Use the same address for reading
        W_ENABLE = 0;
        R_ENABLE = 1;
        #30;
        R_ENABLE = 0;
      
        // Read test
        ADDRESS = 32'h0010;  // Use the same address for reading
        W_ENABLE = 0;
        R_ENABLE = 1;
        #30;
        R_ENABLE = 0;

        #40;  // Add some extra time before $finish
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, apb_top_tb);
    end

endmodule