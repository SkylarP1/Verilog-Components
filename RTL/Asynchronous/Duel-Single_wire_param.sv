module ds_wire #(
    parameter WIDTH = 4
)(
    input   logic   [(WIDTH*2)-1:0]     x,
    output  logic   [(WIDTH-1):0]       y,
    output  logic   [(WIDTH-1):0]       y_hat
);

generate
    for(int i = 0; i < WIDTH; i++) begin
        assign y[i] = (^x[((i*2)+1):(i*2)]) & x[(i*2)];
        assign y_hat[i] = (^x[((i*2)+1):(i*2)]) & x[(i*2)+1];
    end
endgenerate

endmodule
