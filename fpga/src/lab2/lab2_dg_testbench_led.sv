// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made for the purpose of testing the LED module. This runs test vectors for Led[4:0].
// 9/4/25
module lab2_dg_testbench_led();
    logic clk, reset;
    logic [3:0] s1;
    logic [3:0] s2;
    logic [4:0] led, ledexp;
    logic [31:0] vectornum, errors;
    logic [12:0] testvectors[255:0];  // Changed to 13 bits wide, 256 elements
    integer a, b;
    logic [4:0] sum;  
    integer v;
   
    lab2_dg_led_adder u_led(s1, s2, led);
   
    initial begin
        v = 0;
        for (a = 0; a < 16; a++) begin
            for (b = 0; b < 16; b++) begin
                sum = a + b;  
                testvectors[v] = {a[3:0], b[3:0], sum};  // 4+4+5 = 13 bits
                v++;
            end
        end
    end
    
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end
    
    initial begin
        vectornum = 0;
        errors = 0;
        reset = 1; #22;
        reset = 0;
    end
    
    always @(posedge clk) begin
        if (~reset) begin
            if (vectornum < 256) begin  // Check bounds instead of using sentinel value
                {s1, s2, ledexp} = testvectors[vectornum];
            end
        end
    end
    
    always @(negedge clk) begin
        if (~reset) begin
            if (vectornum < 256) begin  // Check bounds
                if (led != ledexp) begin
                    $display("Error: inputs = %b %b", s1, s2);
                    $display("  outputs = %b (%b expected)", led, ledexp);
                    errors = errors + 1;
                end
                vectornum = vectornum + 1;
            end else begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $stop;
            end
        end
    end
endmodule