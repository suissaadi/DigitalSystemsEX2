// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);
//declaring variables
logic [7:0] a_mux_result;
logic [15:0] b_mux_result;
logic [23:0] mult=24'b0;
logic [63:0] shifter;



// Put your code here
// ------------------




//A(32bit) 4 to 1 mux
always_comb begin
    case (a_sel)
        2'b00: a_mux_result = a[7:0];
        2'b01: a_mux_result = a[15:8];
        2'b10: a_mux_result = a[23:16];
        2'b11: a_mux_result = a[31:24];
    endcase
end

//B(32bit) 2 to 1 mux
always_comb begin 
    case (b_sel)
        1'b0: b_mux_result = b[15:0];
        1'b1: b_mux_result = b[31:16];
    endcase
end

//16X8 multiplier
always_ff @(posedge clk) begin
    if (!reset) begin
        mult <= 24'b0;
    end
    else begin
        mult <= a_mux_result * b_mux_result;
    end
end

//16X8 shifter
always_comb begin 
    case (shift_sel)
        3'b000: shifter = mult;
        3'b001: shifter = mult << 8;
        3'b010: shifter = mult << 16;
        3'b011: shifter = mult << 24;
        3'b100: shifter = mult << 32;
        3'b101: shifter = mult << 40;
        3'b110: shifter = mult << 48;
        3'b111: shifter = mult << 56;
    endcase
end

//64bit register
always_ff @(posedge clk ) begin
    if (!reset) begin
        product <= 64'b0;
    end
    else if (clr_prod) begin
        product <= 64'b0;
    end
    else if (upd_prod) begin
        product += shifter;
    end



    
end


// End of your code

endmodule
