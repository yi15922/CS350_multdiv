module div(data_operandA, data_operandB, ctrl_DIV, clock, 
            data_result, data_exception, data_resultRDY); 

    input [31:0] data_operandA, data_operandB;
    input ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire add, shiftQuotient, Q0, aluOp, throwAway1, throwAway2, throwAway3; 
    wire [64:0] w_regInput, w_finalQuotient, w_shiftQuotientOut, w_unshiftedQuotient; 
    wire [31:0] aluResult; 

    assign w_finalQuotient[31:1] = w_shiftQuotientOut[31:1]; 
    assign w_finalQuotient[63:32] = data_resultRDY ? w_shiftQuotientOut[63:32] : aluResult; 
    
    assign w_shiftQuotientOut = shiftQuotient ? (w_unshiftedQuotient << 1) : w_unshiftedQuotient; 
    assign w_finalQuotient[0] = Q0; 

    assign aluOp = add ? 0 : 1; 

    divControl controller(add, shiftQuotient, data_resultRDY, Q0, w_unshiftedQuotient[63], clock, ctrl_DIV); 
    register65 quotientRegister(w_unshiftedQuotient, clock, 1'b1, 1'b0, w_regInput); 
    alu ALU(w_shiftQuotientOut[63:32], data_operandB, aluOp, 0, aluResult, throwAway1, throwAway2, throwAway3); 

    wire [64:0] initialRegInput; 
    assign initialRegInput[31:0] = data_operandA; 
    assign initialRegInput[64:32] = 33'b0; 
    assign w_regInput = ctrl_DIV ? initialRegInput : w_finalQuotient; 

    always @(w_unshiftedQuotient)begin
        #5; 
        $display("unshiftedQuotient: %b, shiftQuotientOut: %b, ready: %b, finalQuotient: %b", w_unshiftedQuotient, w_shiftQuotientOut, data_resultRDY, w_finalQuotient); 
    end
    wire w_exceptionCheck; 
    assign w_exceptionCheck = |data_operandB; 
    assign data_exception = !w_exceptionCheck; 
    assign data_result = w_unshiftedQuotient[31:0]; 
endmodule