module decoder_tb;
    parameter       SELECT = 2;
    
    logic   [SELECT-1:0]         sel;
    logic   [(2**SELECT)-1:0]    out;
    logic                       en;

    decoder #(
        .SELECT      (SELECT)
    )uut(
        .sel        (sel),
        .en         (en),
        .out        (out)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, decoder_tb);

        sel =       '0;
        en  =       '0;

        for (int i = 0; i < 2**SELECT; i++) begin
            #10
            sel = i[3:0];
        end
        
        #10
        en = 1'b1;

        for (int i = 0; i < 2**SELECT; i++) begin
            #10
            sel = i[3:0];
        end
        #20
        $finish;
    end

endmodule