//========Oooo=========================================Oooo========
//=     Copyright ©2015-2016 Gowin Semiconductor Corporation.     =
//=                     All rights reserved.                      =
//========Oooo=========================================Oooo========

// gwModGen version: 1.6.2Beta
// Thu Nov 10 18:07:47 2016

//Template file for instantiation
//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    GW_PLL your_instance_name(
        .clkout(clkout_o), //output clkout
        .lock(lock_o), //output lock
        .clkoutp(clkoutp_o), //output clkoutp
        .clkin(clkin_i) //input clkin
    );

//--------Copy end-------------------
