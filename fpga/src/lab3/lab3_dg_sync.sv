module lab3_dg_sync(input logic int_osc,
                    input logic [3:0] rowpress,
                    output logic [3:0] sync);
logic [3:0] n1;

always_ff @(posedge int_osc) begin
    n1 <= rowpress;
    sync <= n1;
end 
endmodule