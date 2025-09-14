// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made to run testvectors through a simulation to test the 7-segment design. 
// 9/4/25

module lab2_dg_testbench_seg();
logic clk, reset;
logic [7:0] keypress;
logic [3:0] keys, keyexpected;
logic [31:0] vectornum, errors;
logic [11:0] testvectors[10000:0];

lab3_dg_seg u_segment(keys, seg);
//// Generate clock for the segment
always
begin
clk=1; #5; 
clk=0; #5;
end
//// Start of test. 
initial
// 'initial' is used only in testbench simulation.
begin
//// Load vectors stored as 0s and 1s (binary) in .tv file.
$readmemb("keys.tv", testvectors);

vectornum=0; 
errors=0;

reset=1; #22; 
 reset=0;

end
//// Apply test vectors on rising edge of clk.
always @(posedge clk)
 
begin

#1;
{keypress, keyexpected} = testvectors[vectornum];
end
//// Check results on falling edge of clk.
always @(negedge clk)

if (~reset) begin

if (keys !== keyexpected ) begin

$display("Error: inputs = %b", {keypress});

$display(" outputs = %b (%b expected)", keys, 
keyexpected);
//// Increment the count of errors.
errors = errors + 1;
end
//// In any event, increment the count of vectors.
vectornum = vectornum + 1;

 if (testvectors[vectornum] === 12'bx) begin

$display("%d tests completed with %d errors", vectornum, 
errors);
// Then stop the simulation.
$stop;
end
end

endmodule