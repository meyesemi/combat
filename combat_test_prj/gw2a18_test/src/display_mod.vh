/* ************************************* */
    /* SELECT ONE OF MODES: */
    `define MODE_720p
    
    parameter   COCLOR_DEPP = 4'd8;
    parameter   X_WIDTH = 4'd12;
    parameter   Y_WIDTH = 4'd12;
    parameter   FRACTIONAL_BITS = 4'd12;
    
    
    `ifdef MODE_720p /* FORMAT 4 */
        parameter V_TOTAL = 12'd750;
        parameter V_FP = 12'd5;
        parameter V_BP = 12'd20;
        parameter V_SYNC = 12'd5;
        parameter V_ACT = 12'd720;
        parameter H_TOTAL = 12'd1650;
        parameter H_FP = 12'd110;
        parameter H_BP = 12'd220;
        parameter H_SYNC = 12'd40;
        parameter H_ACT = 12'd1280;
        parameter HV_OFFSET = 12'd0;
    `endif