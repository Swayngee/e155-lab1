// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made for the purpose of testing the mux on our schematic
// 9/4/25

module lab2_dg_testbench_mux();
logic clk, reset;
logic [3:0] s1;
logic [3:0] s2;
logic disp1, disp2;
logic [3:0] mux;	
logic [31:0] vectornum, errors;
logic [7:0] testvectors[10000:0];
integer a,b;
integer v;
integer cycles;

lab2_dg_mux u_led(clk, s1, s2, disp1, disp2, mux);

initial begin
	v = 0;
		for (a = 0; a<16; a++) begin
			for (b = 0; b<16; b++) begin
			testvectors[v] = {a[3:0],b[3:0]};
			v++;		
			end
		end
clk = 0;
end
//// Generate clock.
always
begin
clk=1; #5; 
clk=0; #5;
end
//// Start of test. 
initial
begin
vectornum=0; 
errors=0;
reset=1; #22; 
reset=0;
end
//// Apply test vectors on rising edge of clk.
always @(posedge clk) begin
if (~reset) begin
		#1;
		{s1, s2} = testvectors[vectornum];
		vectornum = vectornum + 1;
	end
end

//// Check results on falling edge of clk.
always @(negedge clk)
if (~reset) begin
	if (disp1 == disp2) begin
		$display("Error: inputs = %b", {s1,s2});
		$display(" outputs = %d and %d are the same", disp1, disp2);
		errors = errors + 1;
	end
	if (disp1 && ~disp2 && mux != s1) begin
		$display("Error: inputs = %b", {s1,s2});
		$display(" outputs = case (enabler) = 0 is wrong");
		errors = errors + 1;
	end
	else if (~disp1 && disp2 && mux != s2) begin
		$display("Error: inputs = %b", {s1,s2});
		$display(" outputs = case (enabler) = 1 is wrong");
		errors = errors + 1;
	end
	if (testvectors[vectornum] === 8'bx) begin
		$display("%d tests completed with %d errors", vectornum, errors);
		if (errors >= 1) begin
		$display("test failed");
			end 
		else
			$display("test passed!"); 
			$stop;
	end
	end
endmodule