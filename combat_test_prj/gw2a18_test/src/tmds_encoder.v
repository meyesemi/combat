`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date: 2019-09-16 19:46
// Design Name: 
// Module Name: tmds_encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: change from xilinx xapp495
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1

module tmds_encoder (
    input            pix_clk,  // pixel clock input
    input            rstn,     // async. reset input (active low)
    input      [7:0] din,      // data inputs: expect registered
    input            c0,       // c0 input
    input            c1,       // c1 input
    input            de,       // de input
    output reg [9:0] dout      // data outputs
);

    //==========================================================================
    // Counting number of 1s and 0s for each incoming pixel
    // component. Pipe line the result.
    // Register Data Input so it matches the pipe lined adder
    // output
    //==========================================================================
    reg [3:0] n1d; //number of 1s in din
    reg [7:0] din_q;
    
    always @ (posedge pix_clk) 
    begin
        n1d <= `UD din[0] + din[1] + din[2] + din[3] + din[4] + din[5] + din[6] + din[7];
    
        din_q <= `UD din;
    end
    
    //==========================================================================
    // Stage 1: 8 bit -> 9 bit
    // Refer to DVI 1.0 Specification, page 29, Figure 3-5
    // if((n1d > 4'h4) | ((n1d == 4'h4) & (din_q[0] == 1'b0)))
    //     qm[0] = D[0]
    //     qm[n] = qm[n-1] ~^ D[n];
    //     
    // else
    //     qm[0] = D[0]
    //     qm[n] = qm[n-1] ^ D[n];
    // qm[8] = ~((n1d > 4'h4) | ((n1d == 4'h4) & (din_q[0] == 1'b0)))
    //==========================================================================
    wire decision1;
    
    assign decision1 = (n1d > 4'h4) | ((n1d == 4'h4) & (din_q[0] == 1'b0));

    wire [8:0] q_m;
    assign q_m[0] = din_q[0];
    
    assign q_m[1] = (decision1) ? (q_m[0] ^~ din_q[1]) : (q_m[0] ^ din_q[1]);
    assign q_m[2] = (decision1) ? (q_m[1] ^~ din_q[2]) : (q_m[1] ^ din_q[2]);
    assign q_m[3] = (decision1) ? (q_m[2] ^~ din_q[3]) : (q_m[2] ^ din_q[3]);
    assign q_m[4] = (decision1) ? (q_m[3] ^~ din_q[4]) : (q_m[3] ^ din_q[4]);
    assign q_m[5] = (decision1) ? (q_m[4] ^~ din_q[5]) : (q_m[4] ^ din_q[5]);
    assign q_m[6] = (decision1) ? (q_m[5] ^~ din_q[6]) : (q_m[5] ^ din_q[6]);
    assign q_m[7] = (decision1) ? (q_m[6] ^~ din_q[7]) : (q_m[6] ^ din_q[7]);
    
//    generate
//       genvar  i;
//       for (i = 1; i < 8; i = i + 1)
//       begin
//           assign q_m[i] = (decision1) ? (q_m[i-1'b1] ^~ din_q[i]) : (q_m[i-1'b1] ^ din_q[i]);
//       end
//    endgenerate
    
    assign q_m[8] = (decision1) ? 1'b0 : 1'b1;
    
    //==========================================================================
    // Stage 2: 9 bit -> 10 bit
    // Refer to DVI 1.0 Specification, page 29, Figure 3-5
    // caculate the numbers of 1 or 0
    //==========================================================================
    reg [3:0] n1q_m, n0q_m; // number of 1s and 0s for q_m
    always @ (posedge pix_clk) begin
        n1q_m  <= `UD q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7];
        n0q_m  <= `UD 4'h8 - (q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7]);
    end
    
    parameter CTRLTOKEN0 = 10'b1101010100;
    parameter CTRLTOKEN1 = 10'b0010101011;
    parameter CTRLTOKEN2 = 10'b0101010100;
    parameter CTRLTOKEN3 = 10'b1010101011;
    
    reg signed [4:0] cnt; //disparity counter, MSB is the sign bit
    wire decision2, decision3;
    
    assign decision2 = (cnt == 5'h0) | (n1q_m == n0q_m);
    
    //==========================================================================
    // [(cnt > 0) and (N1q_m > N0q_m)] or [(cnt < 0) and (N0q_m > N1q_m)]
    // cnt ��ֵ��ʾ�ۼǴ���1�࣬��ֵ��ʾ�ۼƴ���0��
    // ����1��ʱ����ǰ1����ֵ��0�ࡢ���ߴ���0��ʱ����ǰ0��1�ࣺ
    //            ��q_m[7:0]ȡ����
    // ����ʷ�����뵱ǰ����1��0��ƽ�⣬�򲻶�q_m[7:0]����,ʹ�ô����1��0����������һ��ƽ��
    //==========================================================================
    assign decision3 = (~cnt[4] & (n1q_m > n0q_m)) | (cnt[4] & (n0q_m > n1q_m));
    
    ////////////////////////////////////
    // pipe line alignment
    ////////////////////////////////////
    reg       de_q, de_reg;
    reg       c0_q, c1_q;
    reg       c0_reg, c1_reg;
    reg [8:0] q_m_reg;
    
    always @ (posedge pix_clk) 
    begin
        de_q    <= `UD de;
        de_reg  <= `UD de_q;
        
        c0_q    <= `UD c0;
        c0_reg  <= `UD c0_q;
        c1_q    <= `UD c1;
        c1_reg  <= `UD c1_q;
        
        q_m_reg <= `UD q_m;
    end
    
    ///////////////////////////////
    // 10-bit out
    // disparity counter
    ///////////////////////////////
    always @ (posedge pix_clk) 
    begin
        if(~rstn) 
        begin
            dout <= 10'h0;
            cnt <= 5'h0;
        end 
        else 
        begin
            if (de_reg)  //active pixels  DE == HIGH
            begin
                if(decision2) //�ۼƴ���1��0������һ�� �� �ߵ�ǰ0��1����ֵһ��
                begin
                    dout[9]   <= `UD ~q_m_reg[8]; 
                    dout[8]   <= `UD q_m_reg[8]; 
                    dout[7:0] <= `UD (q_m_reg[8]) ? q_m_reg[7:0] : ~q_m_reg[7:0];
                    cnt <= `UD (~q_m_reg[8]) ? (cnt + n0q_m - n1q_m) : (cnt + n1q_m - n0q_m);
                end 
                else 
                begin
                    if(decision3) // 
                    begin
                        dout[9]   <= `UD 1'b1;
                        dout[8]   <= `UD q_m_reg[8];
                        dout[7:0] <= `UD ~q_m_reg[7:0];
                        
                        cnt <= `UD cnt + {q_m_reg[8], 1'b0} + (n0q_m - n1q_m);
                    end 
                    else 
                    begin
                        dout[9]   <= `UD 1'b0;
                        dout[8]   <= `UD q_m_reg[8];
                        dout[7:0] <= `UD q_m_reg[7:0];
                        
                        cnt <= `UD cnt - {~q_m_reg[8], 1'b0} + (n1q_m - n0q_m);
                    end
                end
            end 
            else     //blank DE == LOW
            begin
                case ({c1_reg, c0_reg})
                    2'b00:   dout <= `UD CTRLTOKEN0;
                    2'b01:   dout <= `UD CTRLTOKEN1;
                    2'b10:   dout <= `UD CTRLTOKEN2;
                    default: dout <= `UD CTRLTOKEN3;
                endcase
                
                cnt <= `UD 5'h0;
            end
        end
    end
  
endmodule
