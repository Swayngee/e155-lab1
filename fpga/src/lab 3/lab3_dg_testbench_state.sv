// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made for the purpose of testing the mux on our schematic
// 9/4/25

module lab3_dg_testbench_state();
logic int_osc, reset;
logic [3:0] rows;
logic [3:0] cols;
logic [7:0] keypress;
logic [3:0] exp;
logic [31:0] vectornum, errors;
integer a,b;

lab3_dg_state u_state(int_osc, reset, rows, cols, keypress);
always
begin
int_osc = 0;
int_osc=1; #5; 
int_osc=0; #5;
end
initial
begin 
reset=1; #22; 
reset=0;
errors = 0;
end


always @(negedge int_osc)
if (~reset) begin
for (a = 0; a < 4; a++) begin
    exp  = ~(1 << a);  
    rows = exp;       

    repeat (10) @(posedge int_osc); 

    if (rows !== keypress[3:0]) begin
        $display("expected row %b, got %b", rows, keypress[3:0]);
         errors= errors+1;
     end else begin
        $display("tests completed with %d errors", errors);
    end
        rows = 4'b1111;  
         repeat (2) @(posedge int_osc);
        end
    $stop;
end
endmodule