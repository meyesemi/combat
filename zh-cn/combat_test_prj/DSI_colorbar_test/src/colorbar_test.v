module colorbar_test
(
input lcd_clkin,
input rst_n_in,
output lcd_en_n,
output lcd_hsync,
output lcd_vsync,
output reg[23:0] lcd_datain,
output reg[23:0] lcd_datain1
);
 
parameter H_FRONT_PORCH = 20;
parameter H_ACTIVE_HALF = 960;
//parameter H_ACTIVE = 1920;
parameter H_BACK_PORCH = 20;
parameter H_SYNC = 20;
parameter V_FRONT_PORCH = 8;
parameter V_ACTIVE = 1200;
parameter V_BACK_PORCH = 5;
parameter V_SYNC = 5;

parameter H_TOTAL = H_FRONT_PORCH+H_ACTIVE_HALF+H_BACK_PORCH+H_SYNC;
parameter V_TOTAL = V_ACTIVE+V_FRONT_PORCH+V_BACK_PORCH+V_SYNC;


//internal signals
reg hsync_r;
reg vsync_r;
reg en_n_r;

reg[11:0] h_cnt;
reg[11:0] v_cnt;
reg[11:0] color_cnt;

assign lcd_en_n = en_n_r;
//assign lcd_hsync = 1'b1;
//assign lcd_vsync = 1'b1;

assign lcd_hsync = ~hsync_r;
assign lcd_vsync = ~vsync_r;

always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
    h_cnt <= 0;
  else begin
  if(h_cnt < H_TOTAL-1)
     h_cnt <= h_cnt + 'd1;
    else
  h_cnt <= 0;
 end
end


always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
  begin
 v_cnt <= 'd0;
  end
 else 
 if(h_cnt ==H_TOTAL-1)
  begin
  if(v_cnt < V_TOTAL-1)
  v_cnt <=v_cnt+1;
  else
  v_cnt <= 'd0;
   end
end

always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
  begin
    vsync_r <= 'd1;
  end
  else if(v_cnt <V_SYNC)
  begin
    vsync_r <= 'd0;
  end
  else
  begin
    vsync_r <= 'd1;
  end
end

always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
  begin
    hsync_r <= 'd1;
  end 
  else if(h_cnt< H_SYNC)
  begin
    hsync_r <= 'd0;
  end
  else
  begin
    hsync_r <= 'd1;
  end
end

always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
  begin
 en_n_r <= 'd0;
  end
  else if((h_cnt >=H_BACK_PORCH+H_SYNC)&&(h_cnt < H_ACTIVE_HALF+H_BACK_PORCH+H_SYNC)&&(v_cnt >= V_SYNC+V_BACK_PORCH)&&(v_cnt < V_SYNC+V_BACK_PORCH+V_ACTIVE))
  begin
 en_n_r <= 'd1;
  end
  else
  begin
    en_n_r <= 'd0;
  end
end

always@(posedge lcd_clkin or negedge rst_n_in)
begin
  if(!rst_n_in)
  begin 
    color_cnt <= 'd0;
  end
  else if((h_cnt >=H_BACK_PORCH+H_SYNC)&&(h_cnt < H_ACTIVE_HALF+H_BACK_PORCH+H_SYNC)&&(v_cnt >= V_SYNC+V_BACK_PORCH)&&(v_cnt < V_SYNC+V_BACK_PORCH+V_ACTIVE))
  begin
        color_cnt <= color_cnt+1;
       lcd_datain[23:0] <= color_cnt < 240 ? {8'hFF, 8'h00, 8'h00} :
                                  color_cnt < 480 ? {8'h00, 8'hFF, 8'h00} : 
                                  color_cnt < 720 ? {8'h00, 8'h00, 8'hFF} :  
                                  color_cnt < 960 ? {8'hFF, 8'hff, 8'hff} : {8'h00, 8'h00, 8'h00};     

        lcd_datain1[23:0] <= color_cnt < 240 ? {8'hFF, 8'h00, 8'h00} :
                                  color_cnt < 480 ? {8'h00, 8'hFF, 8'h00} : 
                                  color_cnt < 720 ? {8'h00, 8'h00, 8'hFF} :  
                                  color_cnt < 960 ? {8'hFF, 8'hff, 8'hff} : {8'h00, 8'h00, 8'h00};     
/* 
        lcd_datain[23:0] <= color_cnt < 240 ? {8'h00, 8'h00, 8'h00} :
                                  color_cnt < 480 ? {8'h00, 8'h00, 8'h00} : 
                                  color_cnt < 720 ? {8'h00, 8'h00, 8'h00} :  
                                  color_cnt < 960 ? {8'h00, 8'h00, 8'h00} : {8'h00, 8'h00, 8'h00};     

        lcd_datain1[23:0] <= color_cnt < 240 ? {8'h00, 8'h00, 8'h00} :
                                  color_cnt < 480 ? {8'h00, 8'h00, 8'h00} : 
                                  color_cnt < 720 ? {8'h00, 8'h00, 8'h00} :  
                                  color_cnt < 960 ? {8'h00, 8'h00, 8'h00} : {8'h00, 8'h00, 8'h00};     

        lcd_datain[23:0] <= color_cnt < 240 ? {8'hff, 8'hff, 8'hff} :
                                  color_cnt < 480 ? {8'hff, 8'hff, 8'hff} : 
                                  color_cnt < 720 ? {8'hff, 8'hff, 8'hff} :  
                                  color_cnt < 960 ? {8'hff, 8'hff, 8'hff} : {8'h00, 8'h00, 8'h00};     

        lcd_datain1[23:0] <= color_cnt < 240 ? {8'hff, 8'hff, 8'hff} :
                                  color_cnt < 480 ? {8'hff, 8'hff, 8'hff} : 
                                  color_cnt < 720 ? {8'hff, 8'hff, 8'hff} :  
                                  color_cnt < 960 ? {8'hff, 8'hff, 8'hff} : {8'h00, 8'h00, 8'h00};     
*/ 
  end
  else begin
    color_cnt <= 0;
    lcd_datain[23:0] <=0;
    lcd_datain1[23:0] <=0;

  end
end

endmodule