
`timescale 1 ns / 100 ps

module serdes_rst_ctrl(
								input		I_clk,
								input		I_rst_n,
								input 		I_pll_lock,
							 	//Outputs
								output reg	O_clk_stop,
								output reg	O_serdes_rst
								);
	/*******************************************************************************
 	* MIPI DSI hs mode FSM States defined
 	*******************************************************************************/
	parameter STATE_IDLE           	= 5'b0000;
	parameter STATE_SERDES_STOP_S  	= 5'b0001;
	parameter STATE_SERDES_RST_S    = 5'b0010;
	parameter STATE_SERDES_RST_E    = 5'b0011;
	parameter STATE_SERDES_STOP_E  	= 5'b0100;
	parameter STATE_SERDES_WAIT  	= 5'b0101;
	/*******************************************************************************
	//reg and wire definition
	 *******************************************************************************/
	reg [4:0] Fsm_serdes_rst_ctrl;
	reg [8:0] Cnt_serdes_rst_ctrl;
 /*******************************************************************************/
 /*******************************************************************************/ 
	always @(posedge I_clk or negedge I_rst_n) 
	begin
		if (~I_rst_n) begin 
			Fsm_serdes_rst_ctrl<=STATE_IDLE;
			Cnt_serdes_rst_ctrl<=0;
			O_clk_stop<=0;
			O_serdes_rst<=0;
		end
		else begin
			case(Fsm_serdes_rst_ctrl)
				STATE_IDLE:begin//idle
					if(I_pll_lock)
						Fsm_serdes_rst_ctrl<=STATE_SERDES_STOP_S;
					Cnt_serdes_rst_ctrl<=0;
					O_clk_stop<=0;
					O_serdes_rst<=0;
				end
				STATE_SERDES_STOP_S:begin
					Cnt_serdes_rst_ctrl<=Cnt_serdes_rst_ctrl+1;
					if(Cnt_serdes_rst_ctrl[6])begin
						O_clk_stop<=1;
						Fsm_serdes_rst_ctrl<=STATE_SERDES_RST_S;
					end
					else begin
						O_clk_stop<=0;
					end
				end
				STATE_SERDES_RST_S:begin
					Cnt_serdes_rst_ctrl<=Cnt_serdes_rst_ctrl+1;
					if(Cnt_serdes_rst_ctrl[5])begin
						O_serdes_rst<=1;
						Fsm_serdes_rst_ctrl<=STATE_SERDES_RST_E;
					end
				end
				STATE_SERDES_RST_E:begin
					Cnt_serdes_rst_ctrl<=Cnt_serdes_rst_ctrl+1;
					if(Cnt_serdes_rst_ctrl[3])begin
						O_serdes_rst<=0;
						Fsm_serdes_rst_ctrl<=STATE_SERDES_STOP_E;
					end
				end
				STATE_SERDES_STOP_E:begin
					Cnt_serdes_rst_ctrl<=Cnt_serdes_rst_ctrl+1;
					if(Cnt_serdes_rst_ctrl[7])begin
						O_clk_stop<=0;
						Fsm_serdes_rst_ctrl<=STATE_SERDES_WAIT;
					end
				end
				STATE_SERDES_WAIT:begin
					if(~I_pll_lock)begin
						Fsm_serdes_rst_ctrl<=STATE_IDLE;
					end
				end
				default:begin
					Fsm_serdes_rst_ctrl<=STATE_IDLE;
				end
			endcase
		end
	end

endmodule
