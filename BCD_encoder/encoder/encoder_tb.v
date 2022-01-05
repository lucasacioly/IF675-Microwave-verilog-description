`timescale 1ns/1ns
`include "encoder.v"


module encoder_tb();

	reg [9:0] keypad_tb;
    reg en_tb;
	wire [3:0] D_tb;
    wire loadn_tb;

	encoder DUT(.keys(keypad_tb), .en(en_tb), .D(D_tb), .loadn(loadn_tb));

	initial
		begin
		
			$dumpfile("encoder_tb.vcd");
			$dumpvars(0,encoder_tb);


            // casos inválidos

            // magnetron ligado
            en_tb = 1; keypad_tb = 10'b0000000000;
            #10 en_tb = 1; keypad_tb = 10'b0000001110;
            #10 en_tb = 1; keypad_tb = 10'b0001000000;
            #10 en_tb = 1; keypad_tb = 10'b0000000100;
            #10 en_tb = 1; keypad_tb = 10'b0101010101;
            #10 en_tb = 1; keypad_tb = 10'b1001000101;
            #10 en_tb = 1; keypad_tb = 10'b0111000000;

            // nenhuma chave pressionada e magnetron desligado
            #10 en_tb = 0; keypad_tb = 10'b0000000000;

            // magnetron desligado e multiplas chaves pressionadas
            #10 en_tb = 0; keypad_tb = 10'b0000000011;
            #10 en_tb = 0; keypad_tb = 10'b1000100001;
            #10 en_tb = 0; keypad_tb = 10'b0010000011;
            #10 en_tb = 0; keypad_tb = 10'b1000001111;
            #10 en_tb = 0; keypad_tb = 10'b1111111111;

            // casos válidos 
            #10 en_tb = 0; keypad_tb = 10'b0000000001; // keypad 0
            #10 en_tb = 0; keypad_tb = 10'b0000000010; // keypad 1
            #10 en_tb = 0; keypad_tb = 10'b0000000100; // keypad 2
            #10 en_tb = 0; keypad_tb = 10'b0000001000; // keypad 3
            #10 en_tb = 0; keypad_tb = 10'b0000010000; // keypad 4
            #10 en_tb = 0; keypad_tb = 10'b0000100000; // keypad 5
            #10 en_tb = 0; keypad_tb = 10'b0001000000; // keypad 6
            #10 en_tb = 0; keypad_tb = 10'b0010000000; // keypad 7
            #10 en_tb = 0; keypad_tb = 10'b0100000000; // keypad 8
            #10 en_tb = 0; keypad_tb = 10'b1000000000; // keypad 9

            #10;
		end

endmodule
