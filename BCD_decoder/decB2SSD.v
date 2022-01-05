module decB2SSD(bsec_ones, bsec_tens, bmin, ssec_ones, ssec_tens, smin);

     //inputs/outputs 
    input [3:0] bsec_ones;
    input [3:0] bsec_tens;
    input [3:0] bmin;
    output reg [6:0] ssec_ones;
    output reg [6:0] ssec_tens;
    output reg [6:0] smin;

    // bcd to seven_segments decoder, segments are active-high

    //bloco always para converter os bcd's em SSD's
    always @(bsec_ones, bsec_tens, bmin)
    begin

        case (bmin) //case statement
            0 : smin = 7'b0000000; // apaga sempre que for 0
            1 : smin = 7'b0110000;
            2 : smin = 7'b1101101;
            3 : smin = 7'b1111001;
            4 : smin = 7'b0110011;
            5 : smin = 7'b1011011;
            6 : smin = 7'b0011111;
            7 : smin = 7'b1110000;
            8 : smin = 7'b1111111;
            9 : smin = 7'b1110011;
            //caso nao receba nenhuma dígito decimal desliga todos os segmentos.
            default : smin = 7'b0000000; 
        endcase

        case (bsec_ones) //case statement
            0 : ssec_ones = 7'b1111110;
            1 : ssec_ones = 7'b0110000;
            2 : ssec_ones = 7'b1101101;
            3 : ssec_ones = 7'b1111001;
            4 : ssec_ones = 7'b0110011;
            5 : ssec_ones = 7'b1011011;
            6 : ssec_ones = 7'b0011111;
            7 : ssec_ones = 7'b1110000;
            8 : ssec_ones = 7'b1111111;
            9 : ssec_ones = 7'b1110011;
            //caso nao receba nenhuma dígito decimal desliga todos os segmentos.
            default : ssec_ones = 7'b0000000; 
        endcase

        case (bsec_tens) //case statement
            0 : ssec_tens = 7'b1111110;
            1 : ssec_tens = 7'b0110000;
            2 : ssec_tens = 7'b1101101;
            3 : ssec_tens = 7'b1111001;
            4 : ssec_tens = 7'b0110011;
            5 : ssec_tens = 7'b1011011;
            6 : ssec_tens = 7'b0011111;
            7 : ssec_tens = 7'b1110000;
            8 : ssec_tens = 7'b1111111;
            9 : ssec_tens = 7'b1110011;
            //caso nao receba nenhuma dígito decimal desliga todos os segmentos.
            default : ssec_tens = 7'b0000000; 
        endcase

        // teste para zeros à esquerda
        if ((bmin == 0) && (bsec_tens == 0))
            begin
                ssec_tens = 7'b0000000;

                if (bsec_ones == 0)
                    begin
                        ssec_ones = 7'b0000000;
                    end
            end
    end


    //repetindo para todos os casos

endmodule
