// APB Slave Module
module apb_slave #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  logic PCLK,
    input  logic PRESETn,
    input  logic S_PSEL,
    input  logic S_PENABLE,
    input  logic S_PWRITE,
    input  logic [ADDRESS_WIDTH-1:0] S_PADDR,
    input  logic [DATA_WIDTH-1:0] S_PWDATA,

    output logic S_PREADY,
    output logic [DATA_WIDTH-1:0] S_PRDATA,

    // Memory interface 
    output logic mem_we,
    output logic mem_enable,
    output logic [ADDRESS_WIDTH-1:0] mem_addr,
    output logic [DATA_WIDTH-1:0] mem_data_in,
    input  logic [DATA_WIDTH-1:0] mem_data_out
);

    
    always_ff @(posedge PCLK) begin
        if (!PRESETn) begin
            S_PREADY <= 1'b0;
            mem_enable <= 1'b0;
        end else begin
            if (S_PSEL && S_PENABLE) begin
                    mem_enable <= 1'b1;
                    mem_we <= S_PWRITE;
                    mem_addr <= S_PADDR;
                if (S_PWRITE) begin 
                    mem_data_in <= S_PWDATA;
                    S_PREADY <= 1'b1; // Memory assumed to be ready immediately
                end else begin // Read operation
                    S_PRDATA <= mem_data_out;
                    S_PREADY <= 1'b1; // Memory assumed to be ready immediately 
                end
            end else begin
               mem_we <= 1'b0;
               S_PREADY <= 1'b0;
                mem_enable <= 1'b0;
            end
        end
    end

   

endmodule