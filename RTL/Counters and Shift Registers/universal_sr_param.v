module uni_sr_param #(
    parameter WIDTH = 4
)(
    input   wire    [1:0]       sel,
    input   wire                rst,
    input   wire                en,
    input   wire                clk,
    input   wire    [WIDTH-1:0] p_in, //p_in[WIDTH-1] serial_in shift_right, p_in[0] serial_in shift_left
    output  reg     [WIDTH-1:0] q
);

    always @(posedge clk or posedge rst) begin
        if(rst) q <= 0;
        else if(en) begin
            case (sel)  
                2'b01   :   q <= {q[WIDTH-2:0], p_in[0]}; //shift left
                2'b10   :   q <= {p_in[WIDTH-1], q[WIDTH-1:1]}; //shift right
                2'b11   :   q <= p_in;
                default: q <= q;
            endcase
        end
    end
endmodule