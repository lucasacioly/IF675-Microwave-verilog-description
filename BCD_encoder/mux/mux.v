module mux (
            input wire cont, div, sel,
            output reg pgt);

// OBS:
// sel -> chave de seleção que recebe sinla do enable
// cont -> entrada do mux que recebe saída do contador não reciclavel
// div -> entrada do mux que recebe saída do divisor do clock
// pgt_1Hz -> positive going trasition passada para o cronômetro

    always @(sel, div, cont) begin
        
        if (sel == 1'b1) //magnetron ligado
            pgt = div; // saida de positive going transition contínua em 1 Hz
        
        else if (sel == 1'b0)// magnetron desligado
            pgt = cont;
        
    end

    
endmodule
