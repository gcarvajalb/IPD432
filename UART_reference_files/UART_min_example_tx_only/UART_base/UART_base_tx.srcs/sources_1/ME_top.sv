module ME_top
(
	input  logic               clk_100M,
	input  logic               reset_n,

	input  logic               uart_rx,
	output logic               uart_tx,
	output logic               uart_tx_busy,
	output logic               uart_tx_usb,
	
	input  logic               button_c,
	input  logic    [15:0]     switches
);
	/*
	 * Convertir la se�al del bot�n reset_n a 'active HIGH'
	 * y sincronizar con el reloj.
	 */
	logic [7:0]    tx_data; 
	logic [7:0]    rx_data; 
	logic [15:0]   result16;
	logic [31:0]   bcd;
	
	logic [1:0]    reset_sr;
	logic reset;
	assign reset = reset_sr[1];
	
	always_ff @(posedge clk_100M)
		reset_sr <= {reset_sr[0], ~reset_n};

    assign uart_tx_usb = uart_tx;
    assign uart_tx_busy = tx_busy;

	/* Debouncer */
	pb_debouncer #(
		.COUNTER_WIDTH(16)
	) pb_deb0 (
		.clk(clk_100M),
		.rst(reset),
		.pb(button_c),
		.pb_state(),
		.pb_negedge(),
		.pb_posedge(button_c_posedge)
	);

// Logica de control para transmitir las secuencias por la UART
UART_tx_control_wrapper 
#(  .INTER_BYTE_DELAY (100000),
    .WAIT_FOR_REGISTER_DELAY (100)
    
    ) UART_control_inst (
	.clock(clk_100M),
    .reset(reset),
    .PB(button_c_posedge),
    .SW(switches),
    .tx_data(tx_data),
    .tx_start(tx_start)
    );

	/* M�dulo UART a 115200/8 bits datos/No paridad/1 bit stop */
	uart_basic #(
		.CLK_FREQUENCY(100000000), // reloj base de entrada
		.BAUD_RATE(115200)
	) uart_basic_inst (
		.clk(clk_100M),
		.reset(reset),
		.rx(),
		.rx_data(),
		.rx_ready(),
		.tx(uart_tx),
		.tx_start(tx_start),
		.tx_data(tx_data),
		.tx_busy(tx_busy)
	);

endmodule