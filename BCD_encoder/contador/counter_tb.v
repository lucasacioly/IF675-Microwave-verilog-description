`timescale 1ms / 1ms
`include "counter.v"

module counter_tb();
    // Inputs
    reg clk_tb, clear_tb;
    
    // Outputs
    wire delay_tb;
    
    // Instantiate the Unit Under Test (UUT)
    // Test the clock divider in Verilog
    counter DUT (.clk(clk_tb), .delay(cdelay_tb), .clear(clear_tb));
    
    integer i;
    
    // clock generator
    initial 
        begin
            $dumpfile("counter_tb.vcd");
			$dumpvars(0,counter_tb);

               
            // Initialize Inputs
            clk_tb = 0; 
                    
            // create input clock 100Hz
            for (i = 0; i < 200; i = i + 1) 
                #5 clk_tb = ~clk_tb;
                

        end
    
    // test cases

    initial
        begin
            clear_tb = 1;

            #100 clear_tb = 0; // novo input válido

            #100 clear_tb = 1;

        end
        
endmodule
