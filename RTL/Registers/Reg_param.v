module reg_param #(
    parameter WIDTH = 8
)(
    input   wire                clk,
    input   wire                en,
    input   wire    [WIDTH-1:0] set,
    input   wire                rst,
    input   wire    [WIDTH-1:0] data_in,
    output  reg     [WIDTH-1:0] q,
    output  wire    [WIDTH-1:0] q_prime
);

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : dff_array
            always @(posedge clk or posedge rst or posedge set[i]) begin
                if (rst) q[i] <= 1'b0;
                else if (set[i]) q[i] <= 1'b1;
                else if (clk) q[i] <= data_in[i];
            end
        end
    endgenerate

    assign q_prime = ~q;

endmodule