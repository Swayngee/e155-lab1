module lab3_dg_sync(input logic int_osc,
					input logic reset,
                    input logic [3:0] rowpress,
                    output logic [3:0] sync);
logic [3:0] n1;

always_ff @(posedge int_osc or posedge reset) begin
    if (~reset) begin
        n1   <= 4'b0000;
        sync <= 4'b0000;
    end else begin
        n1   <= rowpress;
        sync <= n1;
    end
end
endmodule