`timescale 1ns / 100ps
module cnt_param_tb;
reg         clk;
reg         rst;
reg         en;
reg         dir;
reg         load; //0 = cnt up 1 = cnt down
reg [3:0]   data_in;
wire[3:0]   q;
wire        max;
wire        min;
/*
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
*/

cnt_param #(
    .WIDTH  (4)
) uut (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .dir    (dir),
    .load   (load),
    .data_in(data_in),
    .q      (q),
    .max    (max),
    .min    (min)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, cnt_param_tb);
end

initial begin
    clk =       0;
    rst =       0;
    en =        0; //shouldn't change
    dir =       0; //count up
    load =      0;
    data_in =   0;

    #10
    rst = 1;
    #10
    rst = 0;
    #10
    en = 1;
    #10
    clk = 1;
    #10
    clk = 0;
    #10
    clk = 1;
    #10
    clk = 0;
    #10
    clk = 1;
    #10
    clk = 0; //should be set to 3
    #10
    rst = 1;
    #10
    rst = 0;
    #10
    en = 0;
    #10
    clk = 1;
    #10
    clk = 0;
    #10
    en = 1;
    load = 1;
    data_in = 4'b1110;
    #10
    clk = 1;
    #10
    clk = 0;
    load = 0;
    dir = 1;
    #10
    clk = 1;
    #10
    clk = 0;
    #10
    dir = 0;
    #10
    clk = 1;
    #10
    clk = 0;
    #10
    clk = 1;
    #10
    clk = 0;
    #50
    $display("Complete");
    #50
    $finish;
end

endmodule