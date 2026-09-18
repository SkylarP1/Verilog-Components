`timescale 1ns / 1ps
module reg_param_tb;
    reg [3:0]   data_in;
    reg         clk;
    reg         en;
    reg [3:0]   set;
    reg         rst;
    wire[3:0]   q;
    wire[3:0]   q_prime;

    /*
    module reg_param #(
        parameter WIDTH = 8
    )(
        input   wire                clk,
        input   wire                en,
        input   wire    [WIDTH-1:0] set,
        input   wire                rst,
        input   wire    [WIDTH-1:0] data_in,
        output  reg     [WIDTH-1:0] q,
        output  wire    [WIDTH-1:0] q_prime
    );
    */


    //module to be tested
    reg_param #(
        .WIDTH(4)
    )uut(
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
        $dumpvars(0, reg_param_tb);
    end

    //stimulus (checks)
    initial begin
        //signal initialization
        clk     = 1'b0;
        rst     = 1'b0;
        data_in = 4'b0000;
        en      = 1'b0;
        set     = 4'b0000;

        //after 20ns rst circuit then wait 5ns then rst to zero
        #20;
        rst     = 1'b1; // Release reset
        #5;
        rst     = 1'b0;
        #5
        if(q_prime == ~q) $display("RST Success"); else $display("RST Fail");

        //after 20ns set set to 1
        #20
        set     = 4'b1010;
        //then to 0 after 5ns
        #5
        set     = 4'b0000;
        #5
        if(~q_prime == q) $display("SET Success"); else $display("SET Fail");
        set     = 4'b0101;
        //then to 0 after 5ns
        #5
        set     = 4'b0000;
        #5
        if(~q_prime == q) $display("SET Success"); else $display("SET Fail");

        //test 
        #20;
        rst     = 1'b1;
        #5;
        rst     = 1'b0;
        #5
        if(q)   $display("RST Fail"); else $display("RST Success");
        en      = 1'b1;  
        data_in = 4'b1111;
        clk     = 1'b1;
        //wait 5ns before reseting values
        #5
        en      = 1'b0;
        clk     = 1'b0;
        data_in = 4'b0000;
        #5
        if(q)   $display("DATA LOAD 1 Success"); else $display("DATA LOAD 1 Fail");
        
        #20
        en      = 1'b1;
        clk     = 1'b1;
        #5
        en      = 1'b0;
        clk     = 1'b0;
        #5
        if(~q)   $display("DATA LOAD 0 Success"); else $display("DATA LOAD 0 Fail");

        
        

        //end sim
        #50;
        $display("Complete");
        $finish;
    end

endmodule