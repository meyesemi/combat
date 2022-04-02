// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014-2017 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] rgb48bit_to4ch16bit_ctrl.v
//   \ \  / /\ \  / /    [Description ] convert 48bit to 4channel 16bit    
//    \ \/ /  \ \/ /     [Timestamp   ] Wednesday August 15 10:00:30 2017
//     \  /    \  /      [version     ] 1.0.0
//      \/      \/       
//
// ===========Oooo==========================================Oooo========
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author |Mod. Date |Changes Made:
// V1.0 | GQG    |04/10/18  |Initial version
// ===========Oooo==========================================Oooo========
//			clk1		clk2		clk3		clk4		......
//lane0	RO1 GE1	    BO2	RO3 GE3	    BO4	
//lane1	GO1 BE1	    RE2	GO3 BE3	    RE4	
//lane2	BO1 		RO2 GE2	BO3 		RO4 GE4	
//lane3	RE1 		GO2 BE2	RE3 		GO4 BE4	
//
// ===========Oooo==========================================Oooo========
`timescale 1 ns / 1 ps
//`include "mcu2mipi_defines.v"

module rgb48bit_to4ch16bit_ctrl (
								input			I_rst_n,
								//LVDS7:1 RX SIDE
							  //Inputs
								input      	I_sclk,
								input[23:0]	I_rxo_rgb,
								input      	I_rxo_hsync,
								input      	I_rxo_vsync,
								input      	I_rxo_de,
								input[23:0]	I_rxe_rgb,
								//input      	I_rxe_hsync,
								//input      	I_rxe_vsync,
								//input      	I_rxe_de, 
								//ASYNFIFO SIDE
							 	//Outputs
								output reg	O_rgb_lane0_wren,
								output reg[15:0]	O_rgb_lane0_data,
								output reg	O_rgb_lane1_wren,
								output reg[15:0]	O_rgb_lane1_data,
								output reg	O_rgb_lane2_wren,
								output reg[15:0]	O_rgb_lane2_data,
								output reg	O_rgb_lane3_wren,
								output reg[15:0]	O_rgb_lane3_data,

								output reg	O_vshsde_wren,
								output reg[7:0]	O_vshsde_ctrl,
								output [2:0]	test


								);

								
	/*******************************************************************************
	 * O_vshsde_ctrl  parameter
	 *******************************************************************************/
	//parameter VSS 		=8'h0F;
	//parameter HSS 		=8'hF0;
	parameter DES_VALID		=8'hFF;
	parameter DES_INVALID	=8'h0F;
	parameter DVS_VALID		=8'hF0;

	parameter DELAY_RGB_CTRL		=10'd300;
	
	/*******************************************************************************
	 * reg and wire definition
	 *******************************************************************************/
	reg [DELAY_RGB_CTRL+50:0] 			    					I_rxo_hsync_reg;
	reg [DELAY_RGB_CTRL:0] 										I_rxo_vss_reg;
	reg [DELAY_RGB_CTRL:0] 										I_rxo_de_reg;

	reg [1:0] 										Count_48to4c16;
	reg [7:0] 										Rgb_lane0_data_reg;
	reg [7:0] 										Rgb_lane1_data_reg;
	reg [7:0] 										Rgb_lane2_data_reg;
	reg [7:0] 										Rgb_lane3_data_reg;
	reg [8:0] i,j,m;

//	reg [12:0] 										Count_hs_len_de;
//	reg [12:0] 										Count_hs_len_hs;

//	reg [12:0] 										Hs_len_value;

//	reg [5:0] 										Count_vs_tx;

    reg                                             Vss_flag;
    reg [1:0]                                       Fsm_vss_flag;


