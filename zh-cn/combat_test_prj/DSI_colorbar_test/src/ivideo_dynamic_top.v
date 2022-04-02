`timescale 1ns/1ps
module ivideo_dynamic_top(
                        input       I_clk,
                        input       RST_n,
								//LVDS channel A
 /*                       input       RCLK_in_p,
                        input       RCLK_in_n,
                        input       R0_in_p,
                        input       R0_in_n,
                        input       R1_in_p,
                        input       R1_in_n,
                        input       R2_in_p,
                        input       R2_in_n,
                        input       R3_in_p,
                        input       R3_in_n,
								//LVDS channel B
                        input       RCLK1_in_p,
                        input       RCLK1_in_n,
                        input       R4_in_p,
                        input       R4_in_n,
                        input       R5_in_p,
                        input       R5_in_n,
                        input       R6_in_p,
                        input       R6_in_n,
                        input       R7_in_p,
                        input       R7_in_n,*/
								//MIPI Interface
								output 		O_hs_clk_p, // HS (High Speed) Clock        
								output 		O_hs_clk_n,  // HS (High Speed) Clock                                                                                                                                                              
								output 		O_hs_d0_p,//HS (High Speed) Data Lane 0   
								output 		O_hs_d0_n,  //HS (High Speed) Data Lane 0   
								output 		O_hs_d1_p,//HS (High Speed) Data Lane 1   
								output 		O_hs_d1_n,  //HS (High Speed) Data Lane 1   
								output 		O_hs_d2_p,//HS (High Speed) Data Lane 2   
								output 		O_hs_d2_n,  //HS (High Speed) Data Lane 2   
								output 		O_hs_d3_p,//HS (High Speed) Data Lane 3   
								output 		O_hs_d3_n,  //HS (High Speed) Data Lane 3   
/**/
								inout 		O_lp_clk_p, // LP (Lower Power) Clock        
								inout 		O_lp_clk_n,  //LP (Lower Power) Clock                                                                                                                                                              
								inout 		O_lp_d0_p,//LP (Lower Power)Data Lane 0   
								inout 		O_lp_d0_n,  //LP (Lower Power) Data Lane 0   
								inout 		O_lp_d1_p,//LP (Lower Power) Data Lane 1   
								inout 		O_lp_d1_n,  //LP (Lower Power) Data Lane 1   
								inout 		O_lp_d2_p,//LP (Lower Power)Data Lane 2   
								inout 		O_lp_d2_n,  //LP (Lower Power) Data Lane 2   
								inout 		O_lp_d3_p,//LP (Lower Power)Data Lane 3   
								inout 		O_lp_d3_n,  //LP (Lower Power) Data Lane 3   
/**/
								output 		O_lcd_led_en,//LP (Lower Power)Data Lane 3   
								output 		O_lcd_led_pwm  //LP (Lower Power) Data Lane 3  


);

/*************************************************/
      wire[7:0]   r_R,r_G,r_B;
      wire        RCLK_in;
      wire        R0_in,R1_in,R2_in,R3_in;

      wire[7:0]   r_R1,r_G1,r_B1;
      wire        RCLK1_in;
      wire        R4_in,R5_in,R6_in,R7_in;

      wire        pll_lock_rx;
      wire        pll_lock_rx1;

      wire        eclk;
      wire        sclk;
      wire        eclk1;
      wire        sclk1;

      wire[6:0]   RCLK_out_sclk;       // 7-bit parallel clock data, sclk domain
      wire[6:0]   rx_a,rx_b,rx_c,rx_d;    
      wire[6:0]   rx_a_sclk,rx_b_sclk,rx_c_sclk,rx_d_sclk;

      wire[6:0]   RCLK1_out_sclk;       // 7-bit parallel clock data, sclk domain
      wire[6:0]   rx_e,rx_f,rx_g,rx_h;    
      wire[6:0]   rx_e_sclk,rx_f_sclk,rx_g_sclk,rx_h_sclk;

        //PLL dynamic parameter
      wire [3:0]   psda;
      wire [3:0]   dutyda;
      wire [3:0]   psda1;
      wire [3:0]   dutyda1;
      
      wire        reset_n;
      reg [10:0]  cnt;
//      wire[2:0]   test_mipi;
      wire        lock_flag;
      wire        lock1_flag;

		wire			I_userclk;

		wire[23:0]  RXO_rgb,RXE_rgb;
		wire			RXO_hsync,RXO_vsync,RXO_de;
		wire			RXE_hsync,RXE_vsync,RXE_de;

		wire[23:0]  RXO_rgb_o,RXE_rgb_o;
		wire			RXO_hsync_o,RXO_vsync_o,RXO_de_o,RXE_de_o;

		wire			Rgb_lane0_wren,Rgb_lane1_wren,Rgb_lane2_wren,Rgb_lane3_wren;
		wire[15:0]	Rgb_lane0_wdata,Rgb_lane1_wdata,Rgb_lane2_wdata,Rgb_lane3_wdata;
		wire			Vshsde_wren;
		wire[7:0]	Vshsde_wctrl;

		wire			Rgb_lane0_rden,Rgb_lane1_rden,Rgb_lane2_rden,Rgb_lane3_rden;
		wire[15:0]	Rgb_lane0_rdata,Rgb_lane1_rdata,Rgb_lane2_rdata,Rgb_lane3_rdata;
		wire			Empty_lane0,Empty_lane1,Empty_lane2,Empty_lane3;
		wire			Vshsde_rden;
		wire[7:0]	Vshsde_rctrl;

		wire 			Hs_clk_en;
		wire 			Hs_data_en;
		wire [7:0]	Hs_lane0_data;
		wire [7:0]	Hs_lane1_data;
		wire [7:0]	Hs_lane2_data;
		wire [7:0]	Hs_lane3_data;
		wire [1:0]	Lp_data0,Lp_data1,Lp_data2,Lp_data3;
		wire [1:0]	Lp_clk;

		wire			PWMBL_on_sw;
		wire     	test;
		
wire I_sclk;
wire RXO_hsync_t,RXO_vsync_t,RXO_de_t;
wire[23:0]  RXO_rgb_t,RXE_rgb_t;

wire I_PLL_mipi_lock;
/************************************************/

/*
assign RXO_rgb = {r_R,r_G,r_B};
//assign RXO_rgb = 24'hffffff;
assign RXE_rgb = {r_R1,r_G1,r_B1};

assign  r_R = { rx_d[5] , rx_d[6] , rx_a[1] , rx_a[2] , rx_a[3] , rx_a[4] , rx_a[5] , rx_a[6] };
assign  r_G = { rx_d[3] , rx_d[4] , rx_b[2] , rx_b[3] , rx_b[4] , rx_b[5] , rx_b[6] , rx_a[0] };
assign  r_B = { rx_d[1] , rx_d[2] , rx_c[3] , rx_c[4] , rx_c[5] , rx_c[6] , rx_b[0] , rx_b[1] };
assign  RXO_vsync = rx_c[1];
assign  RXO_hsync = rx_c[2];
assign  RXO_de    = rx_c[0];

assign  r_R1 = { rx_h[5] , rx_h[6] , rx_e[1] , rx_e[2] , rx_e[3] , rx_e[4] , rx_e[5] , rx_e[6] };
assign  r_G1 = { rx_h[3] , rx_h[4] , rx_f[2] , rx_f[3] , rx_f[4] , rx_f[5] , rx_f[6] , rx_e[0] };
assign  r_B1 = { rx_h[1] , rx_h[2] , rx_g[3] , rx_g[4] , rx_g[5] , rx_g[6] , rx_f[0] , rx_f[1] };
assign  RXE_vsync = rx_g[1];
assign  RXE_hsync = rx_g[2];
assign  RXE_de    = rx_g[0];
*/
/*
reg [23:0]  Key_counter;
reg [3:0]   Lcd_dis_mode;
reg [3:0]   Key_cnt;
reg         test1;
reg [7:0] 	test;

always @(posedge sclk)
	begin
			if(RCLK_out_sclk==7'b1100011)
				test[0]<=~test[0];
			else if(RCLK_out_sclk==7'b1000111)
				test[1]<=~test[1];
			else if(RCLK_out_sclk==7'b0001111)
				test[2]<=~test[2];
			else if(RCLK_out_sclk==7'b0011110)
				test[3]<=~test[3];
			else if(RCLK_out_sclk==7'b0111100)
				test[4]<=~test[4];
			else if(RCLK_out_sclk==7'b1111000)
				test[5]<=~test[5];
			else if(RCLK_out_sclk==7'b1110001)
				test[6]<=~test[6];
			else
				test[7]<=~test[7];
	end

always @(posedge RCLK_in)
	begin
			
			Key_counter<=Key_counter+1'b1;
	  	  
			if (Key_counter==0) begin   
				Key_cnt<=Key_cnt+1;                
	     end	 
			if(Key_cnt==0 & Key_counter==1)begin
				test1<=~test1;
				if(Lcd_dis_mode==4'b0111)
				   Lcd_dis_mode<=4'b0000;
				else
				   Lcd_dis_mode<=Lcd_dis_mode+1'b1; 
			end
	end

always @(posedge RCLK_in or negedge RST_n) 
	begin
		if (~RST_n) begin 
        psda <= 4'b0000; //0C
        dutyda <= 4'b1000;
		end
		else
			case(Lcd_dis_mode)
				4'b0000:begin
				  psda <= 4'b0000; //0C
				  dutyda <= 4'b1000;
				end
				4'b0001:begin
				  psda <= 4'b0001; //90C
				  dutyda <= 4'b1001;
				end
				4'b0010:begin
				  psda <= 4'b0010; //90C
				  dutyda <= 4'b1010;
				end			  
				4'b0011:begin
				  psda <= 4'b0011; //90C
				  dutyda <= 4'b1011;
				end					  
				4'b0100:begin     
				  psda <= 4'b0100; //90C
				  dutyda <= 4'b1100;
				end
				4'b0101:begin     
				  psda <= 4'b0101; //90C
				  dutyda <= 4'b1101;
				end					  
				4'b0110:begin     
				  psda <= 4'b0110; //90C
				  dutyda <= 4'b1110;
				end
				4'b0111:begin     
				  psda <= 4'b0111; //180C
				  dutyda <= 4'b1111;
				end
				default:begin
				  psda <= 4'b0100; //90C
				  dutyda <= 4'b1100;
				end  
			endcase
	end

*/

always @(posedge I_clk or negedge RST_n) begin
	if(~RST_n)
		cnt <=0;
	else
	   cnt <= cnt == 1023 ? cnt : cnt + 1'b1;
end

assign reset_n = cnt == 1023 ? 1 : 0;

//--------------------------------------------------------------------
//-- differential lvds signal to single-ended signal
//--------------------------------------------------------------------
/*
lvds_rx         lvds_rx_inst(
.RCLK_in_p      (RCLK_in_p),
.RCLK_in_n      (RCLK_in_n),
.R0_in_p        (R0_in_p),
.R0_in_n        (R0_in_n),
.R1_in_p        (R1_in_p),
.R1_in_n        (R1_in_n),
.R2_in_p        (R2_in_p),
.R2_in_n        (R2_in_n),
.R3_in_p        (R3_in_p),
.R3_in_n        (R3_in_n),

.RCLK_in        (RCLK_in),
.R0_in          (R0_in),
.R1_in          (R1_in),
.R2_in          (R2_in),
.R3_in          (R3_in)
);

lvds_rx         lvds_rx1_inst(
.RCLK_in_p      (RCLK1_in_p),
.RCLK_in_n      (RCLK1_in_n),
.R0_in_p        (R4_in_p),
.R0_in_n        (R4_in_n),
.R1_in_p        (R5_in_p),
.R1_in_n        (R5_in_n),
.R2_in_p        (R6_in_p),
.R2_in_n        (R6_in_n),
.R3_in_p        (R7_in_p),
.R3_in_n        (R7_in_n),

.RCLK_in        (RCLK1_in),
.R0_in          (R4_in),
.R1_in          (R5_in),
.R2_in          (R6_in),
.R3_in          (R7_in)
);
//--------------------------------------------------------------------
//-- create eclk: 3.5x RCLK_IN, dynamic phase 
//--------------------------------------------------------------------
GW_PLL_18       pll_rx_inst(
.clkout         (), //output clkout
.lock           (pll_lock_rx), //output lock
.clkoutp        (eclk), //output clkoutp
.clkin          (RCLK_in), //input clkin

.psda           (psda), //input [3:0] psda
.dutyda         (dutyda), //input [3:0] dutyda
.fdly           (4'b1111) //input [3:0] fdly
);
GW_PLL_18       pll_rx1_inst(
.clkout         (), //output clkout
.lock           (pll_lock_rx1), //output lock
.clkoutp        (eclk1), //output clkoutp
.clkin          (RCLK1_in), //input clkin

.psda           (psda1), //input [3:0] psda
.dutyda         (dutyda1), //input [3:0] dutyda
.fdly           (4'b1111) //input [3:0] fdly
);
//--------------------------------------------------------------------
//-- create sclk: used to ivideo
//--------------------------------------------------------------------
defparam CLKDIV_RX.DIV_MODE = "3.5" ;
CLKDIV          CLKDIV_RX(
.HCLKIN         (eclk),
.RESETN         (1'b1),
.CALIB          (1'b0), //
.CLKOUT         (sclk)
);
defparam CLKDIV_RX1.DIV_MODE = "3.5" ;
CLKDIV          CLKDIV_RX1(
.HCLKIN         (eclk1),
.RESETN         (1'b1),
.CALIB          (1'b0), //
.CLKOUT         (sclk1)
);
//--------------------------------------------------------------------
//-- ivideo: 1:7, output 7b clk and data
//--------------------------------------------------------------------
ivideo_rx       ivideo_rx_inst(
.reset          (~reset_n),
.sclk           (sclk),
.eclk           (eclk),
.calib          (1'b0), 
.RCLK_in        (RCLK_in),
.R0_in          (R0_in),
.R1_in          (R1_in),
.R2_in          (R2_in),
.R3_in          (R3_in),
.clk_phase      (RCLK_out_sclk),
.R0_out         (rx_a_sclk),
.R1_out         (rx_b_sclk),
.R2_out         (rx_c_sclk),
.R3_out         (rx_d_sclk)
);       
ivideo_rx       ivideo_rx1_inst(
.reset          (~reset_n),
.sclk           (sclk1),
.eclk           (eclk1),
.calib          (1'b0), 
.RCLK_in        (RCLK1_in),
.R0_in          (R4_in),
.R1_in          (R5_in),
.R2_in          (R6_in),
.R3_in          (R7_in),
.clk_phase      (RCLK1_out_sclk),
.R0_out         (rx_e_sclk),
.R1_out         (rx_f_sclk),
.R2_out         (rx_g_sclk),
.R3_out         (rx_h_sclk)
);       
//--------------------------------------------------------------------
//-- Automatic bit alignment control
//--------------------------------------------------------------------
bit_align_ctl   bit_aln_ctl_inst
(
.rx_clk         (sclk), 
.reset          (~reset_n),  
.bitalign_en    (pll_lock_rx), 
.rxclk_word     (RCLK_out_sclk),
.lock_flag      (lock_flag),
//.psda           (), //input [3:0] psda
//.dutyda         () //input [3:0] dutyda
.psda           (psda), //input [3:0] psda
.dutyda         (dutyda) //input [3:0] dutyda
);  
bit_align_ctl   bit_aln_ctl1_inst
(
.rx_clk         (sclk1), 
.reset          (~reset_n),  
.bitalign_en    (pll_lock_rx1), 
.rxclk_word     (RCLK1_out_sclk),
.lock_flag      (lock1_flag),
//.psda           (), //input [3:0] psda
//.dutyda         () //input [3:0] dutyda
.psda           (psda1), //input [3:0] psda
.dutyda         (dutyda1) //input [3:0] dutyda
);  
  
//--------------------------------------------------------------------
//-- Word Alignment control 
//--------------------------------------------------------------------
word_align_ctl_m2      word_align_ctl_m2_inst
(
 .clk             (sclk), 
 //.clk_user        (sclk1), 
 .rst_n           (reset_n),  
 .lock_flag       (lock_flag),
 .calib           (),
 .clock_word      (RCLK_out_sclk), 
 .rx_ina          (rx_a_sclk),
 .rx_inb          (rx_b_sclk),
 .rx_inc          (rx_c_sclk),
 .rx_ind          (rx_d_sclk),
 .rx_douta        (rx_a),
 .rx_doutb        (rx_b),
 .rx_doutc        (rx_c),
 .rx_doutd        (rx_d),
.test()
); 
word_align_ctl_m2      word_align1_ctl_m2_inst
(
 .clk             (sclk1), 
 //.clk_user        (sclk1), 
 .rst_n           (reset_n),  
 .lock_flag       (lock1_flag),
 .calib           (),
 .clock_word      (RCLK1_out_sclk), 
 .rx_ina          (rx_e_sclk),
 .rx_inb          (rx_f_sclk),
 .rx_inc          (rx_g_sclk),
 .rx_ind          (rx_h_sclk),
 .rx_douta        (rx_e),
 .rx_doutb        (rx_f),
 .rx_doutc        (rx_g),
 .rx_doutd        (rx_h),
.test()
); */
//--------------------------------------------------------------------
//-- MIPI
//--------------------------------------------------------------------
	//*******************************************************//
	//GW_PLL_mipi
	//*******************************************************//
	GW_PLL_mipi GW_PLL_mipi_inst(
		.clkout(O_lcd_clkos),
		.lock(I_PLL_mipi_lock),
		.clkoutp(O_lcd_clkop),
		.clkin(I_clk),
        .clkoutd3()
		);
    GW_PLL GW_PLL_inst(
       .clkout(I_sclk), //output clkout
		 .lock(),
       .clkin(I_clk) //input clkin
    );

	//defparam clkdiv_ul.DIV_MODE = "4" ;
	//CLKDIV clkdiv_ul (.HCLKIN(O_lcd_clkos), .RESETN(1), .CALIB(0), 
    //.CLKOUT(I_userclk));

	//*******************************************************//
	//syn 2channel rgb24bit to the same clk domain
	//*******************************************************//
	/*	align_2chanLVDSdata  align_2chanLVDSdata_inst(
		.I_rst_n          (reset_n &pll_lock_rx),
		.I_sclk           (sclk),
		.I_sclk1          (sclk1),

		.I_rxo_hsync      (RXO_hsync),
		.I_rxo_vsync      (RXO_vsync),
		.I_rxo_de         (RXO_de),
		.I_rxo_rgb        (RXO_rgb),
		.I_rxe_de         (RXE_de),
		.I_rxe_rgb        (RXE_rgb),

		.O_RXO_hsync      (RXO_hsync_o),
		.O_RXO_vsync      (RXO_vsync_o),
		.O_RXO_de         (RXO_de_o),
		.O_RXO_rgb        (RXO_rgb_o),
		.O_RXE_rgb        (RXE_rgb_o)
		);
*/
//----test colorbar----------------------------------------------------------------
	//*******************************************************//
	//test_data
	//*******************************************************//
		colorbar_test  colorbar_test_inst(
		.rst_n_in          (reset_n),
		.lcd_clkin         (I_sclk),
		.lcd_datain        (RXO_rgb_t),
		.lcd_hsync         (RXO_hsync_t),
		.lcd_vsync         (RXO_vsync_t),
		.lcd_en_n          (RXO_de_t),
		.lcd_datain1       (RXE_rgb_t)
		);

	//*******************************************************//
	//rgb48bit_to4ch16bit_ctrl
	//*******************************************************//
		rgb48bit_to4ch16bit_ctrl  rgb48bit_to4ch16bit_ctrl_inst(
		.I_rst_n          (reset_n),
		.I_sclk           (I_sclk),
		.I_rxo_rgb        (RXO_rgb_t),
		.I_rxo_hsync      (RXO_hsync_t),
		.I_rxo_vsync      (RXO_vsync_t),
		.I_rxo_de         (RXO_de_t),
		.I_rxe_rgb        (RXE_rgb_t),

		.O_rgb_lane0_wren (Rgb_lane0_wren),
		.O_rgb_lane0_data (Rgb_lane0_wdata),
		.O_rgb_lane1_wren (Rgb_lane1_wren),
		.O_rgb_lane1_data (Rgb_lane1_wdata),
		.O_rgb_lane2_wren (Rgb_lane2_wren),
		.O_rgb_lane2_data (Rgb_lane2_wdata),
		.O_rgb_lane3_wren (Rgb_lane3_wren),
		.O_rgb_lane3_data (Rgb_lane3_wdata),
		.O_vshsde_wren    (Vshsde_wren),
		.O_vshsde_ctrl    (Vshsde_wctrl),
        .test()
		);

	//*******************************************************//
	//rgb_data_asyfifo
	//*******************************************************//
		rgb_data_asyfifo  rgb_data_asyfifo_inst(
		.I_rst_n       (reset_n),
		.I_sclk        (I_sclk),
		.I_lcd_clk     (I_userclk),

		.I_rgb_lane0_wren (Rgb_lane0_wren),
		.I_rgb_lane0_data (Rgb_lane0_wdata),
		.I_rgb_lane1_wren (Rgb_lane1_wren),
		.I_rgb_lane1_data (Rgb_lane1_wdata),
		.I_rgb_lane2_wren (Rgb_lane2_wren),
		.I_rgb_lane2_data (Rgb_lane2_wdata),
		.I_rgb_lane3_wren (Rgb_lane3_wren),
		.I_rgb_lane3_data (Rgb_lane3_wdata),
		.I_vshsde_wren    (Vshsde_wren),
		.I_vshsde_ctrl    (Vshsde_wctrl),

		.I_rgb_lane0_rden (Rgb_lane0_rden),
		.O_empty_lane0    (Empty_lane0),
		.O_rgb_lane0_data (Rgb_lane0_rdata),
		.I_rgb_lane1_rden (Rgb_lane1_rden),
		.O_empty_lane1    (Empty_lane1),
		.O_rgb_lane1_data (Rgb_lane1_rdata),
		.I_rgb_lane2_rden (Rgb_lane2_rden),
		.O_empty_lane2    (Empty_lane2),
		.O_rgb_lane2_data (Rgb_lane2_rdata),
		.I_rgb_lane3_rden (Rgb_lane3_rden),
		.O_empty_lane3    (Empty_lane3),
		.O_rgb_lane3_data (Rgb_lane3_rdata),

		.I_vshsde_rden    (Vshsde_rden),
		.O_empty_vshsde   (Empty_vshsde),
		.O_vshsde_ctrl    (Vshsde_rctrl)
		);

	//*******************************************************//
	//mipi_dsi_top
	//*******************************************************//
		mipi_dsi_top  mipi_dsi_top_inst(
		.I_rst_n       (reset_n),
		.I_lcd_clk     (I_userclk),

		.O_rgb_lane0_rden (Rgb_lane0_rden),
		.I_empty_lane0    (Empty_lane0),
		.I_rgb_lane0_data (Rgb_lane0_rdata),
		.O_rgb_lane1_rden (Rgb_lane1_rden),
		.I_empty_lane1    (Empty_lane1),
		.I_rgb_lane1_data (Rgb_lane1_rdata),
		.O_rgb_lane2_rden (Rgb_lane2_rden),
		.I_empty_lane2    (Empty_lane2),
		.I_rgb_lane2_data (Rgb_lane2_rdata),
		.O_rgb_lane3_rden (Rgb_lane3_rden),
		.I_empty_lane3    (Empty_lane3),
		.I_rgb_lane3_data (Rgb_lane3_rdata),

		.O_vshsde_rden    (Vshsde_rden),
		.I_empty_vshsde   (Empty_vshsde),
		.I_vshsde_ctrl    (Vshsde_rctrl),

//		.O_data_rden      (O_data_rden),

		.O_hs_clk_en      (Hs_clk_en),
		.O_hs_data_en     (Hs_data_en),
		.O_hs_lane0_data  (Hs_lane0_data),
		.O_hs_lane1_data  (Hs_lane1_data),
		.O_hs_lane2_data  (Hs_lane2_data),
		.O_hs_lane3_data  (Hs_lane3_data),
		.O_lp_data_lane0  (Lp_data0),
		.O_lp_data_lane1  (Lp_data1),
		.O_lp_data_lane2  (Lp_data2),
		.O_lp_data_lane3  (Lp_data3),
		.O_lp_clk         (Lp_clk),
		.O_VBL_on_sw      (O_lcd_led_en),
		.O_PWMBL_on_sw    (PWMBL_on_sw),
		.test_mipi()

		);

	//*******************************************************//
	//GW_PLL_mipi 4wire mipi realization(same as 4K mipi output solution)
	//*******************************************************//
/*		mipi_dphy_tx MIPI_DPHY_tx_inst 
		(              
		.HS_CLK_P        (O_hs_clk_p),                //HS (High Speed) Clock
		.HS_CLK_N        (O_hs_clk_n),              //HS (High Speed) Clock       
		.HS_DATA0_P      (O_hs_d0_p),                     //HS (High Speed) Data Lane 0     
		.HS_DATA0_N      (O_hs_d0_n),                    //HS (High Speed) Data Lane 0  
		.HS_DATA1_P      (O_hs_d1_p),                     //HS (High Speed) Data Lane 1     
		.HS_DATA1_N      (O_hs_d1_n),                    //HS (High Speed) Data Lane 1  
		.HS_DATA2_P      (O_hs_d2_p),                     //HS (High Speed) Data Lane 2     
		.HS_DATA2_N      (O_hs_d2_n),                    //HS (High Speed) Data Lane 2  
		.HS_DATA3_P      (O_hs_d3_p),                     //HS (High Speed) Data Lane 3     
		.HS_DATA3_N      (O_hs_d3_n),                    //HS (High Speed) Data Lane 3  


		.LP_CLK_P        (O_lp_clk_p),                //LP (Lower Power) Clock
		.LP_CLK_N        (O_lp_clk_n),              //LP (Lower Power) Clock       
		.LP_DATA0_P      (O_lp_d0_p),                     //LP (Lower Power) Data Lane 0     
		.LP_DATA0_N      (O_lp_d0_n),                    //LP (Lower Power) Data Lane 0  
		.LP_DATA1_P      (O_lp_d1_p),                     //LP (Lower Power) Data Lane 1     
		.LP_DATA1_N      (O_lp_d1_n),                    //LP (Lower Power) Data Lane 1  
		.LP_DATA2_P      (O_lp_d2_p),                     //LP (Lower Power) Data Lane 2     
		.LP_DATA2_N      (O_lp_d2_n),                    //LP (Lower Power) Data Lane 2  
		.LP_DATA3_P      (O_lp_d3_p),                     //LP (Lower Power) Data Lane 3     
		.LP_DATA3_N      (O_lp_d3_n),                    //LP (Lower Power) Data Lane 3  

		.O_userclk      (I_userclk),                    //

		.test      (test),                    //
		.reset_n         (reset_n),              //Resets the Design  
		.clk_bit_90      (O_lcd_clkop),                //HS (High Speed) Clock
		.clk_bit         (O_lcd_clkos),              //HS (High Speed) Clock       
		.data_in0        (Hs_lane0_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in1        (Hs_lane1_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in2        (Hs_lane2_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in3        (Hs_lane3_data),             //HS (High Speed) Byte Data, Lane 0      
		.lp_clk_out      (Lp_clk),             
		.lp_data0_out    (Lp_data0),    
		.lp_data1_out    (Lp_data1),    
		.lp_data2_out    (Lp_data2),    
		.lp_data3_out    (Lp_data3),    
		.hs_clk_en       (Hs_clk_en),         
		.hs_data_en      (Hs_data_en)   
		); 
*/
		wire O_lcd_clkop_wire,O_lcd_clkos_wire;
		wire stop_O;
		wire mipi_tx_rst;

		serdes_rst_ctrl serdes_rst_ctrl_mipi(
		  .I_clk(I_clk),
		  .I_rst_n(reset_n),
		  .I_pll_lock(I_PLL_mipi_lock),
		  .O_clk_stop(stop_O),
		  .O_serdes_rst(mipi_tx_rst)
		);


		//DHCEN
		DHCEN DHCEN_ECLK_OP(
		.CLKOUT(O_lcd_clkop_wire),
		.CLKIN(O_lcd_clkop),
		.CE(stop_O)
		);
		DHCEN DHCEN_ECLK_OS(
		.CLKOUT(O_lcd_clkos_wire),
		.CLKIN(O_lcd_clkos),
		.CE(stop_O)
		) ;

		DPHY_TX_TOP MIPI_DPHY_tx_inst 
		(              
		.HS_CLK_P        (O_hs_clk_p),                //HS (High Speed) Clock
		.HS_CLK_N        (O_hs_clk_n),              //HS (High Speed) Clock       
		.HS_DATA0_P      (O_hs_d0_p),                     //HS (High Speed) Data Lane 0     
		.HS_DATA0_N      (O_hs_d0_n),                    //HS (High Speed) Data Lane 0  
		.HS_DATA1_P      (O_hs_d1_p),                     //HS (High Speed) Data Lane 1     
		.HS_DATA1_N      (O_hs_d1_n),                    //HS (High Speed) Data Lane 1  
		.HS_DATA2_P      (O_hs_d2_p),                     //HS (High Speed) Data Lane 2     
		.HS_DATA2_N      (O_hs_d2_n),                    //HS (High Speed) Data Lane 2  
		.HS_DATA3_P      (O_hs_d3_p),                     //HS (High Speed) Data Lane 3     
		.HS_DATA3_N      (O_hs_d3_n),                    //HS (High Speed) Data Lane 3  


		.LP_CLK        ({O_lp_clk_p,O_lp_clk_n}),                //LP (Lower Power) Clock
		.LP_DATA0      ({O_lp_d0_p,O_lp_d0_n}),                     //LP (Lower Power) Data Lane 0     
		.LP_DATA1      ({O_lp_d1_p,O_lp_d1_n}),                     //LP (Lower Power) Data Lane 1     
		.LP_DATA2      ({O_lp_d2_p,O_lp_d2_n}),                     //LP (Lower Power) Data Lane 2     
		.LP_DATA3      ({O_lp_d3_p,O_lp_d3_n}),                     //LP (Lower Power) Data Lane 3     

		.sclk      (I_userclk),                    //

		.reset_n         (~mipi_tx_rst),              //Resets the Design  
		.clk_bit_90      (O_lcd_clkop_wire),                //HS (High Speed) Clock
		.clk_bit         (O_lcd_clkos_wire),              //HS (High Speed) Clock       
		.data_in0        (Hs_lane0_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in1        (Hs_lane1_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in2        (Hs_lane2_data),             //HS (High Speed) Byte Data, Lane 0      
		.data_in3        (Hs_lane3_data),             //HS (High Speed) Byte Data, Lane 0      
		.lp_clk_out      (Lp_clk),             
		.lp_data0_out    (Lp_data0),    
		.lp_data1_out    (Lp_data1),    
		.lp_data2_out    (Lp_data2),    
		.lp_data3_out    (Lp_data3),    
		.hs_clk_en       (Hs_clk_en),         
		.hs_data_en      (Hs_data_en),
		.lp_clk_in      (),             
		.lp_clk_dir      (1'b1),             
		.lp_data0_in    (),    
		.lp_data0_dir    (1'b1),     
		.lp_data1_in    (),    
		.lp_data1_dir    (1'b1),     
		.lp_data2_in    (),    
		.lp_data2_dir    (1'b1),     
		.lp_data3_in    (),    
		.lp_data3_dir    (1'b1)    
		); 


	lcd_backlight_ctrl lcd_backlight_ctrl_inst(
		.I_rst_n         (reset_n),              //Resets the Design  
		.I_clk           (I_clk),       
		.I_PWMBL_on_sw   (PWMBL_on_sw),           
		.O_lcd_pwm        (O_lcd_led_pwm)               
	);


//--------------------------------------------------------------------
//-- MIPI
//--------------------------------------------------------------------

endmodule
