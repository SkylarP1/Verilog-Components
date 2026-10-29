module sd_wire #(
    parameter WIDTH = 4
)(
    input   logic   [WIDTH-1:0]     x,
    output  logic   [(WIDTH*2)-1:0] y
);

    genvar i;

    generate
        for(i = 0; i < WIDTH; i++) begin
            assign y[(i*2)+1:(i*2)] = {x[i], ~x[i]};
        end
    endgenerate

endmodule
