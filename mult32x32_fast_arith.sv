// 32X32 Multiplier arithmetic unit template
module mult32x32_fast_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic a_msb_is_0,     // Indicates MSB of operand A is 0
    output logic b_msw_is_0,     // Indicates MSW of operand B is 0
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
logic [7:0] a_mux_result=8'b0;
logic [15:0] b_mux_result=16'b0;
logic [23:0] mult=24'b0;
logic [63:0] shifter0=63'b0;
logic [63:0] shifter8=63'b0;
logic [63:0] shifter16=63'b0;
logic [63:0] shifter24=63'b0;
logic [63:0] shifter32=63'b0;
logic [63:0] shifter40=63'b0;
logic [63:0] shifter=63'b0;
logic [63:0] adderReg=63'b0;


// Put your code here
// ------------------

//check if the Most significant byte of A is 0 or not
always_comb begin
    if (a[31:24] == 8'b0) begin
        a_msb_is_0 = 1'b1;
    end
    else begin
        a_msb_is_0 = 1'b0;
    end
end

//check if the Most significant word of B is 0 or not
always_comb begin
    if (b[31:16] == 16'b0) begin
        b_msw_is_0 = 1'b1;
    end
    else begin
        b_msw_is_0 = 1'b0;
    end
end



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
always_comb begin
    if (!reset) begin
        mult <= a_mux_result * b_mux_result;
        
    end
    else begin
        mult <= 24'b0;
    end
end


//shifters registers
always_comb begin
    if (!reset) begin
        shifter0 <= mult;
        shifter8 <= mult << 8;
        shifter16 <= mult << 16;
        shifter24 <= mult << 24;
        shifter32 <= mult << 32;
        shifter40 <= mult << 40;
    end
    else begin
        shifter0 <= 63'b0;
        shifter8 <= 63'b0;
        shifter16 <= 63'b0;
        shifter24 <= 63'b0;
        shifter32 <= 63'b0;
        shifter40 <= 63'b0;
    end
end

//mux based on shift_sel to select the output from shifters
always_comb begin
    case (shift_sel)
        3'b000: shifter = shifter0;
        3'b001: shifter = shifter8;
        3'b010: shifter = shifter16;
        3'b011: shifter = shifter24;
        3'b100: shifter = shifter32;
        3'b101: shifter = shifter40;
endcase
end

//64 bit adder to add the output from shifters
always_comb begin
    if (!reset) begin
        adderReg <= product + shifter;
    end
    else begin
        adderReg <= 64'b0;
    end
end

//clear the product register
always_ff @(posedge clk, posedge reset) begin
    if (!reset) begin
        if (clr_prod) begin
            product <= 64'b0;
        end
        else if (upd_prod) begin
            product <= adderReg;
        end
    end
    else begin
        product <= 64'b0;
    end
end



// End of your code

endmodule
