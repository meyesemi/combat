module afifo (
	rdata, 
	//rdata_keep,
	full, 
	afull,
	empty, 
	aempty,
	wdata,
	wen, 
	wclk, 
	wrst_n, 
	ren, 
	rclk, 
	rrst_n
);
parameter DATASIZE = 16;
parameter ADDRSIZE = 4;


output [DATASIZE-1:0] rdata;
//output [DATASIZE-1:0] rdata_keep;

output full,afull;
output empty,aempty;
input [DATASIZE-1:0] wdata;
input wen, wclk, wrst_n;
input ren, rclk, rrst_n;


Asyn_Fifo #(
    
	.L (ADDRSIZE),        //Fifo Depth = 2^L+2;
	.DW(DATASIZE)        //Data Width = DW;
) asyn_fifo
(
  
	.w_clk    (wclk),
	.w_clr    (wrst_n),
	.w_data   (wdata),
	.w_we     (wen),
	.w_full   (full),
	.w_afull  (afull),
	.r_clr    (rrst_n),
	.r_clk    (rclk),
	.r_data   (rdata),
	//.r_data_keep   (rdata_keep),
	.r_re     (ren),
	.r_empty  (empty),
	.r_aempty (aempty)
);



endmodule
