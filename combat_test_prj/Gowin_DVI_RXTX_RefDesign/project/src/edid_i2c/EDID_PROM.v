// ==============0ooo===================================================0ooo===========
// =  Copyright (C) 2014-2020 Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// ====================================================================================
// 
//  __      __      __
//  \ \    /  \    / /   [File name   ] EDID_PROM.v
//   \ \  / /\ \  / /    [Description ] EDID_PROM
//    \ \/ /  \ \/ /     [Timestamp   ] Friday April 3 14:00:30 2020
//     \  /    \  /      [version     ] 1.0
//      \/      \/
//
// ==============0ooo===================================================0ooo===========
// Code Revision History :
// ----------------------------------------------------------------------------------
// Ver:    |  Author    | Mod. Date    | Changes Made:
// ----------------------------------------------------------------------------------
// V1.0.0  | Caojie     | 05/28/20     | Initial version 
// ----------------------------------------------------------------------------------
// ==============0ooo===================================================0ooo===========

`timescale 1ns/1ps

`include "EDID_PROM_defines.v"

module EDID_PROM 
(
	input clk    , //>= 5MHz, <=200MHz 
	input rst_n  ,
`ifdef  RAM  
	input wp     ,
`endif
	input scl    ,
	inout sda
);
  
I2C_SLAVE_Top  I2C_SLAVE_Top_inst 
( 
	.clk  (clk    ),
	.rstn (rst_n  ),
`ifdef  RAM  
	.wp   (wp     ),
`endif
	.scl  (scl    ),
	.sda  (sda    ),
	.int_o(       ) 
);

endmodule



