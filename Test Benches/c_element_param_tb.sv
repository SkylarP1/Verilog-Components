`timescale 1ns/100ps
module c_param_tb;
    parameter WIDTH = 2;
    parameter FAN_IN = 2;

    logic   [WIDTH-1:0][FAN_IN-1:0] x;
    logic   [WIDTH-1:0]             y;

    initial begin
            
    end