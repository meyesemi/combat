//Copyright (C)2014-2020 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.6.01Beta
//Part Number: GW2A-LV18PG484C7/I6
//Created Time: Thu Aug 06 16:55:41 2020

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    TMDS_pll your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkin(clkin_i) //input clkin
    );

//--------Copy end-------------------
