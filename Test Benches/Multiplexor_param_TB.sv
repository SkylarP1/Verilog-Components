`timescale 1ns / 1ps
module multiplexor_param_tb;
reg [3:0]   a;
reg [3:0]   b;
reg [3:0]   c;
reg [3:0]   d;
reg         en;
reg [1:0]   sel;
wire[3:0]   out;

/*module multiplexor #(
    parameter BITS,
    parameter WIDTH
)(
    input   [(BITS*WIDTH)-1:0]  data,
    input   [WIDTH-1:0] sel,
    input               en,
    output  [BITS-1:0]  out
);
*/


wire [15:0] data;
assign data = {d,c,b,a};


mux #(
    .WIDTH   (4),
    .SELECT  (2)
)uut(
    .data_in   (data),
    .sel    (sel),
    .en     (en),
    .data_out    (out)
);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, multiplexor_param_tb);
end

initial begin
    a =     4'b0000;
    b =     4'b0000;
    c =     4'b0000;
    d =     4'b0000;
    sel =   2'b00;
    en =    1'b0;

    #20
    a =     4'b0001;
    b =     4'b0010;
    c =     4'b0100;
    d =     4'b1000;
    #20
    en =    1'b1;
    #20
    sel =   2'b01;
    #20
    sel =   2'b10;
    #20
    sel =   2'b11;
    #20
    en =    1'b0;
    #50
    #50
    $display("Complete");
    $finish;
end



endmodule