module led(input logic [3:0] s,
		   output logic [2:0] led);
		 
   logic int_osc;
   logic [24:0] counter;

  
   // Internal high-speed oscillator
   HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
  
   // Counter
   always_ff @(posedge int_osc) begin
		if(counter == 5000000) begin
			counter <= 0;
			led[2] <= ~led[2];
		end
     else            counter <= counter + 1;
   end
  
   // Assign LED output

   assign led[0] = s[1] ^ s[0];
   assign led[1] = s[3] & s[2];

endmodule