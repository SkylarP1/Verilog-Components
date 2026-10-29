module async_reg_tb;
    
    //parameter(s)
    parameter WIDTH = 4;

    //input(s)
    logic   [(WIDTH*2)-1:0] data_in;
    logic   [1:0]           w_en;
    logic   [1:0]           rst;
    logic   [1:0]           r_en;

    //output(s)
    logic   [(WIDTH*2)-1:0] data_out;
    logic   [1:0]           written;

    async_reg #(
        .WIDTH      (WIDTH)
    )uut(
        .data_in    (data_in),
        .w_en       (w_en),
        .rst        (rst),
        .r_en       (r_en),
        .data_out   (data_out),
        .written    (written)
    );

    task write;
        begin
            #5;
            w_en = 2'b10;
            #5;
            w_en = 2'b01;
            #5;
        end
    endtask

    task reset;
        begin
            #5;
            rst = 2'b10;
            #5;
            rst = 2'b01;
            #5;
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, async_reg_tb);

        data_in = 0;
        w_en = 0;
        rst = 0;
        r_en = 0;

        //testing 00 write, rst flags to make sure they only trigger when they were previous 01

        data_in = 8'b01011010;
        #5
        write();
        #5
        write();
        #5

        //testing 11 write, rst flags to make sure they only trigger when they were previous 01
        data_in = 8'b10100101;
        w_en = 2'b11;
        rst = 2'b11;
        #5
        write();
        #5
        write();
        #5
        reset();
        #5
        reset();
        #5

        //testing read enable
        write();
        #5
        r_en = 2'b10;
        #5
        r_en = 2'b01;
        #5
        r_en = 2'b10;
        #5
        r_en = 2'b11;
        #5
        r_en = 2'b10;
        #5
        r_en = 2'b01;
        #5
        r_en = 2'b10;
        #10
        $finish;
    end


endmodule