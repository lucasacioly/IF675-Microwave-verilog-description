`timescale 1ms/1ms
`include "c_input.v"


module c_input_tb();

	reg [9:0] keypad_tb;
    reg enable_tb, clock_tb;
	wire [3:0] Digit_tb;
    wire loadn_tb, pgt_out_tb;

	c_input DUT(.keys(keypad_tb), .enable(enable_tb), .clock(clock_tb),
                .Digit(Digit_tb), .loadn(loadn_tb), .pgt_out(pgt_out_tb));

	initial
		begin
		
			$dumpfile("c_input_tb.vcd");
			$dumpvars(0,c_input_tb);

            #10;
		end

endmodule
