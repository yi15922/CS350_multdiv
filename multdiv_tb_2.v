`timescale 1ns/100ps
module multdiv_tb_2(); 



    wire [31:0] data_operandA, data_operandB, data_result; 
    wire data_exception, data_resultRDY; 
    reg ctrl_MULT;
    reg ctrl_DIV; 

    reg clock = 0; 
    always
        #20 clock = !clock; 

    multdiv multDiv(data_operandA, data_operandB, ctrl_MULT, 1'b0, clock, data_result, data_exception, data_resultRDY); 

    assign data_operandA = 3; 
    assign data_operandB = 0; 
    wire [31:0] w_xor; 
    assign w_xor = 111111111111111100110011001100110; 
    wire w_result; 
    assign w_result = ^w_xor; 

    initial begin 
        assign ctrl_DIV = 1; 
        assign ctrl_MULT = 0; 
        #40; 
        assign ctrl_DIV = 0; 
        //$display("XOR: %b, result: %b", w_xor, w_result); 


        #3000; 
        $finish; 

    end

    

    // always @(data_resultRDY) begin
    //     #5; 
    //     $display("result: %b, exception: %b, ready: %b", data_result, data_exception, data_resultRDY); 
    // end

endmodule
