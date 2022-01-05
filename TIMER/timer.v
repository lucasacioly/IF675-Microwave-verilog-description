
`include "counter mod 6/mod6.v"
`include "counter mod 10/mod10.v"

module timer(
    input wire clearn, loadn, clock, enable,
    input wire [3:0] data,
    output wire [3:0] sec_ones, sec_tens, mins,
    output wire zero
); 

// fios auxiliaes
wire zero_ones, zero_tens, zero_mins;
wire en_sec_tens, en_mins;

mod10 seconds_ones(
    //inputs
    .clearn(clearn),
    .loadn(loadn),
    .clock(clock),
    .en(enable),
    .data(data),
    //outputs
    .ones(sec_ones),
    .tc(en_sec_tens),
    .zero(zero_ones)
);

mod6 seconds_tens(
     //inputs
    .clearn(clearn),
    .loadn(loadn),
    .clock(clock),
    .en(en_sec_tens),
    .data(sec_ones),
    //outputs
    .tens(sec_tens),
    .tc(en_sec_mins),
    .zero(zero_tens)
);

mod10 minutes_ones(
     //inputs
    .clearn(clearn),
    .loadn(loadn),
    .clock(clock),
    .en(en_sec_mins),
    .data(sec_tens),
    //outputs
    .ones(mins),
    .zero(zero_mins)
);

assign zero = zero_ones && zero_tens && zero_mins;

endmodule