module piso_param #(
    parameter WIDTH = 4
)(
    input   wire[WIDTH-1:0] parallel_in,
    input   wire            clk,
    input   wire            en,
    input   wire            load,
    input   wire            rst,
    output  reg             q,
    output  reg             finish
);

reg [$clog2(WIDTH):0]   cnt = 0;
reg [WIDTH-1:0]         data = 0;

always @(posedge clk or posedge rst) begin
    finish <= 0;
    if(rst) begin
        cnt <= 0;
        q <= 0;
        data <= 0;
    end else begin
        if(en)begin
            if(load) begin
                cnt    <= 0;
                data   <= parallel_in;
                q      <= 0;
            end else begin
                q <= data[0];
                data <= {1'b0, data[WIDTH-1:1]};
                if(cnt < WIDTH-1) begin
                    cnt <= cnt + 1;
                end else begin
                    finish <= 1'b1;
                    cnt <= 0;
                end
                
            end
        end
    end
end


endmodule