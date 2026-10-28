module c_param #(
    parameter WIDTH = 4, //How many c-elements there are
    parameter FAN_IN = 2 //How many inputs each c-elements each have
)(
    input   logic   [WIDTH-1:0][FAN_IN-1:0] x,
    output  logic   [WIDTH-1:0]             y
);

    genvar i;

    generate
        for(i=0; i < WIDTH; i = i + 1) begin : ce_gen
            always_comb begin : c_elem
               y[i] = (&x[i]) | y[i] & (|x[i]); 
            end
        end
    endgenerate
endmodule