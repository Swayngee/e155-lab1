/// Testbench module tests another module called the device under test(DUT).
// It applies inputs to DUT and check if outputs are as expected.
// User provides patterns of inputs & desired outputs called testvectors.
module testbench();
logic clk, reset;
// 'clk' & 'reset' are common names for the clock and the reset, 
 // but they're not reserved.
logic [3:0] s;
logic [1:0] led, ledexpected;
// These variables or signals represent 3 inputs, 2 outputs, 2 expected 
// outputs, respectively.
logic [31:0] vectornum, errors;
logic [5:0] testvectors[10000:0];

LED u_led(s, led);
//// Generate clock.
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
$readmemb("led.tv", testvectors);
vectornum=0; 
errors=0;
reset=1; #22; 
reset=0;
end
//// Apply test vectors on rising edge of clk.
always @(posedge clk)
begin
#1;
{s, ledexpected} = testvectors[vectornum];
end
//// Check results on falling edge of clk.
always @(negedge clk)
if (~reset) begin
if (led !== ledexpected) begin
$display("Error: inputs = %b", {s});
$display(" outputs = %b (%b expected)", led, ledexpected);
errors = errors + 1;
end
vectornum = vectornum + 1;
if (testvectors[vectornum] === 5'bx) begin
$display("%d tests completed with %d errors", vectornum, 
errors);
$stop;
end
end
endmodule