assign test={I_rxo_vss_reg[DELAY_RGB_CTRL],I_rxo_de_reg[DELAY_RGB_CTRL],I_rxo_hsync_reg[DELAY_RGB_CTRL+50]};
 /*******************************************************************************/
 //
 /*******************************************************************************/
	always @(posedge I_sclk or negedge I_rst_n)
	begin
    if(!I_rst_n) begin
      I_rxo_hsync_reg<=0;//initial value
		I_rxo_vss_reg<=0;
		I_rxo_de_reg<=0;
        Fsm_vss_flag<=0;
        Vss_flag<=0;
		end
    else begin
        if(I_rxo_vsync)begin
            case(Fsm_vss_flag)
                0:begin
                    if(I_rxo_hsync_reg[48])begin
                       Vss_flag<=1; 
                        Fsm_vss_flag<=1;
                    end
                    else begin
                        Vss_flag<=0;
                        Fsm_vss_flag<=0;
                    end
                end
                1:begin
                    if(~I_rxo_hsync_reg[48])begin
                       Vss_flag<=0; 
                        Fsm_vss_flag<=2;
                    end
                    else
                       Fsm_vss_flag<=1;
                end
                2:begin
                    Fsm_vss_flag<=2;
                end
                default:begin    
                    Fsm_vss_flag<=0;
                end
            endcase
        end
        else begin
            Vss_flag<=0;
            Fsm_vss_flag<=0;
        end
		for(j=0;j<DELAY_RGB_CTRL+50;j=j+1) begin       
			I_rxo_hsync_reg[j+1]<=I_rxo_hsync_reg[j];
		end                                 
		I_rxo_hsync_reg[0]<=I_rxo_hsync;

		for(i=0;i<DELAY_RGB_CTRL;i=i+1) begin       
			I_rxo_vss_reg[i+1]<=I_rxo_vss_reg[i];
		end    
		I_rxo_vss_reg[0]<=Vss_flag;

		for(m=0;m<DELAY_RGB_CTRL;m=m+1) begin       
			I_rxo_de_reg[m+1]<=I_rxo_de_reg[m];
		end 
		I_rxo_de_reg[0]<=I_rxo_de & I_rxo_hsync_reg[49];
                             
	 end
	end
	//only DE mode to be used
	always @(posedge I_sclk or negedge I_rst_n) 
	begin
	  if(!I_rst_n) begin
		  O_vshsde_wren<=0;
		  O_vshsde_ctrl<=0;
	  end
	  else begin
		  if(I_rxo_vss_reg[DELAY_RGB_CTRL-1] & ~I_rxo_vss_reg[DELAY_RGB_CTRL])begin
			  O_vshsde_wren<=1;
			  O_vshsde_ctrl<=DVS_VALID;
		  end
		  else if(I_rxo_de_reg[DELAY_RGB_CTRL-1] & ~I_rxo_de_reg[DELAY_RGB_CTRL])begin
			  O_vshsde_wren<=1;
			  O_vshsde_ctrl<=DES_VALID;
		  end
		  else if(I_rxo_hsync_reg[DELAY_RGB_CTRL+49] & ~I_rxo_hsync_reg[DELAY_RGB_CTRL+50])begin
			  O_vshsde_wren<=1;
			  O_vshsde_ctrl<=DES_INVALID;
		  end
		  else
			  O_vshsde_wren<=0;
	  end
	end
 /*******************************************************************************/
 //rgb48bit_to_4ch 16bit 
 /*******************************************************************************/ 
	always @(posedge I_sclk or negedge I_rst_n) 
	begin
   	if (~I_rst_n) begin 
			Count_48to4c16<=0;
			O_rgb_lane0_wren<=0;
			O_rgb_lane1_wren<=0;
			O_rgb_lane2_wren<=0;
			O_rgb_lane3_wren<=0;
			O_rgb_lane0_data<=0;
			O_rgb_lane1_data<=0;
			O_rgb_lane2_data<=0;
			O_rgb_lane3_data<=0;
			Rgb_lane0_data_reg<=0;
			Rgb_lane1_data_reg<=0;
			Rgb_lane2_data_reg<=0;
			Rgb_lane3_data_reg<=0;
		end
		else begin
			if(I_rxo_de)begin
				if(Count_48to4c16<3)
					Count_48to4c16<=Count_48to4c16+1;
				else
					Count_48to4c16<=0;
				//lane0
				if(Count_48to4c16==0)begin
					O_rgb_lane0_wren<=1;
					O_rgb_lane0_data<={I_rxe_rgb[15:8],I_rxo_rgb[23:16]};
				end
				else if(Count_48to4c16==1)begin
					O_rgb_lane0_wren<=0;
					Rgb_lane0_data_reg<=I_rxo_rgb[7:0];
				end
				else if(Count_48to4c16==2)begin
					O_rgb_lane0_wren<=1;
					O_rgb_lane0_data<={I_rxo_rgb[23:16],Rgb_lane0_data_reg};
					Rgb_lane0_data_reg<=I_rxe_rgb[15:8];
				end
				else if(Count_48to4c16==3)begin
					O_rgb_lane0_wren<=1;
					O_rgb_lane0_data<={I_rxo_rgb[7:0],Rgb_lane0_data_reg};
				end
				//lane1
				if(Count_48to4c16==0)begin
					O_rgb_lane1_wren<=1;
					O_rgb_lane1_data<={I_rxe_rgb[7:0],I_rxo_rgb[15:8]};
				end
				else if(Count_48to4c16==1)begin
					O_rgb_lane1_wren<=0;
					Rgb_lane1_data_reg<=I_rxe_rgb[23:16];
				end
				else if(Count_48to4c16==2)begin
					O_rgb_lane1_wren<=1;
					O_rgb_lane1_data<={I_rxo_rgb[15:8],Rgb_lane1_data_reg};
					Rgb_lane1_data_reg<=I_rxe_rgb[7:0];
				end
				else if(Count_48to4c16==3)begin
					O_rgb_lane1_wren<=1;
					O_rgb_lane1_data<={I_rxe_rgb[23:16],Rgb_lane1_data_reg};
				end
				//lane2
				if(Count_48to4c16==0)begin
					O_rgb_lane2_wren<=0;
					Rgb_lane2_data_reg<=I_rxo_rgb[7:0];
				end
				else if(Count_48to4c16==1)begin
					O_rgb_lane2_wren<=1;
					O_rgb_lane2_data<={I_rxo_rgb[23:16],Rgb_lane2_data_reg};
					Rgb_lane2_data_reg<=I_rxe_rgb[15:8];
				end
				else if(Count_48to4c16==2)begin
					O_rgb_lane2_wren<=1;
					O_rgb_lane2_data<={I_rxo_rgb[7:0],Rgb_lane2_data_reg};
				end
				else if(Count_48to4c16==3)begin
					O_rgb_lane2_wren<=1;
					O_rgb_lane2_data<={I_rxe_rgb[15:8],I_rxo_rgb[23:16]};
				end
				//lane3
				if(Count_48to4c16==0)begin
					O_rgb_lane3_wren<=0;
					Rgb_lane3_data_reg<=I_rxe_rgb[23:16];
				end
				else if(Count_48to4c16==1)begin
					O_rgb_lane3_wren<=1;
					O_rgb_lane3_data<={I_rxo_rgb[15:8],Rgb_lane3_data_reg};
					Rgb_lane3_data_reg<=I_rxe_rgb[7:0];
				end
				else if(Count_48to4c16==2)begin
					O_rgb_lane3_wren<=1;
					O_rgb_lane3_data<={I_rxe_rgb[23:16],Rgb_lane3_data_reg};
				end
				else if(Count_48to4c16==3)begin
					O_rgb_lane3_wren<=1;
					O_rgb_lane3_data<={I_rxe_rgb[7:0],I_rxo_rgb[15:8]};
				end
			end
			else begin
				O_rgb_lane0_wren<=0;
				O_rgb_lane1_wren<=0;
				O_rgb_lane2_wren<=0;
				O_rgb_lane3_wren<=0;
			end
		end
	end	
	
/*******************************************************************************/
endmodule 
