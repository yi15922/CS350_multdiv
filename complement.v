module complement(data_out, data_in); 
    input [31:0] data_in; 
    output [31:0] data_out; 

    wire throwaway; 
    adder_32 subtractFrom0(data_out, throwaway, 1, ~data_in, 1'b0); 

endmodule