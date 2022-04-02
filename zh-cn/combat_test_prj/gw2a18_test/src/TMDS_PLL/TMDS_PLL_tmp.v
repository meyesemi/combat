//Copyright (C)2014-2019 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.2.02Beta
//Part Number: GW2A-LV18PG484C8/I7
//Created Time: Fri Jul 31 15:48:09 2020

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    TMDS_PLL your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkin(clkin_i) //input clkin
    );

//--------Copy end-------------------
