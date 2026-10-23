`timescale 1ns/100ps
module piso_param_tb;

    parameter               WIDTH = 4;
    reg [WIDTH-1:0]         parallel_in;
    reg                     clk;
    reg                     en;
    reg                     load;
    reg                     rst;

    wire                    q;
    wire                    finish;
    
    piso_param #(
        .WIDTH(WIDTH)
    )uut(
        .parallel_in(parallel_in),
        .clk(clk),
        .en(en),
        .load(load),
        .rst(rst),
        .q(q),
        .finish(finish)
    );

    task tick;
        begin
            #5 clk = 1;
            #5 clk = 0;
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, piso_param_tb);
        clk = 0;
        en          = 0;
        load        = 0;
        parallel_in = 0;
        rst         = 0;


        rst         = 1;
        #10
        rst         = 0;
        #5

        en          = 1;
        load        = 1;

        #5        
        parallel_in = 4'b1010; tick();
        #5
        load        = 0;
        #5
        tick();
        tick();
        tick();
        tick();

        #20

        load        = 1;
        parallel_in = 4'b0110; tick();
        #5
        load        = 0;
        #5
        tick();
        tick();
        #5
        en          = 0;
        #5
        tick();
        #5
        en          = 1;
        #5
        tick();
        tick();

        #50
        $finish;
    end
endmodule