module decoder #(
    parameter   int SELECT  =   2
)(
    input   logic   [SELECT-1:0]        sel,
    input   logic                       en,
    output  logic   [(2**SELECT)-1:0]    out
);
    always_comb begin
        out = '0;
        if(en) out[sel] = 1'b1;
    end

endmodule