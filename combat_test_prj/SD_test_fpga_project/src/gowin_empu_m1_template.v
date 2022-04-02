`resetall

module Gowin_EMPU_M1_template (
  LOCKUP,
  HALTED,
  GPIO,
  JTAG_3,   //trstn
  JTAG_4,   //NC
  JTAG_5,   //tdi
  JTAG_6,   //NC
  JTAG_7,   //tms   |       swdio
  JTAG_8,   //extFlash_sspi2_sio3/holdn
  JTAG_9,   //tck   |       swclk
  JTAG_10,  //extFlash_spi2_mosi/sio1
  JTAG_11,  //NC    |       
  JTAG_12,  //extFlash_spi2_sclk
  JTAG_13,  //tdo   |       swo
  JTAG_14,  //extFlash_spi2_miso/sio0
  JTAG_15,  //srstn
  JTAG_16,  //extFlash_spi2_cs
  JTAG_17,  //NC
  JTAG_18,  //extFlash_sspi2_sio2/WPn

  UART0RXD,
  UART0TXD,
/*
  UART1RXD,
  UART1TXD,
  TIMER0EXTIN,
  TIMER1EXTIN,
  RTCSRCCLK,
*/

/*
  SCL,
  SDA,
  MOSI,   //SPI output
  MISO,   //SPI input
  SCLK,   //SPI clock
  NSS,    //SPI chip select
*/

  SD_CLK,
  SD_CS,
  SD_DATAIN,
  SD_DATAOUT,
  SD_CARD_INIT, //0:ok
  SD_CHECKIN,
  SD_CHECKOUT,
/*
  RGMII_TXC,
  RGMII_TX_CTL,
  RGMII_TXD,
  RGMII_RXC,  
  RGMII_RX_CTL,    
  RGMII_RXD,
  MDC,
  MDIO,
*/


  FLASH_SPI_HOLDN,
  FLASH_SPI_CSN,
  FLASH_SPI_MISO,
  FLASH_SPI_MOSI,
  FLASH_SPI_WPN,
  FLASH_SPI_CLK,


  HCLK,		//System Clock
  hwRstn	//System Reset
);

//JTAG
inout JTAG_3;
inout JTAG_4;
inout JTAG_5;
inout JTAG_6;
inout JTAG_7;
inout JTAG_8;
inout JTAG_9;
inout JTAG_10;
inout JTAG_11;
inout JTAG_12;
inout JTAG_13;
inout JTAG_14;
inout JTAG_15;
inout JTAG_16;
inout JTAG_17;
inout JTAG_18;

input HCLK;          // System clock
input hwRstn;        // System reset

/*
//RTC
input RTCSRCCLK;
*/
//GPIO
inout [15:0] GPIO;

output LOCKUP;        // Core is in lockup state
output HALTED;        // Core is in Halt debug state

//UART0
input UART0RXD;
output UART0TXD;

/*
//UART1
input UART1RXD;
output UART1TXD;

//Timer0
input TIMER0EXTIN;

//Timer1
input TIMER1EXTIN;
*/

/*
//I2C
inout SCL;
inout SDA;

//SPI
output MOSI;   // SPI output
input MISO;    // SPI input
output SCLK;   // SPI clock
output NSS;    // SPI chip select
*/


//SD-Card
output SD_CLK;				
output SD_CS;
output SD_CHECKOUT;
output SD_DATAOUT;
output SD_CARD_INIT; //0:ok
input SD_CHECKIN;
input SD_DATAIN;

/*
//Ethernet
output RGMII_TXC;
output RGMII_TX_CTL;
output [3:0] RGMII_TXD;
input RGMII_RXC;  
input RGMII_RX_CTL;    
input [3:0] RGMII_RXD;
output MDC;
inout MDIO;
*/


//SPI-Flash
inout FLASH_SPI_HOLDN;
inout FLASH_SPI_CSN;
inout FLASH_SPI_MISO;
inout FLASH_SPI_MOSI;
inout FLASH_SPI_WPN;
inout FLASH_SPI_CLK;


wire GTX_CLK;       //125MHz RGMII clock input
wire MCU_CLK;       //50MHz
wire clkin = HCLK;  //50MHz
Gowin_PLL inst_PLL (
  .clkout(GTX_CLK),
  .clkoutp(MCU_CLK),
  .clkin(clkin)
);

wire SD_SPICLK;//30M SDCard SPI clock
Gowin_rPLL inst_rPLL(
  .clkout(SD_SPICLK),
  .clkin(clkin)
);

Gowin_EMPU_M1_Top M1_template (
  .LOCKUP(LOCKUP),
  .HALTED(HALTED),
  .GPIO(GPIO),
  .JTAG_3(JTAG_3),   //trstn
  .JTAG_4(JTAG_4),   //NC
  .JTAG_5(JTAG_5),   //tdi
  .JTAG_6(JTAG_6),   //NC
  .JTAG_7(JTAG_7),   //tms   |       swdio
  .JTAG_8(JTAG_8),   //extFlash_sspi2_sio3/holdn
  .JTAG_9(JTAG_9),   //tck   |       swclk
  .JTAG_10(JTAG_10),  //extFlash_spi2_mosi/sio1
  .JTAG_11(JTAG_11),  //NC    |       
  .JTAG_12(JTAG_12),  //extFlash_spi2_sclk
  .JTAG_13(JTAG_13),  //tdo   |       swo
  .JTAG_14(JTAG_14),  //extFlash_spi2_miso/sio0
  .JTAG_15(JTAG_15),  //srstn
  .JTAG_16(JTAG_16),  //extFlash_spi2_cs
  .JTAG_17(JTAG_17),  //NC
  .JTAG_18(JTAG_18),  //extFlash_sspi2_sio2/WPn
  .UART0RXD(UART0RXD),
  .UART0TXD(UART0TXD),

/*
  .UART1RXD(UART1RXD),
  .UART1TXD(UART1TXD),
  .TIMER0EXTIN(TIMER0EXTIN),
  .TIMER1EXTIN(TIMER1EXTIN),
  .RTCSRCCLK(RTCSRCCLK),
*/

/*
  .SCL(SCL),
  .SDA(SDA),

  .MOSI(MOSI),   // SPI output
  .MISO(MISO),   // SPI input
  .SCLK(SCLK),   // SPI clock
  .NSS(NSS),
*/

  .SD_SPICLK(SD_SPICLK),
  .SD_CLK(SD_CLK),				
  .SD_CS(SD_CS),
  .SD_DATAIN(SD_DATAIN),
  .SD_DATAOUT(SD_DATAOUT),
  .SD_CARD_INIT(SD_CARD_INIT), //0:ok
  .SD_CHECKIN(SD_CHECKIN),
  .SD_CHECKOUT(SD_CHECKOUT),
/*
  .RGMII_TXC(RGMII_TXC),
  .RGMII_TX_CTL(RGMII_TX_CTL),
  .RGMII_TXD(RGMII_TXD),
  .RGMII_RXC(RGMII_RXC),  
  .RGMII_RX_CTL(RGMII_RX_CTL),    
  .RGMII_RXD(RGMII_RXD),
  .GTX_CLK(GTX_CLK),
  .MDC(MDC),
  .MDIO(MDIO),
*/

    

  .FLASH_SPI_HOLDN(FLASH_SPI_HOLDN),
  .FLASH_SPI_CSN(FLASH_SPI_CSN),
  .FLASH_SPI_MISO(FLASH_SPI_MISO),
  .FLASH_SPI_MOSI(FLASH_SPI_MOSI),
  .FLASH_SPI_WPN(FLASH_SPI_WPN),
  .FLASH_SPI_CLK(FLASH_SPI_CLK),

  .HCLK(MCU_CLK),		//System Clock
  .hwRstn(hwRstn)	//System Reset
);

endmodule