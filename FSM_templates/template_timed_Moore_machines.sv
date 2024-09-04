//Timed Moore machine 

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

  //Timer-related declarations:
 const logic [7:0] T1 = <value> ;
 const logic [7:0] T2 = <value> ;
 const logic [7:0] tmax = <value> ;//tmax ≥ max(T1,T2,...)-1
 logic [7:0] t;

 //Part 3: Statements:---------------------------------------

 //Timer :
 always_ff @(posedge clk)
	if (rst) t < = 0;
	else if (CurrentState != NextState) t <= 0; //reset the timer when state changes
	else if (t != tmax) t <= t + 1;

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) CurrentState <= A;
	else CurrentState <= NextState;
 
 //FSM combinational logic:
 always_comb
	case (CurrentState)
		A: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (... and t > =T1-1) NextState = B;
			else if (... and t >= T2-1) NextState = ...;
			else NextState = A;
		end
 
		B: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (... and t >= T3-1) NextState = C;
			else if (...) NextState = ...;
			else NextState= B;
		end
 
		C: begin
			...
			end
		...
	endcase

 //Optional output register (if required). Adds a FF at the output to prevent the propagation of glitches from comb. logic.
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
