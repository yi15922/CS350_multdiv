module multControl(add, sub, shiftMultiplicand, shiftProduct, ready, data_in, clock, start);
    input [2:0] data_in; 
    input clock, start; 
    output add, sub, shiftMultiplicand, shiftProduct, ready; 

    wire [64:0] w_countdown;

    wire [31:0] w_throwAway1, w_incrementResult; 
    wire w_continue, w_throwAway2, w_throwAway3, w_throwAway5, w_throwAway6, w_throwAway7; 

    alu addToCountdown(w_countdown[31:0], 32'd1, 0, 0, w_incrementResult, w_throwAway5, w_throwAway6, w_throwAway7); 
    register65 countdown(w_countdown, clock, !ready, start, w_incrementResult); 

    wire w_notEqual; 
    alu checkCountdown(w_countdown[31:0], 32'd32, 1, 0, w_throwAway1, w_notEqual, w_throwAway2, w_throwAway3); 

    assign ready = !w_notEqual; 



    // always @(w_countdown, ready, start) begin
    //     #5; 
    //     $display("counter: %d, ready: %b, start: %b", w_countdown, ready, start); 
    // end

endmodule