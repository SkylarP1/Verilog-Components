module sipo_param #(
    parameter WIDTH = 4
)(
    input                   serial_in,
    input                   clk,
    input                   en,
    input                   rst,
    output  reg [WIDTH-1:0] q,
    output  reg             valid
);

reg [$clog2(WIDTH):0]   cnt = 0;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        cnt <= 0;
        q <= 0;
        valid <= 0;
    end else begin
        valid <= 0;
        if(en) begin
            q <= {q[WIDTH-2:0], serial_in};
            
            if(cnt == (WIDTH-1)) begin
                cnt <= 0;
                valid <= 1;
            end else begin
                cnt <= cnt + 1;
            end
        end

        
    end
end

endmodule