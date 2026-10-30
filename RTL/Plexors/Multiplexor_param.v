module multiplexor #(
    parameter BITS = 1,
    parameter WIDTH = 1
)(
    input   [(BITS*(1 << WIDTH))-1:0]  data,
    input   [WIDTH-1:0] sel,
    input               en,
    output  [BITS-1:0]  out
);
    wire [BITS-1:0] data2d[(1<<WIDTH)-1:0];

    genvar i;
    generate
        for(i=0; i < (1<<WIDTH); i = i + 1) begin : data1to
            assign data2d[i] = data[(i*BITS) +: BITS];
        end
    endgenerate

    assign out = en ? data2d[sel]:{BITS{1'b0}};

endmodule