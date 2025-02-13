module single_port_ram #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input logic CLK,
    input logic RSTn,
    input logic enable,
    input logic we,  // Write enable
    input logic [ADDRESS_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);

  logic [31:0] memory [0:31]; // Memory array

    always_ff @(posedge CLK) begin
        if (!RSTn) begin
             memory <= '{default: 0};  // Optional: Initialize memory on reset
        end else begin
          
          if (we && enable) begin
                  memory[addr] <= data_in;
          end else if (~we && enable)begin
                data_out <=  memory[addr];
              end
          
        end
    end

endmodule