// Drake Gonzales
// drgonzales@g.hmc.edu
// This module was used as a top module for the overall design. Having calling two different functions,
// The purpose of this module is to combine other modules into one larger project. 

module lab_dg_top.sv(input logic [3:0] s1;
                     input logic [3:0] s2;
                     output logic [6:0] seg;
                     output logic disp1, disp2;
                     output logic [4:0] led);

lab2_dig_disp u_disp(s2, s2, disp1, disp2, mux);

lab2_dg_seg u_seg(mux, seg);

lab2_dg_led_adder u_adder(s1, s2, led);
 
endmodule
