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

lab3_dg_state u_state(int_osc, reset, rows, cols, keypress, alarm);

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

// state idle testing
	if (u_state.state == u_state.idle) begin
		assert((u_state.nextstate == u_state.waiter) && (rows != 4'b1111))
		else $error("idle state failed");
	end
// state waiter testing
	if (u_state.state == u_state.waiter) begin
		assert((u_state.keypress == {cols, u_state.srows}) && (u_state.nextstate == u_state.check))
		else $error("sync state failed");
	end
// state check test
	if (u_state.state == u_state.check) begin
		assert((u_state.keypress != u_state.prekey) && (u_state.nextstate == u_state.drive)) 
		else $error("check state failed");
	end
// state drive test
	 if (u_state.state == u_state.drive) begin
		assert(u_state.nextstate == u_state.last)
			else $error("drive state failed");
		end
// state last test
	if (u_state.state == u_state.last) begin
		assert((u_state.keypress == u_state.prekey) && (u_state.nextstate == u_state.idle)) 
		else $error("check state failed");
	end

end


initial begin
		
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