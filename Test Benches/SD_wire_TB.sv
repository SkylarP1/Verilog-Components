module sd_wire_tb;

    //parameter(s)
    parameter WIDTH = 4;

    //input(s)
    logic   [WIDTH-1:0]     x;

    //output(s)
    logic   [(WIDTH*2)-1:0] y;

    sd_wire #(
        .WIDTH  (WIDTH)
    )uut(
        .x      (x),
        .y      (y)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sd_wire_tb);

        x = 4'b0101;
        #5
        x = 4'b1010;
        #20
        $finish;
    end

endmodule