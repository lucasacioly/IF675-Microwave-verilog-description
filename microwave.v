`include "BCD_encoder/contador/counter.v"
`include "BCD_encoder/encoder/encoder.v"
`include "BCD_encoder/frequency_divider/fdivider.v"
`include "BCD_encoder/mux/mux.v"

`include "CONTROLE/magnetron/magnetron_logic.v"
`include "CONTROLE/latch/latch_SR.v"

`include "TIMER/counter_mod_6/mod6.v"
`include "TIMER/counter_mod_10/mod10.v"


module microwave(
    input wire [9:0] keys,
    input wire startn, stopn, clearn, door_closed, clock,
    output wire mag_on,
    output wire [6:0] ssec_ones,
    output wire [6:0] ssec_tens,
    output wire [6:0] smin
);

    // fios auxiliares
    wire timer_done_wire;
    wire [3:0] min_wire, sec_tens_wire, sec_ones_wire;
    wire mag_on_wire;
    wire loadn_wire;
    wire [3:0] digit_carrier;
    wire clock_carrier;

    assign mag_on = mag_on_wire; // saída do estado do magnetron

    // conexões
    magnetron_control mag_control(
        //inputs
        .startn(startn),
        .stopn(stopn), 
        .clearn(clearn),
        .door_closed(door_closed),
        .timer_done(timer_done_wire),
        //outputs
        .Q(mag_on_wire)
    );

    c_input keypad(
        //inputs
        .keys(keys),
        .enable(mag_on_wire), 
        .clock(clock),
        //outputs
        .Digit(digit_carrier),
        .loadn(loadn_wire), 
        .pgt_out(clock_carrier)
    );

    timer timer1(
        //inputs
        .clearn(clearn), 
        .loadn(loadn_wire),
        .clock(clock_carrier),
        .enable(mag_on_wire),
        .data(digit_carrier),
        //outputs
        .sec_ones(sec_ones_wire), 
        .sec_tens(sec_tens_wire),
        .mins(min_wire),
        .zero(timer_done_wire)
    );

    decB2SSD decoder(
        //inputs
        .bsec_ones(sec_ones_wire),
        .bsec_tens(sec_tens_wire),
        .bmin(min_wire),
        //outputs
        .ssec_ones(ssec_ones),
        .ssec_tens(ssec_tens),
        .smin(smin)

    );

endmodule

// módulos auxiliares

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

module c_input(
    input wire [9:0] keys,
    input wire enable, clock,
    output wire [3:0] Digit,
    output wire loadn, pgt_out
 );

    // fios auxiliares
    wire f_carry, delay;

    // conexões

    fdivider fdivider1(
        //inputs
        .clk_in(clock),
        //outputs
        .clk_out(f_carry)
    );

    encoder encoder1(
        //inputs
        .keys(keys),
        .en(enable),
        //outputs
        .loadn(loadn),
        .D(Digit)
    );

    counter counter1(
        //inputs
        .clk(clock),
        .clear(loadn),
        //outputs
        .delay(delay)
    );

    mux mux1(
        //inputs
        .cont(delay),
        .div(f_carry),
        .sel(enable),
        //outputs
        .pgt(pgt_out)
    );

endmodule

module magnetron_control (
    input wire startn, stopn, clearn, door_closed, timer_done, 
    output wire Q);

    wire s, r;

    magnetron_logic L1 (.startn(startn), 
                    .stopn(stopn),
                    .clearn(clearn),
                    .door_closed(door_closed),
                    .timer_done(timer_done),
                    .s(s), 
                    .r(r));
    
    
    latch_SR L2 (.S(s), 
                 .R(r),
                 .Q(Q)); 

endmodule

module timer(
    input wire clearn, loadn, clock, enable,
    input wire [3:0] data,
    output wire [3:0] sec_ones, sec_tens, mins,
    output wire zero
 ); 

    // fios auxiliaes
    wire zero_ones, zero_tens, zero_mins;
    wire en_sec_tens, en_mins;

    mod10 seconds_ones(
        //inputs
        .clearn(clearn),
        .loadn(loadn),
        .clock(clock),
        .en(enable),
        .data(data),
        //outputs
        .ones(sec_ones),
        .tc(en_sec_tens),
        .zero(zero_ones)
    );

    mod6 seconds_tens(
        //inputs
        .clearn(clearn),
        .loadn(loadn),
        .clock(clock),
        .en(en_sec_tens),
        .data(sec_ones),
        //outputs
        .tens(sec_tens),
        .tc(en_sec_mins),
        .zero(zero_tens)
    );

    mod10 minutes_ones(
        //inputs
        .clearn(clearn),
        .loadn(loadn),
        .clock(clock),
        .en(en_sec_mins),
        .data(sec_tens),
        //outputs
        .ones(mins),
        .zero(zero_mins)
    );

    assign zero = zero_ones && zero_tens && zero_mins;

endmodule