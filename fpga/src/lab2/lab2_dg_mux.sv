module lab2_dg_disp(input logic [3:0] s1,
                    input logic [3:0] s2,
                    output logic disp1,
					output logic disp2,
                    output logic [3:0] mux);

logic enabler;
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
