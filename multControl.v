module multControl(add, sub, shiftMultiplicand, shiftProduct, nop, ready, data_in, clock, start);
    input [2:0] data_in; 
    input clock, start; 
    output add, sub, shiftMultiplicand, shiftProduct, nop, ready; 

    wire [64:0] w_countdown;

    wire [31:0] w_throwAway1, w_incrementResult; 
    wire w_continue, w_throwAway2, w_throwAway3, w_throwAway5, w_throwAway6, w_throwAway7; 

    alu addToCountdown(w_countdown[31:0], 32'd1, 5'b0, 5'b0, w_incrementResult, w_throwAway5, w_throwAway6, w_throwAway7); 
    register65 countdown(w_countdown, clock, !ready, start, w_incrementResult); 

    // Since we are shifting multiplicand 2 bits at a time, only need to shift 16 times
    wire w_notEqual; 
    alu checkCountdown(w_countdown[31:0], 32'd16, 5'b1, 5'b0, w_throwAway1, w_notEqual, w_throwAway2, w_throwAway3); 

    assign ready = !w_notEqual; 
    assign shiftProduct = !ready;

    assign add = !data_in[2] && (data_in[1] || data_in[0]); 
    assign sub = data_in[2] && (!data_in[1] || !data_in[0]); 
    assign shiftMultiplicand = (!data_in[2] && data_in[1] && data_in[0]) || (data_in[2] && !data_in[1] && !data_in[0]); 
    assign nop = !add && !sub;


    // always @(w_countdown, ready, start) begin
    //     #5; 
    //     $display("counter: %d, dataIn: %b", w_countdown, data_in); 
    // end

endmodule