module lu_param (
    parameter BITS = 8
)(
    input   wire    [BITS-1:0]  a;
    input   wire    [BITS-1:0]  b;
    input   wire    [2:0]       opcode;
    output  reg                 out;
);
    always @(*) begin
        case(opcode)
            3'b000  :   out = a & b;
            3'b001  :   out = a | b;
            3'b010  :   out = a ^ b;
            3'b011  :   out = ~(a&b);
            3'b100  :   out = ~(a | b);
            3'b101  :   out = ~(a ^ b);
            3'b110  :   out = ~a;
            3'b111  :   out = ~b;
            default :   out = {BITS{1'b0}};
        endcase
    end
endmodule