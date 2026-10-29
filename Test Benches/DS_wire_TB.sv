module ds_wire_tb;
    //parameter(s)
    parameter               WIDTH = 2;
    
    //input(s)
    logic   [(WIDTH*2)-1:0] x;

    //output(s)
    logic   [(WIDTH-1):0]   y;
    logic   [(WIDTH-1):0]   y_hat;
    logic   [(WIDTH-1):0]   no;
    logic   [(WIDTH-1):0]   invalid;

    ds_wire #(
        .WIDTH  (WIDTH)
    )uut(
        .x      (x),
        .y      (y),
        .y_hat  (y_hat),
        .no   (no),
        .invalid(invalid)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, ds_wire_tb);

        x = 0;
        #20;
        x = 4'b0101;
        #20
        x = 4'b1010;
        #20
        x = 4'b1111;
        #20
        $finish;
    end

endmodule