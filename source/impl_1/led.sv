module LED(input logic [3:0] s,
		   output logic [1:0] led);
		 

   // Assign LED output

   assign led[0] = s[1] ^ s[0];
   assign led[1] = s[3] & s[2];

endmodule