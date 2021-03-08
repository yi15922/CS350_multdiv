`timescale 1ns/100ps
module divControl_tb(); 
    reg clock = 0; 
    always
        #20 clock = !clock; 



    wire add, sub, shiftQuotient, ready, nop, Q0; 
    reg start;
    reg MSB = 0; 
    assign Q0 = 0; 

    divControl control(add, sub, shiftQuotient, nop, ready, Q0, MSB, clock, start); 

    //assign data_in = 000; 

    initial begin 
        assign start = 1; 
        #40; 
        assign start = 0; 

        #3000; 
        $finish; 

    end

    // always
    //     #10 data_in[0] = !data_in[0]; 
    // always
    //     #20 data_in[1] = !data_in[1]; 
    // always
    //     #40 data_in[2] = !data_in[2]; 

    

    // always @(clock) begin
    //     #5; 
    //     $display("ready: %b", ready); 
    // end

endmodule
