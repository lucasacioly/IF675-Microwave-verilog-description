module counter(
    input wire clk, clear,  
    output reg delay); 
    
    // OBS:
    // clk -> entrada do clock = 100Hz
    // clear -> sinal para limpar o contdor e recomeçar a contagem
    //          indica que uma nova chave válida foi pressionada no keypad
    //          clear é ativo em nível BAIXO
    // delay -> saída de borda positiva arasada.

    reg [2:0] counter = 0; // contador auxiliar para cíclos do relógio

    always @(posedge clk, negedge clear)
        begin

            // incrementa o contador em toda borda positiva de clk
            // contador é incrementado até 7
            // contador é zerado novamente apenas quando receber entrada clear
            if (counter < 7)
                begin
                    counter <= counter + 1;  
                end

            // teste de condição de saída de borda positiva
            if (counter >= 4)
                begin
                    delay <= 1;
                    // testa condição de reset do contador
                    if (clear) // foi entrado um input válido pelo teclado
                    begin
                        counter <= 0;
                    end
                end
            else
                begin
                    delay <= 0; // pode ser que seja delay <= clk
                end 
        end

endmodule