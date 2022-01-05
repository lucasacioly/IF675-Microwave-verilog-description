`timescale 1ns/1ns
`include "mux.v"


module mux_tb();

	reg cont_tb, div_tb, sel_tb;
	wire pgt_tb;

	mux DUT(.cont(cont_tb), .div(div_tb), .sel(sel_tb), .pgt(pgt_tb));

	initial
		begin
		
			$dumpfile("mux_tb.vcd");
			$dumpvars(0,mux_tb);
		
			cont_tb = 0; div_tb = 0; sel_tb = 0;

            #10 cont_tb = 0; div_tb = 1; sel_tb = 0;
            
            #10 cont_tb = 1; div_tb = 0; sel_tb = 0;
            #10 cont_tb = 1; div_tb = 1; sel_tb = 0;

            #10 cont_tb = 0; div_tb = 0; sel_tb = 1;
            #10 cont_tb = 0; div_tb = 1; sel_tb = 1;
            
            #10 cont_tb = 1; div_tb = 0; sel_tb = 1;
            #10 cont_tb = 1; div_tb = 1; sel_tb = 1;

            #10;
		end

endmodule
