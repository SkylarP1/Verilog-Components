`timescale 1ns/100ps
module c_param_tb;
    parameter WIDTH = 2;
    parameter FAN_IN = 2;

    logic   [WIDTH-1:0][FAN_IN-1:0] x;
    logic   [WIDTH-1:0]             y;

    c_param #(
        .WIDTH(WIDTH),
        .FAN_IN(FAN_IN)
    )uut(
        .x  (x),
        .y  (y)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, c_param_tb);

        x = 0;

        for(int i = 0; i < 16; i++) begin
            x = i[3:0];
            #5
        end
        #5
        for(int i = 15; i >= 0; i--) begin
            x = i[3:0];
            #5
        end
        $finish;
    end
endmodule