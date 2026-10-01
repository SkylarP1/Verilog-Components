`timescale 1ns / 100ps
module lu_param_tb;

reg [3:0]   a;
reg [3:0]   b;
reg [2:0]   opcode;
wire[3:0]   out;

/*
module lu_param (
    parameter BITS = 8
)(
    input   wire    [BITS-1:0]  a;
    input   wire    [BITS-1:0]  b;
    input   wire    [2:0]       opcode;
    output  reg                 out;
);
*/

lu_param #(
    .BITS   (4)
)uut(
    .a      (a),
    .b      (b),
    .opcode (opcode),
    .out    (out)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, lu_param_tb);
end

initial begin
    a =         4'b0000;
    b =         4'b0000;
    opcode =    3'b000;

    #20
    a =         4'b1010;
    b =         4'b0111;
    #20
    opcode =    3'b001;
    #20
    opcode =    3'b010;
    #20
    opcode =    3'b011;
    #20
    opcode =    3'b100;
    #20
    opcode =    3'b101;
    #20
    opcode =    3'b110;
    #20
    opcode =    3'b111;

    #50
    $display("Complete");
    #50
    $finish;
end

endmodule