module UART_tx_control_wrapper
#(	parameter INTER_BYTE_DELAY = 1000000,
    parameter WAIT_FOR_REGISTER_DELAY = 100
)(
	input  logic           clock,
    input  logic           reset,
    input  logic           PB,
    input  logic [15:0]    SW,
    output logic [7:0]     tx_data,
    output logic           tx_start
    );

TX_control 
#(  .INTER_BYTE_DELAY (INTER_BYTE_DELAY),
    .WAIT_FOR_REGISTER_DELAY (WAIT_FOR_REGISTER_DELAY)
)TX_control_inst0
(
	.clock (clock),
	.reset (reset),
	.PB (PB),
	.send16 (1'b1),
	.dataIn16 (SW),
	.tx_data (tx_data),
	.tx_start (tx_start),
	.busy ()
    );

endmodule