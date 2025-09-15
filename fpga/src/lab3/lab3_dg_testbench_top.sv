// Drake Gonzales
// drgonzales@g.hmc.edu
// Testbench for the top module. Hosts three test, each with different input switches
// 9/4/25

module lab3_dg_testbench_top();
logic int_osc, reset;
logic [3:0] rows;
logic [3:0] cols;
logic [6:0] seg;
logic disp1, disp2;
logic [31:0]  errors;

// expected values
logic [6:0] segexpected1, segexpected2;

lab2_dg_top u_top(int_osc, reset, rows, cols, seg, disp1, disp2);

always begin
int_osc = 1; #5; 
int_osc = 0; #5;
end

initial begin
errors = 0; 
reset  = 1; #22; 
reset  = 0;

    // test1
    {rows, cols} = 8'b11011110;
    #10;

    segexpected1 = 7'b1000000;
    segexpected2 = 7'b1000000;

	#50;
	// check left display
    repeat (20) @(posedge int_osc);
    if (disp1 && seg != segexpected1) begin
        errors= errors+1;
    end

    // check right display
    repeat (20) @(posedge int_osc);
    if (disp2 && seg != segexpected2) begin
        errors =errors +1;
        $display("Test1 displays failed");
    end

    // test2
    {rows, cols} = 8'b10111011;
    #10;
    segexpected1 = 7'b0000010;
    segexpected2 = 7'b1000000;

    #50;
    // check left display
    repeat (20) @(posedge int_osc);
    if (disp1 && seg != segexpected1) begin
        errors = errors +1;
    end
    // check right display
    repeat (20) @(posedge int_osc);
    if (disp2 && seg != segexpected2) begin
        errors= errors +1;
        $display("Test2 displays failed");
    end

    // test3
    {rows, cols} = 8'b01111110;
    #10;
    segexpected1 = 7'b0001110;
    segexpected2 = 7'b0000010;

    #50;
    // check left display
    repeat (20) @(posedge int_osc);
    if (disp1 && seg != segexpected1) begin
        errors= errors +1;
    end
    // check right display
    repeat (20) @(posedge int_osc);
    if (disp2 && seg != segexpected2) begin
        errors = errors+1;
        $display("Test3 displays failed");
    end


    $display("All tests done. Total errors = %0d", errors);
    $finish;
    end
endmodule