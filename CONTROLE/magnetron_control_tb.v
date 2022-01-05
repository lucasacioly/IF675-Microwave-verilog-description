`timescale 1us/1ps
`include "magnetron_control.v"

module magnetron_control_tb ();

    reg startn_TB, stopn_TB, clearn_TB, door_closed_TB, timer_done_TB;
    wire Q_TB;

      magnetron_control DUT(.Q(Q_TB),.startn(startn_TB),.stopn(stopn_TB),.clearn(clearn_TB),.door_closed(door_closed_TB),.timer_done(timer_done_TB));


    initial begin
        $dumpfile("magnetron_control_tb.vcd");
        $dumpvars(0,magnetron_control_tb);

      // simulação de funcionamento

      // no início, não há botões pressionados e a porta está aberta
          
        startn_TB = 1; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;

      // fecha-se a porta, rapidamente pressiona-se start e o timer é ativado
      #10 door_closed_TB = 1; startn_TB = 0; timer_done_TB = 0;

      #1 startn_TB = 1; // start solto

      #30 timer_done_TB = 1; // espera-se até que o timer termine a contágem

      // ------------------------------------------------------------------------------------------------

      // voltamos ao estado inicial
      #10 startn_TB = 1; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;

      // fecha-se a porta, rapidamente pressiona-se start e o timer é ativado
      #10 door_closed_TB = 1; startn_TB = 0; timer_done_TB = 0;

      #1 startn_TB = 1; // start solto

      // porta é aberta no meio da contágem
      #15 door_closed_TB = 0;

      // ------------------------------------------------------------------------------------------------

      // voltamos ao estado inicial
      #10 startn_TB = 1; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;

      // fecha-se a porta, rapidamente pressiona-se start e o timer é ativado
      #10 door_closed_TB = 1; startn_TB = 0; timer_done_TB = 0;

      #1 startn_TB = 1; // start solto

      //pausamos a contágem
      #15 stopn_TB = 0;
      #1 stopn_TB = 1;

      // ------------------------------------------------------------------------

      // voltamos ao estado inicial
      #10 startn_TB = 1; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;

      // fecha-se a porta, rapidamente pressiona-se start e o timer é ativado
      #10 door_closed_TB = 1; startn_TB = 0; timer_done_TB = 0;

      #1 startn_TB = 1; // start solto

      //clear pressionado
      #15 clearn_TB = 0;
      #1 clearn_TB = 1;

      // --------------------------------------------------------------------------

      // voltamos ao estado inicial
      #10 startn_TB = 1; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;

      // casos inválidos de tentativa de ligar  o magnetron "startn_TB = 1"
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 0; door_closed_TB = 0; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 0; door_closed_TB = 0; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 0; door_closed_TB = 1; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 0; door_closed_TB = 1; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 1; door_closed_TB = 1; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 0; clearn_TB = 1; door_closed_TB = 1; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 0; door_closed_TB = 0; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 0; door_closed_TB = 0; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 0; door_closed_TB = 1; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 0; door_closed_TB = 1; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 0;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 0; timer_done_TB = 1;
      #10 startn_TB = 0; stopn_TB = 1; clearn_TB = 1; door_closed_TB = 1; timer_done_TB = 1;
      
      #10;

    end 
endmodule