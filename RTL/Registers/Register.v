module register (
    input data_in,
    input clk,
    input en,
    input set,
    input rst,
    output reg q,
    output q_prime
);
    
    always @(posedge clk or posedge rst or posedge set) begin
        if(en) q <= data_in;
        else if(rst) q <= 1'b0;
        else if(set) q <= 1'b1;        
    end

    assign q_prime = !q;
endmodule