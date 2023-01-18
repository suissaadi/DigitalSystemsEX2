// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here

	mult32x32_fast uut  (.clk(clk), 
					.reset(reset), 
					.start(start), 
					.a(a), 
					.b(b), 
					.busy(busy), 
					.product(product)
	);
	
	initial begin
	
		clk = 1'b0;
		start = 1'b0;
		reset = 1'b1;
		repeat (4) begin
			@(posedge clk);
		end
		
		reset = 1'b0;
		a = 208459867;
		b = 315157909;
		@(posedge clk);
		
		start = 1'b1;
		@(posedge clk);
		start = 1'b0;
		@(negedge busy);
		@(posedge clk);
		
		//change a such that the most significant two bytes are 0
		a = { 16'b0, a[15:0] };
		//change b such that the most significant two bytes are 0
		b = { 16'b0, b[15:0] };
	
		
		@(posedge clk);
		
		start = 1'b1;
		@(posedge clk);
		start = 1'b0;
		@(negedge busy);
	
	end
	
	always begin
		#10 clk = ~clk;
	end

// End of your code

endmodule


// id1 decimal = 208459867, 
// id1 binary = 1100011011001101100001011011
// id1 decimal WO upper byte = 841819

// id2 decimal = 315157909
// id2 binary = 10010110010001110110110010101
// id2 decimal WO upper byte = 585109
