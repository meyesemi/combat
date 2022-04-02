//Copyright (C)2014-2020 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.6.01Beta
//Part Number: GW1N-LV9LQ144C6/I5
//Created Time: Mon Aug 10 19:27:13 2020

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    GW_PLL_mipi your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkoutp(clkoutp_o), //output clkoutp
        .clkoutd3(clkoutd3_o), //output clkoutd3
        .clkin(clkin_i) //input clkin
    );

//--------Copy end-------------------
