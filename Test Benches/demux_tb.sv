module demux_tb;
    
    //parameter(s)
    parameter                       WIDTH = 2;
    parameter                       SELECT = 2;

    //input(s)
    logic   [WIDTH-1:0]             data_in;
    logic   [SELECT-1:0]            sel;
    logic                           en;

    //output(s)
    logic   [(2**SELECT)-1:0][WIDTH-1:0] data_out;

    demux #(
        .WIDTH      (WIDTH),
        .SELECT     (SELECT)
    )uut(
        .data_in    (data_in),
        .sel        (sel),
        .en         (en),
        .data_out   (data_out)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, demux_tb);
        data_in =       0;
        sel =           0;
        en =            0;
        #5

        data_in =       2'b11;
        #5

        for (int i = 0; i < 2**SELECT; i++) begin
            #10
            sel = i[1:0];
        end
        #5

        en = 1;
        #5

        for (int i = 0; i < 2**SELECT; i++) begin
            #10
            sel = i[1:0];
        end
        #50
        $finish;
    end

endmodule