module lab2_dg_disp(input logic [3:0] s1,
                    input logic [3:0] s2,
                    output logic disp1,
					output logic disp2,
                    output logic [3:0] mux);

logic int_osc;
logic [14:0] counter;
logic enabler;
HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

  
// clock divider
always_ff @(posedge int_osc) begin
	if(counter == 15'd24000) begin
	enabler = ~enabler; 
    counter <= 0;
	end
    else            counter <= counter + 15'd1;
end

	always_comb begin
		if (enabler ==1'b0) begin
			disp1 = 1'b1;
			disp2 = 1'b0;
			mux = s1;
		end
		else begin
			disp1 = 1'b0;
			disp2 = 1'b1;
			mux = s2;
		end 
	end

endmodule
