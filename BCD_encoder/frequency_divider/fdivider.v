module fdivider(
    input wire clk_in, // entrada do clock em 100Hz
    output clk_out); // saida do clock em 1Hz

    reg [6:0] counter = 0; // contador auxiliar para cíclos do relógio

    always @(posedge clk_in)
        begin
            // incrementa o contador em toda borda positiva de clk_in
            counter <= counter + 1;  

            // testa condição de reset do contador (100 cíclos de clock)
            if (counter >= 99)
                begin
                    counter <= 0;    
                end
        end

    // saída de clk associada ao contador de cíclos 
    assign clk_out = (counter < 50) ? 0 : 1;

endmodule