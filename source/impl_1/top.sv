module top(input logic [3:0] s,
		   output logic [6:0] seg,
		   output logic [2:0] led);
		   
led2 u_led(s, led);
segment u_segment(s, seg);
endmodule


		