`timescale 1ns / 1ps
module register_tb;
    reg     data_in;
    reg     clk;
    reg     en;
    reg     set;
    reg     rst;
    wire    q;
    wire    q_prime;

    /*module register (
        input data_in,
        input clk,
        input en,
        input set,
        input rst,
        output reg q,
        output q_prime
    );
    */


    //module to be tested
    register uut (
        .data_in    (data_in),
        .clk        (clk),
        .en         (en),
        .set        (set),
        .rst        (rst),
        .q          (q),
        .q_prime    (q_prime)
    );

    //setup dump information stuff
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, register_tb);
    end

    //stimulus (checks)
    initial begin
        //signal initialization
        clk     = 1'b0;
        rst     = 1'b0;
        data_in = 1'b0;
        en      = 1'b0;
        set     = 1'b0;

        //after 20ns rst circuit then wait 5ns then rst to zero
        #20;
        rst     = 1'b1; // Release reset
        #5;
        rst     = 1'b0;
        if(q_prime == !q) $display("RST Success"); else $display("RST Fail");

        //after 20ns set set to 1
        #20
        set     = 1'b1;
        //then to 0 after 5ns
        #5
        set     = 1'b0;
        if(!q_prime == q) $display("SET Success"); else $display("SET Fail");

        //test 
        #20;
        rst     = 1'b1;
        #5;
        rst     = 1'b0;
        if(q)   $display("RST Fail"); else $display("RST Success");
        en      = 1'b1;  
        data_in = 1'b1;
        clk     = 1'b1;
        //wait 5ns before reseting values
        #5
        en      = 1'b0;
        clk     = 1'b0;
        data_in = 1'b0;
        if(q)   $display("DATA LOAD 1 Success"); else $display("DATA LOAD 1 Fail");
        
        #20
        en      = 1'b1;
        clk     = 1'b1;
        #5
        en      = 1'b0;
        clk     = 1'b0;
        if(!q)   $display("DATA LOAD 0 Success"); else $display("DATA LOAD 0 Fail");

        
        

        //end sim
        #50;
        $display("Complete");
        $finish;
    end

    //signal monitor
    initial begin
        $monitor("Time=%0t | rst_n=%b | data_in=0x%b | data_out=0x%b", 
                 $time, rst, data_in, q, q_prime, set, en, clk);
    end

endmodule