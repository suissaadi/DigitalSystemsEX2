// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
	output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here

	typedef enum {idle, st_1, st_2, st_3, st_4, st_5, st_6, st_7, st_8} state;
	
	state current_state;
	state next_state;
	
	always_ff @(posedge clk, posedge reset, posedge start) begin
		if(reset == 1'b1) begin
			current_state <= idle;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin

		// default assignments:
		next_state = current_state;
		busy = 1'b0;
		a_sel = 2'b00;
		b_sel = 1'b0;
		shift_sel = 3'b000;
		upd_prod = 1'b0;
		clr_prod = 1'b0;
		
		case (current_state)
		idle: begin
			if (start == 1'b1) begin
			
				clr_prod = 1'b1;
				next_state = st_1;
			end
			
		end
	
		st_1: begin
			busy = 1'b1;
			a_sel = 2'b00;
			shift_sel = 3'b000;
			upd_prod = 1'b1;
			
			next_state = st_2;
		end
		
		st_2: begin
			busy = 1'b1;
			a_sel = 2'b01;
			shift_sel = 3'b001;
			upd_prod = 1'b1;
			
			next_state = st_3;
		end
		
		st_3: begin
			busy = 1'b1;
			a_sel = 2'b10;
			shift_sel = 3'b010;
			upd_prod = 1'b1;
				
			next_state = st_4;
		end
		
		st_4: begin
			busy = 1'b1;
			a_sel = 2'b11;
			b_sel = 1'b0;
			shift_sel = 3'b011;
			upd_prod = 1'b1;
				
			next_state = st_5;
		end
		
		st_5: begin
			busy = 1'b1;
			a_sel = 2'b00;
			b_sel = 1'b1;
			shift_sel = 3'b010;
			upd_prod = 1'b1;
				
			next_state = st_6;
		end
		
		st_6: begin
			busy = 1'b1;
			a_sel = 2'b01;
			b_sel = 1'b1;
			shift_sel = 3'b011;
			upd_prod = 1'b1;
				
			next_state = st_7;
		end
		
		st_7: begin
			busy = 1'b1;
			a_sel = 2'b10;
			b_sel = 1'b1;
			shift_sel = 3'b100;
			upd_prod = 1'b1;
			
			next_state = st_8;
		end
		
		st_8: begin
				busy = 1'b1;
			a_sel = 2'b11;
			b_sel = 1'b1;
			shift_sel = 3'b101;
			upd_prod = 1'b1;
			busy = 1'b1;
			next_state = idle;
		end
	

	endcase
	end
// End of your code

endmodule
