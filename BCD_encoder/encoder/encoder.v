module encoder (
    input wire [9:0] keys,
    input wire en,
    output reg loadn,
    output reg [3:0] D
);

    // OBS:
    // keypad -> entradas do keypad
    // en -> entrada enable
    // D -> código BCD gerado
    // loadn -> indica se a entrada é válida
    // loadn == 1 indica input inválido
    // loadn == 0 indica input válido e deve ser carregado no timer

    always @(*)
        begin
        if (en == 1'b1) // magnetron ligado

            begin
                D = 4'b0000; // nesse caso não importa o valor de de D
                loadn = 1'b1; // qualquer imput com magnetron ligado será inválido
            end

        else if (en == 1'b0) // magnetron desligado
            
            begin
                if (keys == 10'b0000000000) // nenhum digito pressionado
                    begin
                        D = 4'b0000; // nesse caso não importa o valor de de D
                        loadn = 1'b1; // não é input válido
                    end

                else if (keys == 10'b0000000001) // key 0
                    begin
                        D = 4'b0000; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0000000010) // key 1
                    begin
                        D = 4'b0001; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0000000100) // key 2
                    begin
                        D = 4'b0010; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0000001000) // key 3
                    begin
                        D = 4'b0011; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0000010000) // key 4
                    begin
                        D = 4'b0100; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0000100000) // key 5
                    begin
                        D = 4'b0101; 
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0001000000) // key 6
                    begin
                        D = 4'b0110;
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0010000000) // key 7
                    begin
                        D = 4'b0111;
                        loadn = 1'b0;
                    end

                else if (keys == 10'b0100000000) // key 8
                    begin
                        D = 4'b1000;
                        loadn = 1'b0;
                    end

                else if (keys == 10'b1000000000) // key 9
                    begin
                        D = 4'b1001;
                        loadn = 1'b0;
                    end 

                else // múltiplas chaves acionadas simultaneamente
                    begin
                        D = 4'b0000; // nesse caso não importa o valor de de D
                        loadn = 1'b1; // input inválido
                    end
            end
        end

endmodule
