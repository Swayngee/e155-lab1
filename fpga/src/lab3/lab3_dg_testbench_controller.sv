// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was made for the purpose of testing the mux on our schematic
// 9/4/25

module lab3_dg_testbench_controller();
logic int_osc, reset;
logic enabler;             
logic alarm;
logic [7:0] keypress;
logic disp1;
logic disp2;
logic [7:0] controller;	

lab3_dg_controlseg u_controller(int_osc, reset, enabler, alarm, keypress, disp1, disp2, controller);

logic [7:0] exp;
initial begin 
    exp = 8'b00000000;      
end 

always begin
    int_osc = 1; #5; 
    int_osc = 0; #5;
end

initial begin
    reset = 1; #22; 
    reset = 0;

    keypress = 8'b11011110; #10;
    keypress = 8'b11100111; #10;
    keypress = 8'b10111011; #10;

    if (u_controller.enabler == 1'b0) begin
        assert((disp1 == 1'b1) && (controller == u_controller.past))
            else $error("drive fail");
    end
    if (u_controller.enabler == 1'b1) begin
        assert((disp2 == 1'b1) && (controller == u_controller.current))
            else $error("drive fail");
    end
end

always @(posedge int_osc) begin
    if (~reset) begin
        assert(controller == exp)
            else $error("controller failed ");
        exp <= keypress; 
    end
end
endmodule