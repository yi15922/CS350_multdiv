module div(data_operandA, data_operandB, ctrl_DIV, clock, 
            data_result, data_exception, data_resultRDY); 

    input [31:0] data_operandA, data_operandB;
    input ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;



    always @(data_resultRDY) begin
        #5; 
        $display("result: %b, exception: %b, ready: %b", data_result, data_exception, data_resultRDY); 
    end
    wire w_exceptionCheck; 
    assign w_exceptionCheck = |data_operandB; 
    assign data_exception = !w_exceptionCheck; 
endmodule