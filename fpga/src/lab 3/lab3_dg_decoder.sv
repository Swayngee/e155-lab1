module lab3_dg_decoder(input logic [7:0] keypress,
                        output logic [3:0] keys)

    
    
    case(keypress)
        	8'b11011110: keys = 4'h0; 
			8'b11100111: keys = 4'h1; 
			8'b11010111: keys = 4'h2; 
			8'b10110111: keys = 4'h3;
			8'b11101011: keys = 4'h4;
			8'b11011011: keys = 4'h5;
			8'b10111011: keys = 4'h6;
			8'b11101101: keys = 4'h7;
			8'b11011101: keys = 4'h8;
			8'b10111101: keys = 4'h9;
			8'b11101110: keys = 4'hA;
			8'b10111110: keys = 4'hB;
			8'b01110111: keys = 4'hC;
			8'b01111011: keys = 4'hD;
			8'b01111101: keys = 4'hE;
			8'b01111110: keys = 4'hF;
	        default: keys = 4'h0;
    endcase
endmodule