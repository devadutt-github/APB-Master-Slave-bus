// APB Master Module
module apb_master #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  logic PCLK,
    input  logic PRESETn,
    input  logic [ADDRESS_WIDTH-1:0] ADDRESS,
    input  logic [DATA_WIDTH-1:0] WDATA,
    input  logic W_ENABLE,
    input  logic R_ENABLE,

    input  logic M_PREADY,
    input  logic [DATA_WIDTH-1:0] M_PRDATA,

    output logic M_TRANSFER,
    output logic [ADDRESS_WIDTH-1:0] M_PADDR,
    output logic [DATA_WIDTH-1:0] M_PWDATA,
    output logic M_PWRITE,
    output logic M_PSEL,  
    output logic M_PENABLE,
    output logic [DATA_WIDTH-1:0] M_RDATA // Read data output
);

    

    assign M_TRANSFER = (W_ENABLE || R_ENABLE);
    assign M_PADDR = (state == IDLE) ? '0 : ADDRESS;
    assign M_PWDATA = (state == IDLE && W_ENABLE) ? '0 : WDATA;
    assign M_PWRITE = (state == IDLE) ? 0 : W_ENABLE;
    assign M_PSEL = (state == IDLE) ? 0 : 1; 
    assign M_PENABLE = (state == ACCESS) ? 1 : 0;
    assign M_RDATA = M_PRDATA;

    typedef enum logic [1:0] {IDLE, SETUP, ACCESS} state_type;
    state_type state, next_state;

    always_ff @(posedge PCLK) begin
        if (!PRESETn) begin
            state <= IDLE;
           
        end else begin
            state <= next_state;
            if (state == ACCESS && R_ENABLE && M_PREADY) begin
              
            end
          
        end
    end

    always_comb begin
        next_state = state; 
        case (state)
            IDLE: begin
                if (W_ENABLE || R_ENABLE) begin
                    next_state = SETUP;
                end
            end
            SETUP: begin
                next_state = ACCESS;
            end
            ACCESS: begin
                if (!M_PREADY) begin
                    next_state = ACCESS; // Wait for slave
                end else if (W_ENABLE || R_ENABLE) begin // New transfer requested
                    next_state = SETUP;
                end else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule