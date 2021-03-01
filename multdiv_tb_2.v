`timescale 1ns/100ps
module multdiv_tb_2(); 



    wire [31:0] data_operandA, data_operandB, data_result; 
    wire ctrl_DIV, data_exception, data_resultRDY; 
    reg ctrl_MULT;

    reg clock = 0; 
    always
        #20 clock = !clock; 

    multdiv multDiv(data_operandA, data_operandB, ctrl_MULT, 1'b0, clock, data_result, data_exception, data_resultRDY); 

    assign data_operandA = 2; 
    assign data_operandB = -4; 

    initial begin 
        assign ctrl_MULT = 1; 
        #40; 
        assign ctrl_MULT = 0; 

        #3000; 
        $finish; 

    end

    

    // always @(data_resultRDY) begin
    //     #5; 
    //     $display("result: %b, exception: %b", data_result, data_exception); 
    // end

endmodule