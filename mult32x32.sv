// 32X32 Iterative Multiplier template
module mult32x32 (
    input logic clk,            // Clock
    input logic reset,          // Reset
    input logic start,          // Start signal
    input logic [31:0] a,       // Input a
    input logic [31:0] b,       // Input b
    output logic busy,          // Multiplier busy indication
    output logic [63:0] product // Miltiplication product
);
//2 to a selector
logic [1:0] a_sel=2'b00;

logic  b_sel=1'b0;
logic [2:0] shift_sel=3'b000;
logic upd_product=1'b0;
logic clr_product=1'b0;




// Put your code here
// ------------------
/*
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
	output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod 
*/
mult32x32_fsm fsm(
    .clk(clk),
    .reset(reset),
    .start(start),
    .a_sel(a_sel),
    .b_sel(b_sel),
    .shift_sel(shift_sel),
    .busy(busy),
    .clr_prod(clr_product),
    .upd_prod(upd_product)
);
// ------------------
/*
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product   // Miltiplication product
*/

mult32x32_arith arith(
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .a_sel(a_sel),
    .b_sel(b_sel),
    .shift_sel(shift_sel),
    .upd_prod(upd_product),
    .clr_prod(clr_product),
    .product(product)
);


// End of your code

endmodule
