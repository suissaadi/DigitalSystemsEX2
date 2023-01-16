// 64-bit ALU test banch
module mult32x32_autotest;
	logic clk;            // Clock
    logic reset;         // Reset
    logic start;         // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;          // Multiplier busy indication
    logic [63:0] product;
	logic [63:0] product_expected;
	
	mult32x32 uut(
		.clk(clk),
		.reset(reset),
		.start(start),
		.busy(busy),
		.a(a),
		.b(b),
		.product(product)
	);
	
	const int clk_cycle = 10;
	logic [127:0] inputTestVector[31:0];
	integer i;
	always begin
		#5	clk = ~clk;
	end	
	initial begin
		
		// read the inputs for the simulation and the expected outputs
		$readmemb("MultInputVector.txt", inputTestVector);
		
		
		$display("********************");
		$display("(****RUN TESTS******");
		$display("********************");
		clk = 1'b1;
			start = 1'b0;
			reset = 1'b1;
			a = 32'b0;
			b = 32'b0;
			#clk_cycle
			#clk_cycle
			#clk_cycle
			#clk_cycle
			reset = 1'b0;
		//check NOR and XOR - only s matter
		for(i = 0; i < 32; i++) begin
			
			{a, b, product_expected} = inputTestVector[i];
			#clk_cycle
			start = 1'b1;
			#clk_cycle
			start = 1'b0;
			#3000;
			assert(product_expected == product) $display("Test%d>>passed", i+1); else $error("test%d failed :(", i+1);
		end
		$stop;
	end
	
	endmodule