module magnetron_logic (
    input wire startn, stopn, clearn, door_closed, timer_done, 
    output reg s, r);

    //obs: startn == 0, botão de ligar pressionado
    //stopn == 0, botão de pausar pressionado
    //clearn == 0, botão de limpar pressionado
    //door_closed == 0, porta está aberta
    //timer_done == 1, o cronômetro não está em operação

    always @ * begin
        //magnetron = 0 se a porta estiver aberta ou se stop, clear ou o timer estiverem ativos
        if (!door_closed || !stopn || !clearn || timer_done) 
            begin
                s <= 1'b0;
                r <= 1'b1;
            end
        //magnetron = 1 se start estiver ativo e a porta fechada
        else if (!startn && door_closed) 
            begin
                s <= 1'b1;
                r <= 1'b0;
            end
        else 
            begin  
                s <= 1'b0;
                r <= 1'b0;
            end
    end

endmodule