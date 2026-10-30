module demux #(
    parameter WIDTH = 4,
    parameter SELECT = 1
)(
    input   logic   [WIDTH-1:0]             data_in,
    input   logic   [SELECT-1:0]            sel,
    input   logic                           en,
    output  logic   [(2**SELECT)-1:0][WIDTH-1:0] data_out
);


    always_comb begin
        data_out = 0;

        data_out[sel] = en ? data_in : 0; 
    end
endmodule