module mux #(
    parameter WIDTH = 4,
    parameter SELECT = 1
)(
    input   logic   [(2**SELECT)-1:0][WIDTH-1:0] data_in,
    input   logic   [SELECT-1:0]            sel,
    input   logic                           en,
    output  logic   [WIDTH-1:0]             data_out
);

    assign data_out = en ? data_in[sel]:0;
    
endmodule