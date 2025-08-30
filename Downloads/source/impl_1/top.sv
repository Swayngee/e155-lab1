module top(input logic [3:0] s,
		   output logic [6:0] seg,
		   output logic [2:0] led);
		   
led u_led(s, led);
seg u_segment(s, seg);
endmodule


		