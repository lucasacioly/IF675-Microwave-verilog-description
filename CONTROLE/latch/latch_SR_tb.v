`timescale 1ns/1ps
`include "latch_SR.v"

module latch_SR_TB();

	//inputs
	reg S_TB, R_TB;

	//outputs
	wire Q_TB;

	latch_SR DUT(.S(S_TB), .R(R_TB), .Q(Q_TB));

	initial
		begin
		
			$dumpfile("latch_SR_TB.vcd");
			$dumpvars(0,latch_SR_TB);
		
			S_TB = 1'b1; R_TB = 1'b0;
        #10 S_TB = 1'b0; R_TB = 1'b0;
		#10 S_TB = 1'b1; R_TB = 1'b1;
		#10 S_TB = 1'b0; R_TB = 1'b0;
		#10 S_TB = 1'b0; R_TB = 1'b1;
		#10 S_TB = 1'b0; R_TB = 1'b0;
        #10	S_TB = 1'b1; R_TB = 1'b0;
        #10 S_TB = 1'b0; R_TB = 1'b0;        
        #10;

		end

endmodule






