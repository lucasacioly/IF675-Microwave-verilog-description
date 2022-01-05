`timescale 1ns/1ns
`include "decB2SSD.v"

module decB2SSD_tb();
    
    reg [3:0] bsec_ones_tb;
    reg [3:0] bsec_tens_tb;
    reg [3:0] bmin_tb;
    wire [6:0] ssec_ones_tb;
    wire [6:0] ssec_tens_tb;
    wire [6:0] smin_tb;
    integer i;

    decB2SSD uut(
        .bsec_ones(bsec_ones_tb),
        .bsec_tens(bsec_tens_tb),
        .bmin(bmin_tb),
        .ssec_ones(ssec_ones_tb),
        .ssec_tens(ssec_tens_tb),
        .smin(smin_tb)
        );
    
    initial begin
        $dumpfile("decB2SSD_tb.vcd");
        $dumpvars(0,decB2SSD_tb);

        for(i = 0;i < 12;i = i+1) //run loop for 0 to 11.
        begin
            bsec_ones_tb = i; bsec_tens_tb = i; bmin_tb = i; 
            #10;
        end

        // testes para zeros à esquerda
        #10 bmin_tb = 2; bsec_tens_tb = 5; bsec_ones_tb = 0;
        #10 bmin_tb = 1; bsec_tens_tb = 0; bsec_ones_tb = 0;
        #10 bmin_tb = 1; bsec_tens_tb = 0; bsec_ones_tb = 6;

        //minutos aagados
        #10 bmin_tb = 0; bsec_tens_tb = 3; bsec_ones_tb = 0;

        // minuto e desenas dos segundos aagados
        #10 bmin_tb = 0; bsec_tens_tb = 0; bsec_ones_tb = 7;

        //visor completamente apagado
        #10 bmin_tb = 0; bsec_tens_tb = 0; bsec_ones_tb  = 0; 
        #10;

    end

endmodule