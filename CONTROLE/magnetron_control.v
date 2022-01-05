
`include "magnetron/magnetron_logic.v"
`include "latch/latch_SR.v"


module magnetron_control (
    input wire startn, stopn, clearn, door_closed, timer_done, 
    output wire Q);

    wire s, r;

    magnetron_logic L1 (.startn(startn), 
                    .stopn(stopn),
                    .clearn(clearn),
                    .door_closed(door_closed),
                    .timer_done(timer_done),
                    .s(s), 
                    .r(r));
    
    
    latch_SR L2 (.S(s), 
                 .R(r),
                 .Q(Q)); 

endmodule