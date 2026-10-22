`timescale 1ns/100ps
module sipo_param_tb;

    parameter               WIDTH = 4;
    reg                     serial_in;
    reg                     clk;
    reg                     en;
    reg                     rst;

    wire    [WIDTH-1:0]     q;
    wire                    valid;
    
    sipo_param #(
        .WIDTH(WIDTH)
    )uut(
        .serial_in(serial_in),
        .clk(clk),
        .en(en),
        .rst(rst),
        .q(q),
        .valid(valid)
    );

    task tick;
        begin
            #5 clk = 1;
            #5 clk = 0;
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sipo_param_tb);

        rst = 1;
        #10
        rst = 0;
        #5

        en = 1;

        serial_in = 1; tick();
        serial_in = 0; tick();
        serial_in = 1; tick();
        serial_in = 0; tick();
        
        en = 0;
        #10

        en = 1;
        serial_in = 0; tick();
        serial_in = 1; tick();

        en = 0;
        #20
        en = 1;
        serial_in = 1; tick();
        serial_in = 0; tick();
        en = 0;

        #50
        $finish;
    end
endmodule