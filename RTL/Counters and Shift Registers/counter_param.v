module cnt_param #(
    parameter WIDTH = 4
)(
    input   wire                clk,
    input   wire                rst,
    input   wire                en,
    input   wire                dir,
    input   wire                load,
    input   wire    [WIDTH-1:0] data_in,
    output  reg     [WIDTH-1:0] q,
    output  wire                max,
    output  wire                min
);
    always @(posedge clk or posedge rst) begin
        if(rst) q <= {WIDTH{1'b0}};
        else if(load) q <= data_in;
        else if(en) begin
            if(dir == 1'b1) q <= q + 1'b1;
            else q <= q - 1'b1;
        end
    end

    assign max = (q == {WIDTH{1'b1}});
    assign min = (q == {WIDTH{1'b0}});

endmodule