module async_reg_param #(
    parameter WIDTH = 4
)(
    input   logic   [(WIDTH*2)-1:0] data_in,
    input   logic   [1:0]           w_en,
    input   logic   [1:0]           rst,
    input   logic   [1:0]           r_en,
    output  logic   [(WIDTH*2)-1:0] data_out,
    output  logic   [1:0]           written
);

    logic               w_en_en = 0;
    logic               r_en_en = 0;
    logic               rst_en = 0;
    
    logic   [(WIDTH*2)-1:0] register;

    logic    [WIDTH-1:0] bits_valid;

    always_latch begin
        if(rst == 2'b00 | rst == 2'b11) rst_en = 1'b0;
        else if(rst == 2'b01) rst_en = 1'b1;
        if(w_en == 2'b00 | w_en == 2'b11) w_en_en = 1'b0;
        else if(w_en == 2'b01) w_en_en = 1'b1;
        if(r_en== 2'b00 | r_en == 2'b11) r_en_en = 1'b0;
        else if(r_en == 2'b01) r_en_en = 1'b1;

        if(rst == 2'b10 & rst_en == 1'b1) begin
            register = 0;
        end
        if(w_en == 2'b10 & w_en_en == 1'b1) begin
            register = 0;
            register = data_in;
        end
        if(r_en == 2'b10 & r_en_en == 1'b1) begin
            data_out = register;
        end else begin
            data_out = 0;
        end
    end

    always_comb begin
        bits_valid = 0;
        for(int i = 0; i < WIDTH; i++) begin
            if(register[(i*2)+1] != register[(i*2)]) begin
                bits_valid[i] = 1'b1;
            end
        end

        written = {&bits_valid, ~&bits_valid};
    end

    
endmodule