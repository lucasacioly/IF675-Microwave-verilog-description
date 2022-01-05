module latch_SR (S, R, Q);

	input S;
	input R;
	output reg Q;
    
    always @ (*) begin
		//se S e R forem iguais a 0 a saída será o Q anterior
        if (!S && !R) begin
            Q <= Q; 
        end

        else if (!S && R) begin 
            Q <= 1'b0; 
        end

        else if (S && !R) begin
            Q <= 1'b1;
        end 
    end
endmodule