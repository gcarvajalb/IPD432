// Module header:-----------------------------
module module_name
#(parameter
	param1 = <value> ,
	param2 = <value> )
(
	input 	logic clk, rst, ...
	input 	logic [7:0] inp1, inp2, ...
	output 	logic [15:0] outp1, outp2, ...);

 //Declarations:------------------------------

 //FSM states type:
enum logic [10:0] {A, B, C, ...} CurrentState, NextState;

 //Statements:--------------------------------

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) CurrentState < = A;
	else CurrentState <= NextState;

 //FSM combinational logic:
 always_comb
	NextState = A;  //Optional default state assigment
	case (CurrentState)
		A: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (condition) NextState = B;
			else if (condition) NextState = ...;
			else NextState = A;
		end
 
		B: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (condition) NextState = C;
			else if (condition) NextState = ...;
			else NextState = B;
		end
 
		C: begin
			...
			end
			...
	endcase

 //Optional output register (if required). It simply delays the combinational outputs to prevent propagation of glitches.
	always_ff @(posedge clk)
		if (rst) begin //rst might be not needed here
			new_outp1 <= ...;
			new_outp2 <= ...; ...
		end
		else begin
			new_outp1 <= outp1;
			new_outp2 <= outp2; ...
		end

 endmodule
