`timescale 1ns/100ps
module ivideo_ovideo_top_tb;

	// Inputs
	reg 		I_clk;
	reg			rst_n;

/*********************************************/


	GSR GSR(.GSRI(1'b1)); 
	
	initial begin
        I_clk=1'b0;
        #1;
        forever
        #10 I_clk=~I_clk;
  end
  initial begin
    	rst_n = 1'b0;
    	#500;
    	rst_n = 1'b1;
		//#1000;
		//#50000;
		//#20000;
    //    #1000000;
        //$finish;
    //    $stop; //modify on 12/8 by licy
	end



ivideo_dynamic_top   ivideo_test_inst(
.RST_n				(rst_n),
.I_clk				(I_clk),

.O_hs_clk_p  			(),               
.O_hs_clk_n 			(),
.O_hs_d0_p  			(),               
.O_hs_d0_n 		  	(),
.O_hs_d1_p  			(),               
.O_hs_d1_n 		  	(),
.O_hs_d2_p  			(),               
.O_hs_d2_n 		  	(),
.O_hs_d3_p  			(),               
.O_hs_d3_n 		  	(),

.O_lp_clk_p  			(),               
.O_lp_clk_n 			(),
.O_lp_d0_p  			(),               
.O_lp_d0_n 		  	(),
.O_lp_d1_p  			(),               
.O_lp_d1_n 			  (),
.O_lp_d2_p  			(),               
.O_lp_d2_n 			  (),
.O_lp_d3_p  			(),               
.O_lp_d3_n 			  (),

.IO_a    			    ()    
);

endmodule