// contador decrescente modulo 10
module mod6(
    input wire clearn, loadn, clock, en,
    input wire [3:0] data,
    output wire [3:0] tens, 
    output wire tc, zero); 
    
    // OBS:
    // data -> entrada de código BCD
    // clock -> entrada do clock 
    // loadn -> linha de controle de carga -> ativo em nível BAIXO
    // en -> entrada enable (habilitação) -> ativo em nível ALTO
    // clearn -> entrada de reset -> ativo em nível BAIXO
    // ones -> saída de código BCD
    // zero -> saída indicando que o contador chegou a zero
    // tc -> indicar quando o dígito do contador está no valor mínimo (0)
            // nesse caso TC vai para 1 e ativa o proximo contador
    

    reg [3:0] counter; // contador auxiliar para cíclos do relógio

    wire [3:0] next;
    
    always @(posedge clock, negedge clearn)
        begin
            
            // limpa o cronometro
            // caso o magnetron esteja desligado, apenas limpará o visor
            // caso esteja ligado, também encerrará a operação
            if (clearn == 1'b0)
                begin
                    counter <= 0;
                end

            else
                // se o magnetron está desligado, é possível carregar o dígito
                if (en == 1'b0)
                    begin
                        if (loadn == 1'b0)
                            begin
                                counter <= data;
                            end
                    end
                else 
                    begin
                        if (counter == 0) // magnetron ligado, iniciar contagem regressiva
                            begin
                                counter <= 5; // note que aqui o limite superior é 5
                                // nesse caso, pode ser carregado inicialmente um número maior que 5
                                // mas, a cada cíclo de contagem sempre retornaremos ao 5 e contaremos até o 0
                            end
                        else
                            begin
                                counter <= next;
                            end
                        
                    end 
        end

    
    assign next = counter - 1;

    // quando contador chegar a zero e o cronometro estiver ativo fazer a indicação em TC
    assign tc = ((counter == 0) && (en == 1'b1)) ? 1'b1 : 1'b0;

    // quando contador chegar a zero fazer a indicação em ZERO
    assign zero = (counter == 0) ? 1'b1 : 1'b0;

    // disponibilizar o valor atual da contagem na saída
    assign tens = counter;


endmodule