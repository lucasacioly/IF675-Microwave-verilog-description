`timescale 1ms / 1ms
`include "microwave.v"

module microwave_tb3();
    // Inputs
    reg startn_tb, stopn_tb, clearn_tb, door_closed_tb, clock_tb;
    reg [9:0] keys_tb;

    // Outputs
    wire mag_on_tb;
    wire [6:0] ssec_ones_tb;
    wire [6:0] ssec_tens_tb;
    wire [6:0] smin_tb;
    
    // Instantiate the Unit Under Test (UUT)
    microwave DUT (.startn(startn_tb), .stopn(stopn_tb), .clearn(clearn_tb),
                    .door_closed(door_closed_tb), .clock(clock_tb), .keys(keys_tb),
                    .mag_on(mag_on_tb), .ssec_ones(ssec_ones_tb), .ssec_tens(ssec_tens_tb), .smin(smin_tb));
    
    integer i;
    
    // clock generator
    initial 
        begin
            $dumpfile("microwave_tb3.vcd");
			$dumpvars(0,microwave_tb3);

               
            // Initialize Inputs
            clock_tb = 0; 
                    
            // create input clock 100Hz
            for (i = 0; i < 30000; i = i + 1) 
                #5 clock_tb = ~clock_tb;
                

        end
    
    // test cases

    initial
        begin
            startn_tb = 0; stopn_tb = 1; clearn_tb = 1; door_closed_tb = 1;
            #1 stopn_tb = 0; 
            #1;
            // condição inicial nenhuma chave presisonada e porta fechada
            startn_tb = 1; stopn_tb = 1; clearn_tb = 1; door_closed_tb = 1;
            //insere o dígito 
            keys_tb = 10'b0001001000; // tenta carregar 3 e 6

            #50;  // solta as chaves


        end
        
endmodule
