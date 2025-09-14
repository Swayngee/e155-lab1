// Drake Gonzales
// drgonzales@g.hmc.edu
// Module for controling the sub-modules. Also initializing the HSOSC
// 9/4/25
module lab3_dg_top(input logic reset, 
					input logic [3:0] row,
                    output logic [3:0] cols, 
                    output logic [6:0] seg,
                     output logic disp1,
					 output logic disp2);

HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

logic int_osc;
logic enabler = 1'b0;
logic [20:0] counter;

// clock divider
always_ff @(posedge int_osc) begin
if (~reset) begin
	counter <= 0;
end else begin
	if (counter == 19'd100000) begin
    counter <= 0;
    enabler = ~enabler
	end
    else counter <= counter + 19'd1;
end
end
always_comb begin
    if (enabler == 1'b0) begin
			disp1 = 1'b1;
			disp2 = 1'b0;
       end else begin
            disp1 = 1'b0;
			disp2 = 1'b1;
       end
end

lab3_dg_state u_state(int_osc, reset, rows, cols, keys, keypress);

lab3_dg_decoder u_decoder(keypress, keys);

lab3_dg_seg u_seg(keys, seg);

endmodule