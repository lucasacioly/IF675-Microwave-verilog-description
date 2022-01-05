`timescale 1ms / 1ms
`include "mod6.v"

module mod6_tb();
    // Inputs
    reg clock_tb, clearn_tb, loadn_tb, en_tb;
    reg [3:0] data_tb;

    // Outputs
    wire [3:0] tens_tb;
    wire tc_tb, zero_tb;
    
    // Instantiate the Unit Under Test (UUT)
    mod6 DUT (.clock(clock_tb), .clearn(clearn_tb), .loadn(loadn_tb), .en(en_tb),
                .data(data_tb), .tens(tens_tb), .tc(tc_tb), .zero(zero_tb));
    
    integer i;
    
    // clock generator
    initial 
        begin
            $dumpfile("mod6_tb.vcd");
			$dumpvars(0,mod6_tb);

               
            // Initialize Inputs
            clock_tb = 0; 
                    
            // create input clock 1Hz
            for (i = 0; i < 200; i = i + 1) 
                #500 clock_tb = ~clock_tb;
                

        end
    
    // test cases

    initial
        begin
            
            // teste simples
            //carregamento

            clearn_tb = 1; // botão clear solto
            en_tb = 0; // magnetron desligado

            // carregar digito 
            loadn_tb = 0;
            data_tb = 7;
            #1000 loadn_tb = 1;

            #9000;

            // iniciar contagem regressiva
            en_tb = 1;

            #15000;

            // pausar contagem

            en_tb = 0;

            #5000;

            //limpar cronometro

            clearn_tb = 0;

            #5000;

            clearn_tb = 1;


            // reiniciar contagem

            en_tb = 1;

            #15000;

            // pausar cronometro
    
            en_tb = 0;

        end
        
endmodule
