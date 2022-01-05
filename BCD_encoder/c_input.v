
`include "contador/counter.v"
`include "encoder/encoder.v"
`include "frequency divider/fdivider.v"
`include "mux/mux.v"

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
