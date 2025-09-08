module lab2_dg_testbench_top();
logic clk, reset;
logic [3:0] s1;
logic [3:0] s2;
logic [4:0] led;
logic [6:0] seg;
logic disp1, disp2;
logic [31:0]  errors;

// expected values
logic [6:0] segexpected1, segexpected2;
logic [4:0] sum;

lab2_dg_top u_top(clk, s1, s2, seg, disp1, disp2, led);
always_comb sum = s1 + s2;
always begin
clk = 1; #5; 
clk = 0; #5;
end

initial begin
errors = 0; 
reset  = 1; #22; 
reset  = 0;

    // test1
    s1 = 4'd3;
    s2 = 4'd2;
    #10;
    segexpected1 = 7'b0110000;
    segexpected2 = 7'b0100100;

    if (led != sum) begin
        errors =errors +1;
        $display("Test1 Failed: s1=%0d, s2=%0d, led=%0d, expected=%0d", s1, s2, led, sum);
    end
    else $display("Test1 sum Passed");
	#50;
	// check left display
    repeat (20) @(posedge clk);
    if (disp1 && seg != segexpected1) begin
        errors= errors+1;
    end
    // check right display
    repeat (20) @(posedge clk);
    if (disp2 && seg != segexpected2) begin
        errors =errors +1;
        $display("Test1 displays Passed");
    end

    // test2
    s1 = 4'd8;
    s2 = 4'd8;
    #10;
    segexpected1 = 7'b0000000;
    segexpected2 = 7'b0000000;

    if (led != sum) begin
        errors++;
        $display("Test2 Failed: s1=%0d, s2=%0d, led=%0d, expected=%0d", s1, s2, led, sum);
    end
    else $display("Test2 sum Passed");
    #50;
    // check left display
    repeat (20) @(posedge clk);
    if (disp1 && seg != segexpected1) begin
        errors = errors +1;
    end
    // check right display
    repeat (20) @(posedge clk);
    if (disp2 && seg != segexpected2) begin
        errors= errors +1;
        $display("Test2 displays Passed");
    end

       // test3
    s1 = 4'd15;
    s2 = 4'd14;
    #10;
    segexpected1 = 7'b0001110;
    segexpected2 = 7'b0000110;

    if (led != sum) begin
        errors= errors+1;
        $display("Test3 Failed: s1=%0d, s2=%0d, led=%0d, expected=%0d", s1, s2, led, sum);
    end
    else $display("Test3 sum Passed");
    #50;
    // check left display
    repeat (20) @(posedge clk);
    if (disp1 && seg != segexpected1) begin
        errors= errors +1;
    end
    // check right display
    repeat (20) @(posedge clk);
    if (disp2 && seg != segexpected2) begin
        errors =errors+1;
        $display("Test3 displays Passed");
    end
    $display("All tests done. Total errors = %0d", errors);
    $finish;
    end 
endmodule