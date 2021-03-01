`timescale 1ns/100ps
module multControl_tb(); 
    reg clock = 0; 
    always
        #20 clock = !clock; 



    wire add, sub, shiftMultiplicand, shiftProduct, ready; 
    reg start;
    wire [2:0] data_in; 

    multControl control(add, sub, shiftMultiplicand, shiftProduct, ready, data_in, clock, start); 

    assign data_in = 000; 

    initial begin 
        assign start = 1; 
        #40; 
        assign start = 0; 

        #3000; 
        $finish; 

    end

endmodule
