module lab2_dg_disp(input logic [3:0] s1;
                    input logic [3:0] s2;
                    output logic disp1, disp2
                    output logic [3:0] mux);

logic int_osc;
logic [14:0] counter;

HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

//Mux
always_ff @(posedge int_osc) mux <= s1;
always_ff @(negedge int_osc) mux <= s2;
  
// clock divider
always_ff @(posedge int_osc) begin
	if(counter == 15'd24000) begin
        disp2 = disp1;
        disp1 = ~disp1;
        counter <= 0;
	end
    else            counter <= counter + 15'd1;
end

endmodule

