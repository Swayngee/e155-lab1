// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made for the purpose of testing the mux on our schematic
// 9/4/25

module lab3_dg_testbench_sync();
logic int_osc, reset;
logic [3:0] rowpress;
logic [3:0] sync;	

lab3_dg_sync u_sync(int_osc, rowpress, sync);
 
logic [3:0] exp;
initial begin 
exp = 4'b0000;
end 
always
begin
int_osc=1; #5; 
int_osc=0; #5;
end

initial
begin
reset=1; #22; 
reset=0;

rowpress = 4'b0000; #10;
rowpress = 4'b1001; #10;
rowpress = 4'b1111; #10;

end

always @(posedge int_osc) begin
if (~reset) begin
    assert (sync == exp)
    else $error("sync failed 1");
    exp <= rowpress;
     
end
end
endmodule