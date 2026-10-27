`timescale 1ns/100ps
module uni_sr_param_tb;
    //parameters    
    parameter           WIDTH = 4;
    
    //inputs
    reg         [1:0]   sel;
    reg                 rst;
    reg                 en;
    reg                 clk;
    reg         [3:0]   p_in;

    //outputs
    wire        [3:0]   q;
    
    uni_sr_param #(
        .WIDTH(WIDTH)
    )uut(
        .sel    (sel),
        .rst    (rst),
        .en     (en),
        .clk    (clk),
        .p_in   (p_in),
        .q      (q)
    );

    task tick;
        begin
            #5 clk = 1'b1;
            #5 clk = 0;
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, uni_sr_param_tb);
        sel = 0;
        rst = 0;
        en = 0;
        clk = 0;
        p_in = 0;


        rst = 1'b1;
        #5
        rst = 0;
        #5

        sel = 2'b00; tick();
        en = 1'b1;
        tick();
        #5
        en = 0;
        #5
        sel = 2'b01;
        p_in = 4'b1000;
        #5
        en = 1'b1;
        tick();
        tick();
        p_in = 4'b0001;
        tick();
        tick();

        en = 0;
        rst = 1'b1;
        #5
        rst = 0;
        #5
        sel = 2'b10;
        p_in = 4'b0001;
        #5
        en = 1'b1;
        tick();
        tick();
        p_in = 4'b1000;
        tick();
        tick();
        en = 0;
        #5
        rst = 1'b1;
        #5
        rst = 0;
        #5
        sel = 2'b11;
        p_in = 4'b1010;
        #5
        en = 1'b1;
        #5
        tick();
        en = 0;

        #50
        $finish;
    end
endmodule