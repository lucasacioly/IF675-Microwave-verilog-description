`timescale 1ms / 1ms
`include "fdivider.v"

module fdivider_tb();
    // Inputs
    reg clk_in_tb;
    
    // Outputs
    wire clk_out_tb;
    
    // Instantiate the Unit Under Test (UUT)
    // Test the clock divider in Verilog
    fdivider DUT (.clk_in(clk_in_tb), .clk_out(clk_out_tb));
    
    integer i;

    initial 
        begin
            $dumpfile("fdivider_tb.vcd");
			$dumpvars(0,fdivider_tb);
           
            // Initialize Inputs
            clk_in_tb = 0;
            
            // create input clock 100Hz
            for (i = 0; i < 1001; i = i + 1) 
                #5 clk_in_tb = ~clk_in_tb;

        end
        
endmodule
