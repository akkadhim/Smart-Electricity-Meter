
_DrawRfIcon:

;WiFi.c,230 :: 		void DrawRfIcon() {
;WiFi.c,234 :: 		if(rfIconMark == 4) {
	MOVF        _rfIconMark+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRfIcon0
;WiFi.c,235 :: 		ch = character0;
	MOVLW       _character0+0
	MOVWF       DrawRfIcon_ch_L0+0 
	MOVLW       hi_addr(_character0+0)
	MOVWF       DrawRfIcon_ch_L0+1 
	MOVLW       higher_addr(_character0+0)
	MOVWF       DrawRfIcon_ch_L0+2 
;WiFi.c,236 :: 		rfIconMark = 0;
	CLRF        _rfIconMark+0 
;WiFi.c,237 :: 		}
	GOTO        L_DrawRfIcon1
L_DrawRfIcon0:
;WiFi.c,239 :: 		switch(rfIconMark) {
	GOTO        L_DrawRfIcon2
;WiFi.c,240 :: 		case 1: {
L_DrawRfIcon4:
;WiFi.c,241 :: 		ch = character1;
	MOVLW       _character1+0
	MOVWF       DrawRfIcon_ch_L0+0 
	MOVLW       hi_addr(_character1+0)
	MOVWF       DrawRfIcon_ch_L0+1 
	MOVLW       higher_addr(_character1+0)
	MOVWF       DrawRfIcon_ch_L0+2 
;WiFi.c,242 :: 		break;
	GOTO        L_DrawRfIcon3
;WiFi.c,244 :: 		case 2: {
L_DrawRfIcon5:
;WiFi.c,245 :: 		ch = character2;
	MOVLW       _character2+0
	MOVWF       DrawRfIcon_ch_L0+0 
	MOVLW       hi_addr(_character2+0)
	MOVWF       DrawRfIcon_ch_L0+1 
	MOVLW       higher_addr(_character2+0)
	MOVWF       DrawRfIcon_ch_L0+2 
;WiFi.c,246 :: 		break;
	GOTO        L_DrawRfIcon3
;WiFi.c,248 :: 		case 3: {
L_DrawRfIcon6:
;WiFi.c,249 :: 		ch = character3;
	MOVLW       _character3+0
	MOVWF       DrawRfIcon_ch_L0+0 
	MOVLW       hi_addr(_character3+0)
	MOVWF       DrawRfIcon_ch_L0+1 
	MOVLW       higher_addr(_character3+0)
	MOVWF       DrawRfIcon_ch_L0+2 
;WiFi.c,250 :: 		break;
	GOTO        L_DrawRfIcon3
;WiFi.c,252 :: 		}
L_DrawRfIcon2:
	MOVF        _rfIconMark+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_DrawRfIcon4
	MOVF        _rfIconMark+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_DrawRfIcon5
	MOVF        _rfIconMark+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_DrawRfIcon6
L_DrawRfIcon3:
;WiFi.c,253 :: 		}
L_DrawRfIcon1:
;WiFi.c,254 :: 		rfIconMark++;
	INCF        _rfIconMark+0, 1 
;WiFi.c,255 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,256 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(ch[i]);
	CLRF        DrawRfIcon_i_L0+0 
L_DrawRfIcon7:
	MOVF        DrawRfIcon_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_DrawRfIcon8
	MOVF        DrawRfIcon_i_L0+0, 0 
	ADDWF       DrawRfIcon_ch_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      DrawRfIcon_ch_L0+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      DrawRfIcon_ch_L0+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        DrawRfIcon_i_L0+0, 1 
	GOTO        L_DrawRfIcon7
L_DrawRfIcon8:
;WiFi.c,257 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,258 :: 		Lcd_Chr(2, 16, 0);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;WiFi.c,259 :: 		}
L_end_DrawRfIcon:
	RETURN      0
; end of _DrawRfIcon

_interrupt:

;WiFi.c,265 :: 		void interrupt() {
;WiFi.c,266 :: 		if (TMR0IF_bit) {
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt10
;WiFi.c,267 :: 		wifiTmr++;
	INFSNZ      _wifiTmr+0, 1 
	INCF        _wifiTmr+1, 1 
;WiFi.c,268 :: 		if(wifiTmr >= 122) {
	MOVLW       0
	SUBWF       _wifiTmr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt66
	MOVLW       122
	SUBWF       _wifiTmr+0, 0 
L__interrupt66:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt11
;WiFi.c,269 :: 		Net_Wireless_MCW1001_Time++ ;
	MOVLW       1
	ADDWF       _Net_Wireless_MCW1001_Time+0, 1 
	MOVLW       0
	ADDWFC      _Net_Wireless_MCW1001_Time+1, 1 
	ADDWFC      _Net_Wireless_MCW1001_Time+2, 1 
	ADDWFC      _Net_Wireless_MCW1001_Time+3, 1 
;WiFi.c,270 :: 		wifiTmr = 0;
	CLRF        _wifiTmr+0 
	CLRF        _wifiTmr+1 
;WiFi.c,271 :: 		}
L_interrupt11:
;WiFi.c,272 :: 		TMR0IF_bit = 0;        // clear TMR0IF
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;WiFi.c,273 :: 		TMR0L = 0;             // set TMR0 for aproximetly 1 sec
	CLRF        TMR0L+0 
;WiFi.c,274 :: 		}
L_interrupt10:
;WiFi.c,276 :: 		if (TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_interrupt12
;WiFi.c,277 :: 		No_Timer_OF++ ;
	MOVLW       1
	ADDWF       _No_Timer_OF+0, 1 
	MOVLW       0
	ADDWFC      _No_Timer_OF+1, 1 
	ADDWFC      _No_Timer_OF+2, 1 
	ADDWFC      _No_Timer_OF+3, 1 
;WiFi.c,278 :: 		if (No_Timer_OF==9){
	MOVLW       0
	MOVWF       R0 
	XORWF       _No_Timer_OF+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt67
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt67
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt67
	MOVF        _No_Timer_OF+0, 0 
	XORLW       9
L__interrupt67:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt13
;WiFi.c,279 :: 		TMR1H         = 0x3B;
	MOVLW       59
	MOVWF       TMR1H+0 
;WiFi.c,280 :: 		TMR1L         = 0xCE;
	MOVLW       206
	MOVWF       TMR1L+0 
;WiFi.c,281 :: 		}
L_interrupt13:
;WiFi.c,282 :: 		TMR1IF_bit=0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;WiFi.c,283 :: 		}
L_interrupt12:
;WiFi.c,284 :: 		}
L_end_interrupt:
L__interrupt65:
	RETFIE      1
; end of _interrupt

_LED_Array:

;WiFi.c,288 :: 		void LED_Array(unsigned short array){
;WiFi.c,289 :: 		LATD.F2=(array & (1<<0));
	MOVLW       1
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__LED_Array69
	BCF         LATD+0, 2 
	GOTO        L__LED_Array70
L__LED_Array69:
	BSF         LATD+0, 2 
L__LED_Array70:
;WiFi.c,290 :: 		LATD.F3=(array & (1<<1))>>1;
	MOVLW       2
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 0 
	GOTO        L__LED_Array71
	BCF         LATD+0, 3 
	GOTO        L__LED_Array72
L__LED_Array71:
	BSF         LATD+0, 3 
L__LED_Array72:
;WiFi.c,291 :: 		LATD.F4=(array & (1<<2))>>2;
	MOVLW       4
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 0 
	GOTO        L__LED_Array73
	BCF         LATD+0, 4 
	GOTO        L__LED_Array74
L__LED_Array73:
	BSF         LATD+0, 4 
L__LED_Array74:
;WiFi.c,292 :: 		LATD.F5=(array & (1<<3))>>3;
	MOVLW       8
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 0 
	GOTO        L__LED_Array75
	BCF         LATD+0, 5 
	GOTO        L__LED_Array76
L__LED_Array75:
	BSF         LATD+0, 5 
L__LED_Array76:
;WiFi.c,293 :: 		LATD.F6=(array & (1<<4))>>4;
	MOVLW       16
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	BTFSC       R0, 0 
	GOTO        L__LED_Array77
	BCF         LATD+0, 6 
	GOTO        L__LED_Array78
L__LED_Array77:
	BSF         LATD+0, 6 
L__LED_Array78:
;WiFi.c,294 :: 		LATD.F7=(array & (1<<5))>>5;
	MOVLW       32
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVLW       5
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__LED_Array79:
	BZ          L__LED_Array80
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__LED_Array79
L__LED_Array80:
	BTFSC       R0, 0 
	GOTO        L__LED_Array81
	BCF         LATD+0, 7 
	GOTO        L__LED_Array82
L__LED_Array81:
	BSF         LATD+0, 7 
L__LED_Array82:
;WiFi.c,295 :: 		LATC.F3=(array & (1<<6))>>6;      // before D1
	MOVLW       64
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVLW       6
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__LED_Array83:
	BZ          L__LED_Array84
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__LED_Array83
L__LED_Array84:
	BTFSC       R0, 0 
	GOTO        L__LED_Array85
	BCF         LATC+0, 3 
	GOTO        L__LED_Array86
L__LED_Array85:
	BSF         LATC+0, 3 
L__LED_Array86:
;WiFi.c,296 :: 		LATC.F2=(array & (1<<7))>>7;      // before D0
	MOVLW       128
	ANDWF       FARG_LED_Array_array+0, 0 
	MOVWF       R2 
	MOVLW       7
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__LED_Array87:
	BZ          L__LED_Array88
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__LED_Array87
L__LED_Array88:
	BTFSC       R0, 0 
	GOTO        L__LED_Array89
	BCF         LATC+0, 2 
	GOTO        L__LED_Array90
L__LED_Array89:
	BSF         LATC+0, 2 
L__LED_Array90:
;WiFi.c,297 :: 		}
L_end_LED_Array:
	RETURN      0
; end of _LED_Array

_InitMcu:

;WiFi.c,303 :: 		void InitMcu() {
;WiFi.c,304 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;WiFi.c,305 :: 		ANSELC = 0;                    // Configure AN pins as digital I/O
	CLRF        ANSELC+0 
;WiFi.c,306 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;WiFi.c,307 :: 		ANSELE = 0;
	CLRF        ANSELE+0 
;WiFi.c,308 :: 		ANSELA.F0=1;
	BSF         ANSELA+0, 0 
;WiFi.c,309 :: 		ANSELA.F1=1;
	BSF         ANSELA+0, 1 
;WiFi.c,310 :: 		ANSELA.F4=0;
	BCF         ANSELA+0, 4 
;WiFi.c,311 :: 		ANSELA.F5=0;
	BCF         ANSELA+0, 5 
;WiFi.c,313 :: 		TRISA.F0=1;
	BSF         TRISA+0, 0 
;WiFi.c,314 :: 		TRISA.F1=1;
	BSF         TRISA+0, 1 
;WiFi.c,315 :: 		TRISA.F4=1;
	BSF         TRISA+0, 4 
;WiFi.c,316 :: 		TRISA.F5=0;
	BCF         TRISA+0, 5 
;WiFi.c,317 :: 		TRISD   =0;
	CLRF        TRISD+0 
;WiFi.c,318 :: 		TRISC.F2=0;
	BCF         TRISC+0, 2 
;WiFi.c,319 :: 		TRISC.F3=0;
	BCF         TRISC+0, 3 
;WiFi.c,320 :: 		TRISC.F1=0;
	BCF         TRISC+0, 1 
;WiFi.c,321 :: 		TRISC.F0=0;
	BCF         TRISC+0, 0 
;WiFi.c,322 :: 		SLRCON = 0;           // to reduce EMI
	CLRF        SLRCON+0 
;WiFi.c,324 :: 		LATD=0;
	CLRF        LATD+0 
;WiFi.c,325 :: 		LATC.F0=0;
	BCF         LATC+0, 0 
;WiFi.c,326 :: 		LATC.F1=0;
	BCF         LATC+0, 1 
;WiFi.c,327 :: 		LATC.F2=0;
	BCF         LATC+0, 2 
;WiFi.c,328 :: 		LATC.F3=0;
	BCF         LATC+0, 3 
;WiFi.c,331 :: 		TMR0L = 0;               // Timer0 initial value
	CLRF        TMR0L+0 
;WiFi.c,332 :: 		T0CON = 0xC7;            // Set TMR0 to 8bit mode and prescaler to 256
	MOVLW       199
	MOVWF       T0CON+0 
;WiFi.c,333 :: 		GIE_bit = 1;             // Enable global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;WiFi.c,334 :: 		TMR0IE_bit = 1;          // Enable Timer0 interrupt
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;WiFi.c,336 :: 		Chip_Select_Direction =0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;WiFi.c,337 :: 		Chip_Select = 1;                 // Deselect MCP3201
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;WiFi.c,339 :: 		SPI2_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_HIGH_2_LOW);
	MOVLW       1
	MOVWF       FARG_SPI2_Init_Advanced_master+0 
	CLRF        FARG_SPI2_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI2_Init_Advanced_clock_idle+0 
	CLRF        FARG_SPI2_Init_Advanced_transmit_edge+0 
	CALL        _SPI2_Init_Advanced+0, 0
;WiFi.c,340 :: 		Delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_InitMcu14:
	DECFSZ      R13, 1, 1
	BRA         L_InitMcu14
	DECFSZ      R12, 1, 1
	BRA         L_InitMcu14
	DECFSZ      R11, 1, 1
	BRA         L_InitMcu14
;WiFi.c,342 :: 		Lcd_Init();              // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;WiFi.c,343 :: 		Lcd_Cmd(_LCD_CLEAR);     // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,344 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);// Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,346 :: 		Lcd_Cmd(_LCD_CLEAR);     // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,347 :: 		Lcd_Out(1,1,txt1);       // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,348 :: 		Lcd_Out(2,1,txt2);       // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,349 :: 		Delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_InitMcu15:
	DECFSZ      R13, 1, 1
	BRA         L_InitMcu15
	DECFSZ      R12, 1, 1
	BRA         L_InitMcu15
	DECFSZ      R11, 1, 1
	BRA         L_InitMcu15
	NOP
;WiFi.c,351 :: 		Sound_Init(&PORTE, 1);
	MOVLW       PORTE+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       1
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;WiFi.c,352 :: 		Net_Wireless_MCW1001_HwReset();
	CALL        _Net_Wireless_MCW1001_HwReset+0, 0
;WiFi.c,353 :: 		Sound_Play(1000, 400);
	MOVLW       232
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;WiFi.c,355 :: 		}
L_end_InitMcu:
	RETURN      0
; end of _InitMcu

_InitWiFi:

;WiFi.c,360 :: 		void InitWiFi() {
;WiFi.c,363 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,364 :: 		Lcd_Out(1,1,txt4);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,365 :: 		Lcd_Out(2,1,txt5);                // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt5+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,366 :: 		Delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_InitWiFi16:
	DECFSZ      R13, 1, 1
	BRA         L_InitWiFi16
	DECFSZ      R12, 1, 1
	BRA         L_InitWiFi16
	DECFSZ      R11, 1, 1
	BRA         L_InitWiFi16
	NOP
;WiFi.c,368 :: 		Net_Wireless_MCW1001_TimeToWait = 1;
	MOVLW       1
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+0 
	MOVLW       0
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+1 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+2 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+3 
;WiFi.c,369 :: 		response = 1;
	MOVLW       1
	MOVWF       InitWiFi_response_L0+0 
;WiFi.c,371 :: 		while(response != 0){
L_InitWiFi17:
	MOVF        InitWiFi_response_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_InitWiFi18
;WiFi.c,372 :: 		response = Net_Wireless_MCW1001_SetMode(_NET_WIRELESS_MCW1001_CP_2, _NET_WIRELESS_MCW1001_MODE_INFRASTRUCTURE); // Set "Connection Profile 1" mode (Ad-Hoc mode)
	MOVLW       2
	MOVWF       FARG_Net_Wireless_MCW1001_SetMode_connectionProfile+0 
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_SetMode_mode+0 
	CALL        _Net_Wireless_MCW1001_SetMode+0, 0
	MOVF        R0, 0 
	MOVWF       InitWiFi_response_L0+0 
;WiFi.c,373 :: 		}
	GOTO        L_InitWiFi17
L_InitWiFi18:
;WiFi.c,375 :: 		Net_Wireless_MCW1001_TimeToWait = 5;
	MOVLW       5
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+0 
	MOVLW       0
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+1 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+2 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+3 
;WiFi.c,376 :: 		Net_Wireless_MCW1001_SetChannelList(11, channels);
	MOVLW       11
	MOVWF       FARG_Net_Wireless_MCW1001_SetChannelList_numOfChannel+0 
	MOVLW       _channels+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetChannelList_channels+0 
	MOVLW       hi_addr(_channels+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetChannelList_channels+1 
	CALL        _Net_Wireless_MCW1001_SetChannelList+0, 0
;WiFi.c,377 :: 		Net_Wireless_MCW1001_SetSecurity_WPA(_NET_WIRELESS_MCW1001_CP_1, _NET_WIRELESS_MCW1001_WPA_PSK2, wpaPassword);    // Set WPA_PSK2 security
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_SetSecurity_WPA_connectionProfile+0 
	MOVLW       6
	MOVWF       FARG_Net_Wireless_MCW1001_SetSecurity_WPA_wpaSecurityType+0 
	MOVLW       _wpaPassword+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetSecurity_WPA_key+0 
	MOVLW       hi_addr(_wpaPassword+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetSecurity_WPA_key+1 
	CALL        _Net_Wireless_MCW1001_SetSecurity_WPA+0, 0
;WiFi.c,378 :: 		Net_Wireless_MCW1001_SetSSID(_NET_WIRELESS_MCW1001_CP_1, strSSID);    // Set SSID of network
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_SetSSID_connectionProfile+0 
	MOVLW       _strSSID+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetSSID_ssidString+0 
	MOVLW       hi_addr(_strSSID+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetSSID_ssidString+1 
	CALL        _Net_Wireless_MCW1001_SetSSID+0, 0
;WiFi.c,381 :: 		Net_Wireless_MCW1001_SetNetworkMask(ipMask);
	MOVLW       _ipMask+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetNetworkMask_netMask+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetNetworkMask_netMask+1 
	CALL        _Net_Wireless_MCW1001_SetNetworkMask+0, 0
;WiFi.c,382 :: 		Net_Wireless_MCW1001_SetGatewayIP(gwIpAddr);
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetGatewayIP_gtwIpAddress+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetGatewayIP_gtwIpAddress+1 
	CALL        _Net_Wireless_MCW1001_SetGatewayIP+0, 0
;WiFi.c,383 :: 		Net_Wireless_MCW1001_SetMAC(myMacAddr);
	MOVLW       _myMacAddr+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetMAC_setMacAddress+0 
	MOVLW       hi_addr(_myMacAddr+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetMAC_setMacAddress+1 
	CALL        _Net_Wireless_MCW1001_SetMAC+0, 0
;WiFi.c,384 :: 		Net_Wireless_MCW1001_SetIP(myIpAddr);
	MOVLW       _myIpAddr+0
	MOVWF       FARG_Net_Wireless_MCW1001_SetIP_ipAddress+0 
	MOVLW       hi_addr(_myIpAddr+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SetIP_ipAddress+1 
	CALL        _Net_Wireless_MCW1001_SetIP+0, 0
;WiFi.c,386 :: 		Net_Wireless_MCW1001_SetArpTime(1);                                   // Set gratuitous ARP timing
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_SetArpTime_arpPeriod+0 
	MOVLW       0
	MOVWF       FARG_Net_Wireless_MCW1001_SetArpTime_arpPeriod+1 
	CALL        _Net_Wireless_MCW1001_SetArpTime+0, 0
;WiFi.c,387 :: 		Net_Wireless_MCW1001_SetRetryCount(5, 0);                             // Set number of retries for the connection
	MOVLW       5
	MOVWF       FARG_Net_Wireless_MCW1001_SetRetryCount_infModeRetryCount+0 
	CLRF        FARG_Net_Wireless_MCW1001_SetRetryCount_adhocModeRetryCount+0 
	CALL        _Net_Wireless_MCW1001_SetRetryCount+0, 0
;WiFi.c,388 :: 		Net_Wireless_MCW1001_SocketAllocate(2, 0, 2048, 2048, 0, 0);          // Allocate byffers for sockets
	MOVLW       2
	MOVWF       FARG_Net_Wireless_MCW1001_SocketAllocate_serverCount+0 
	CLRF        FARG_Net_Wireless_MCW1001_SocketAllocate_clientCount+0 
	MOVLW       0
	MOVWF       FARG_Net_Wireless_MCW1001_SocketAllocate_serverReceiveSize+0 
	MOVLW       8
	MOVWF       FARG_Net_Wireless_MCW1001_SocketAllocate_serverReceiveSize+1 
	MOVLW       0
	MOVWF       FARG_Net_Wireless_MCW1001_SocketAllocate_serverTransmitSize+0 
	MOVLW       8
	MOVWF       FARG_Net_Wireless_MCW1001_SocketAllocate_serverTransmitSize+1 
	CLRF        FARG_Net_Wireless_MCW1001_SocketAllocate_clientReceiveSize+0 
	CLRF        FARG_Net_Wireless_MCW1001_SocketAllocate_clientReceiveSize+1 
	CLRF        FARG_Net_Wireless_MCW1001_SocketAllocate_clientTransmitSize+0 
	CLRF        FARG_Net_Wireless_MCW1001_SocketAllocate_clientTransmitSize+1 
	CALL        _Net_Wireless_MCW1001_SocketAllocate+0, 0
;WiFi.c,390 :: 		}
L_end_InitWiFi:
	RETURN      0
; end of _InitWiFi

_PutConstString:

;WiFi.c,395 :: 		unsigned int    PutConstString(const code char *s) {
;WiFi.c,398 :: 		while(*s) {
L_PutConstString19:
	MOVF        FARG_PutConstString_s+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_PutConstString_s+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_PutConstString_s+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PutConstString20
;WiFi.c,399 :: 		txBuffer[bufferIndex++] = *s++;
	MOVLW       _txBuffer+0
	ADDWF       _bufferIndex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_txBuffer+0)
	ADDWFC      _bufferIndex+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_PutConstString_s+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_PutConstString_s+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_PutConstString_s+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _bufferIndex+0, 1 
	INCF        _bufferIndex+1, 1 
	MOVLW       1
	ADDWF       FARG_PutConstString_s+0, 1 
	MOVLW       0
	ADDWFC      FARG_PutConstString_s+1, 1 
	ADDWFC      FARG_PutConstString_s+2, 1 
;WiFi.c,400 :: 		if(bufferIndex == MAX_SIZE_OF_DATA) {
	MOVF        _bufferIndex+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__PutConstString94
	MOVLW       233
	XORWF       _bufferIndex+0, 0 
L__PutConstString94:
	BTFSS       STATUS+0, 2 
	GOTO        L_PutConstString21
;WiFi.c,401 :: 		Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, MAX_SIZE_OF_DATA, &numOfSentBytes);
	MOVF        _socketChild+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_socketHandle+0 
	MOVLW       _txBuffer+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+0 
	MOVLW       hi_addr(_txBuffer+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+1 
	MOVLW       233
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+0 
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+1 
	MOVLW       PutConstString_numOfSentBytes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+0 
	MOVLW       hi_addr(PutConstString_numOfSentBytes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+1 
	CALL        _Net_Wireless_MCW1001_TCP_SendBytes+0, 0
;WiFi.c,402 :: 		bufferIndex = 0;
	CLRF        _bufferIndex+0 
	CLRF        _bufferIndex+1 
;WiFi.c,403 :: 		}
L_PutConstString21:
;WiFi.c,404 :: 		}
	GOTO        L_PutConstString19
L_PutConstString20:
;WiFi.c,405 :: 		return(bufferIndex) ;
	MOVF        _bufferIndex+0, 0 
	MOVWF       R0 
	MOVF        _bufferIndex+1, 0 
	MOVWF       R1 
;WiFi.c,406 :: 		}
L_end_PutConstString:
	RETURN      0
; end of _PutConstString

_PutString:

;WiFi.c,411 :: 		unsigned int    PutString(char *s) {
;WiFi.c,414 :: 		while(*s) {
L_PutString22:
	MOVFF       FARG_PutString_s+0, FSR0
	MOVFF       FARG_PutString_s+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PutString23
;WiFi.c,415 :: 		txBuffer[bufferIndex++] = *s++;
	MOVLW       _txBuffer+0
	ADDWF       _bufferIndex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_txBuffer+0)
	ADDWFC      _bufferIndex+1, 0 
	MOVWF       FSR1H 
	MOVFF       FARG_PutString_s+0, FSR0
	MOVFF       FARG_PutString_s+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      _bufferIndex+0, 1 
	INCF        _bufferIndex+1, 1 
	INFSNZ      FARG_PutString_s+0, 1 
	INCF        FARG_PutString_s+1, 1 
;WiFi.c,416 :: 		if(bufferIndex == MAX_SIZE_OF_DATA) {
	MOVF        _bufferIndex+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__PutString96
	MOVLW       233
	XORWF       _bufferIndex+0, 0 
L__PutString96:
	BTFSS       STATUS+0, 2 
	GOTO        L_PutString24
;WiFi.c,417 :: 		Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, MAX_SIZE_OF_DATA, &numOfSentBytes);
	MOVF        _socketChild+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_socketHandle+0 
	MOVLW       _txBuffer+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+0 
	MOVLW       hi_addr(_txBuffer+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+1 
	MOVLW       233
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+0 
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+1 
	MOVLW       PutString_numOfSentBytes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+0 
	MOVLW       hi_addr(PutString_numOfSentBytes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+1 
	CALL        _Net_Wireless_MCW1001_TCP_SendBytes+0, 0
;WiFi.c,418 :: 		bufferIndex = 0;
	CLRF        _bufferIndex+0 
	CLRF        _bufferIndex+1 
;WiFi.c,419 :: 		}
L_PutString24:
;WiFi.c,420 :: 		}
	GOTO        L_PutString22
L_PutString23:
;WiFi.c,421 :: 		return(bufferIndex) ;
	MOVF        _bufferIndex+0, 0 
	MOVWF       R0 
	MOVF        _bufferIndex+1, 0 
	MOVWF       R1 
;WiFi.c,422 :: 		}
L_end_PutString:
	RETURN      0
; end of _PutString

_SendHttpResponse:

;WiFi.c,426 :: 		void SendHttpResponse()
;WiFi.c,430 :: 		unsigned int numOfReceiveBytes = 0, numOfSentBytes;
	CLRF        SendHttpResponse_numOfReceiveBytes_L0+0 
	CLRF        SendHttpResponse_numOfReceiveBytes_L0+1 
;WiFi.c,434 :: 		length = 0;
	CLRF        SendHttpResponse_length_L0+0 
	CLRF        SendHttpResponse_length_L0+1 
;WiFi.c,435 :: 		Net_Wireless_MCW1001_TCP_ReadBytes(&socketChild, 10, getRequest, &numOfReceiveBytes);
	MOVLW       _socketChild+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_socketHandle+0 
	MOVLW       hi_addr(_socketChild+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_socketHandle+1 
	MOVLW       10
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_amountOfDataToBeRead+0 
	MOVLW       0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_amountOfDataToBeRead+1 
	MOVLW       _getRequest+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_dat+0 
	MOVLW       hi_addr(_getRequest+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_dat+1 
	MOVLW       SendHttpResponse_numOfReceiveBytes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_numOfReceiveBytes+0 
	MOVLW       hi_addr(SendHttpResponse_numOfReceiveBytes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_ReadBytes_numOfReceiveBytes+1 
	CALL        _Net_Wireless_MCW1001_TCP_ReadBytes+0, 0
;WiFi.c,436 :: 		getRequest[10] = 0;
	CLRF        _getRequest+10 
;WiFi.c,438 :: 		if(memcmp(getRequest, httpMethod, 5)) {     // only GET method is supported here
	MOVLW       _getRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendHttpResponse25
;WiFi.c,439 :: 		return;
	GOTO        L_end_SendHttpResponse
;WiFi.c,440 :: 		}
L_SendHttpResponse25:
;WiFi.c,443 :: 		httpCounter++ ;                             // one more request done
	MOVLW       1
	ADDWF       _httpCounter+0, 1 
	MOVLW       0
	ADDWFC      _httpCounter+1, 1 
	ADDWFC      _httpCounter+2, 1 
	ADDWFC      _httpCounter+3, 1 
;WiFi.c,444 :: 		if(getRequest[5] == 's') {                  // if request path name starts with s, store dynamic data in transmit buffer
	MOVF        _getRequest+5, 0 
	XORLW       115
	BTFSS       STATUS+0, 2 
	GOTO        L_SendHttpResponse26
;WiFi.c,446 :: 		find_parameter();
	CALL        _find_parameter+0, 0
;WiFi.c,449 :: 		bufferIndex = 0;
	CLRF        _bufferIndex+0 
	CLRF        _bufferIndex+1 
;WiFi.c,450 :: 		PutConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,451 :: 		PutConstString(httpMimeTypeScript) ;      // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,455 :: 		WordToStr(voltage,dyna) ;
	MOVF        _voltage+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _voltage+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _dyna+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;WiFi.c,456 :: 		PutConstString("var AN0=") ;
	MOVLW       ?lstr_3_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_3_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_3_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,457 :: 		PutString(Rtrim(Ltrim(dyna)));
	MOVLW       _dyna+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PutString_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,458 :: 		PutConstString(";") ;
	MOVLW       ?lstr_4_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_4_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_4_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,460 :: 		PutConstString("var AN1=") ;
	MOVLW       ?lstr_5_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_5_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_5_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,461 :: 		floattostr(current_read_float,dyna);
	MOVF        _current_read_float+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _current_read_float+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _current_read_float+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _current_read_float+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dyna+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;WiFi.c,462 :: 		PutString(dyna);
	MOVLW       _dyna+0
	MOVWF       FARG_PutString_s+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,463 :: 		PutConstString(";") ;
	MOVLW       ?lstr_6_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_6_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_6_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,465 :: 		ByteToStr(freq2write,dyna) ;
	MOVF        _freq2write+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dyna+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;WiFi.c,466 :: 		PutConstString("var AN2=") ;
	MOVLW       ?lstr_7_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_7_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_7_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,467 :: 		PutString(Rtrim(Ltrim(dyna)));
	MOVLW       _dyna+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PutString_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,468 :: 		PutConstString(";") ;
	MOVLW       ?lstr_8_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_8_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_8_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,470 :: 		floattostr(Power_Factor_Float,dyna);
	MOVF        _Power_Factor_Float+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _Power_Factor_Float+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _Power_Factor_Float+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _Power_Factor_Float+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dyna+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;WiFi.c,471 :: 		PutConstString("var AN3=") ;
	MOVLW       ?lstr_9_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_9_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_9_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,472 :: 		PutString(dyna);
	MOVLW       _dyna+0
	MOVWF       FARG_PutString_s+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,473 :: 		PutConstString(";") ;
	MOVLW       ?lstr_10_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_10_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_10_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,475 :: 		LongWordToStr(Price,dyna) ;
	MOVF        _Price+0, 0 
	MOVWF       FARG_LongWordToStr_input+0 
	MOVF        _Price+1, 0 
	MOVWF       FARG_LongWordToStr_input+1 
	MOVF        _Price+2, 0 
	MOVWF       FARG_LongWordToStr_input+2 
	MOVF        _Price+3, 0 
	MOVWF       FARG_LongWordToStr_input+3 
	MOVLW       _dyna+0
	MOVWF       FARG_LongWordToStr_output+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_LongWordToStr_output+1 
	CALL        _LongWordToStr+0, 0
;WiFi.c,476 :: 		PutConstString("var AN4=") ;
	MOVLW       ?lstr_11_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_11_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_11_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,477 :: 		PutString(Rtrim(Ltrim(dyna)));
	MOVLW       _dyna+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_dyna+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PutString_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,478 :: 		PutConstString(";") ;
	MOVLW       ?lstr_12_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_12_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_12_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,480 :: 		Action=EEPROM_Read(0x00)& 1;
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVLW       1
	ANDWF       R0, 1 
	BTFSC       R0, 0 
	GOTO        L__SendHttpResponse98
	BCF         _Action+0, BitPos(_Action+0) 
	GOTO        L__SendHttpResponse99
L__SendHttpResponse98:
	BSF         _Action+0, BitPos(_Action+0) 
L__SendHttpResponse99:
;WiFi.c,481 :: 		memset(txt22,0,4);
	MOVLW       _txt22+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_txt22+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;WiFi.c,482 :: 		txt22[0]=Action+48;
	MOVLW       0
	BTFSC       _Action+0, BitPos(_Action+0) 
	MOVLW       1
	MOVWF       _txt22+0 
	MOVLW       48
	ADDWF       _txt22+0, 1 
;WiFi.c,483 :: 		PutConstString("var Action=") ;
	MOVLW       ?lstr_13_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_13_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_13_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,484 :: 		PutString(Rtrim(Ltrim(txt22))) ;
	MOVLW       _txt22+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt22+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PutString_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,485 :: 		PutConstString(";") ;
	MOVLW       ?lstr_14_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_14_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_14_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,487 :: 		Switches=(EEPROM_Read(0x01));
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Switches+0 
;WiFi.c,488 :: 		Bytetostr(Switches,txt22);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _txt22+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt22+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;WiFi.c,489 :: 		PutConstString("var Switches=") ;
	MOVLW       ?lstr_15_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_15_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_15_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,490 :: 		PutString(Rtrim(Ltrim(txt22))) ;
	MOVLW       _txt22+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt22+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PutString_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_PutString_s+1 
	CALL        _PutString+0, 0
;WiFi.c,491 :: 		length = PutConstString(";") ;
	MOVLW       ?lstr_16_WiFi+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(?lstr_16_WiFi+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(?lstr_16_WiFi+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SendHttpResponse_length_L0+0 
	MOVF        R1, 0 
	MOVWF       SendHttpResponse_length_L0+1 
;WiFi.c,493 :: 		if(length != 0)                          // If there is some data (in txBuffer) which is not sent
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendHttpResponse100
	MOVLW       0
	XORWF       R0, 0 
L__SendHttpResponse100:
	BTFSC       STATUS+0, 2 
	GOTO        L_SendHttpResponse27
;WiFi.c,494 :: 		Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, length, &numOfSentBytes);
	MOVF        _socketChild+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_socketHandle+0 
	MOVLW       _txBuffer+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+0 
	MOVLW       hi_addr(_txBuffer+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+1 
	MOVF        SendHttpResponse_length_L0+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+0 
	MOVF        SendHttpResponse_length_L0+1, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+1 
	MOVLW       SendHttpResponse_numOfSentBytes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+0 
	MOVLW       hi_addr(SendHttpResponse_numOfSentBytes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+1 
	CALL        _Net_Wireless_MCW1001_TCP_SendBytes+0, 0
L_SendHttpResponse27:
;WiFi.c,496 :: 		}
	GOTO        L_SendHttpResponse28
L_SendHttpResponse26:
;WiFi.c,498 :: 		else if(getRequest[5] == 't') {            // if request path name starts with t, toggle PORTA (LED) bit number that comes after
	MOVF        _getRequest+5, 0 
	XORLW       116
	BTFSS       STATUS+0, 2 
	GOTO        L_SendHttpResponse29
;WiFi.c,499 :: 		bitMask = 0 ;                            // for bit mask
	CLRF        _bitMask+0 
;WiFi.c,500 :: 		Sound_Play(800, 40);                     // Play sound at 800Hz for 40ms
	MOVLW       32
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       40
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;WiFi.c,501 :: 		if(isdigit(getRequest[6])) {             // if 0 <= bit number <= 9, bits 8 & 9 does not exist but does not matter
	MOVF        _getRequest+6, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendHttpResponse30
;WiFi.c,502 :: 		bitMask = getRequest[6] - '0' ;        // convert ASCII to integer
	MOVLW       48
	SUBWF       _getRequest+6, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _bitMask+0 
;WiFi.c,503 :: 		bitMask = 1 << bitMask ;               // create bit mask
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__SendHttpResponse101:
	BZ          L__SendHttpResponse102
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SendHttpResponse101
L__SendHttpResponse102:
	MOVF        R0, 0 
	MOVWF       _bitMask+0 
;WiFi.c,504 :: 		Switches ^= bitMask ;                  // toggle PORTA with xor operator
	MOVF        _Switches+0, 0 
	XORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _Switches+0 
;WiFi.c,505 :: 		EEPROM_Write(0x01,Switches);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;WiFi.c,506 :: 		LED_Array(Switches);
	MOVF        _Switches+0, 0 
	MOVWF       FARG_LED_Array_array+0 
	CALL        _LED_Array+0, 0
;WiFi.c,507 :: 		}
L_SendHttpResponse30:
;WiFi.c,509 :: 		}
	GOTO        L_SendHttpResponse31
L_SendHttpResponse29:
;WiFi.c,511 :: 		else if(getRequest[5] == 'l') {            // if request path name starts with t, toggle PORTA (LED) bit number that comes after
	MOVF        _getRequest+5, 0 
	XORLW       108
	BTFSS       STATUS+0, 2 
	GOTO        L_SendHttpResponse32
;WiFi.c,512 :: 		bitMask = 0 ;            // for bit mask
	CLRF        _bitMask+0 
;WiFi.c,513 :: 		Sound_Play(800, 40);                     // Play sound at 800Hz for 40ms
	MOVLW       32
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       40
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;WiFi.c,514 :: 		if(isdigit(getRequest[6])) {             // if 0 <= bit number <= 9, bits 8 & 9 does not exist but does not matter
	MOVF        _getRequest+6, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendHttpResponse33
;WiFi.c,515 :: 		bitMask = getRequest[6] - '0' ;        // convert ASCII to integer
	MOVLW       48
	SUBWF       _getRequest+6, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _bitMask+0 
;WiFi.c,516 :: 		Action = bitMask ;                      // toggle PORTA with xor operator
	BTFSC       R0, 0 
	GOTO        L__SendHttpResponse103
	BCF         _Action+0, BitPos(_Action+0) 
	GOTO        L__SendHttpResponse104
L__SendHttpResponse103:
	BSF         _Action+0, BitPos(_Action+0) 
L__SendHttpResponse104:
;WiFi.c,517 :: 		lata.f5 = Action;
	BTFSC       _Action+0, BitPos(_Action+0) 
	GOTO        L__SendHttpResponse105
	BCF         LATA+0, 5 
	GOTO        L__SendHttpResponse106
L__SendHttpResponse105:
	BSF         LATA+0, 5 
L__SendHttpResponse106:
;WiFi.c,518 :: 		latc.f0 = Action;
	BTFSC       _Action+0, BitPos(_Action+0) 
	GOTO        L__SendHttpResponse107
	BCF         LATC+0, 0 
	GOTO        L__SendHttpResponse108
L__SendHttpResponse107:
	BSF         LATC+0, 0 
L__SendHttpResponse108:
;WiFi.c,519 :: 		EEPROM_Write(0x00,Action);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       0
	BTFSC       _Action+0, BitPos(_Action+0) 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;WiFi.c,520 :: 		}
L_SendHttpResponse33:
;WiFi.c,522 :: 		}
L_SendHttpResponse32:
L_SendHttpResponse31:
L_SendHttpResponse28:
;WiFi.c,524 :: 		if(length == 0) {                          // what do to by default
	MOVLW       0
	XORWF       SendHttpResponse_length_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendHttpResponse109
	MOVLW       0
	XORWF       SendHttpResponse_length_L0+0, 0 
L__SendHttpResponse109:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendHttpResponse34
;WiFi.c,526 :: 		bufferIndex = 0;
	CLRF        _bufferIndex+0 
	CLRF        _bufferIndex+1 
;WiFi.c,527 :: 		PutConstString(httpHeader) ;             // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,528 :: 		PutConstString(httpMimeTypeHTML) ;       // with HTML MIME type
	MOVLW       _httpMimeTypeHTML+0
	MOVWF       FARG_PutConstString_s+0 
	MOVLW       hi_addr(_httpMimeTypeHTML+0)
	MOVWF       FARG_PutConstString_s+1 
	MOVLW       higher_addr(_httpMimeTypeHTML+0)
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,529 :: 		PutConstString(indexPage) ;              // HTML page first part
	MOVF        _indexPage+0, 0 
	MOVWF       FARG_PutConstString_s+0 
	MOVF        _indexPage+1, 0 
	MOVWF       FARG_PutConstString_s+1 
	MOVF        _indexPage+2, 0 
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
;WiFi.c,530 :: 		length = PutConstString(indexPage2) ;    // HTML page second part
	MOVF        _indexPage2+0, 0 
	MOVWF       FARG_PutConstString_s+0 
	MOVF        _indexPage2+1, 0 
	MOVWF       FARG_PutConstString_s+1 
	MOVF        _indexPage2+2, 0 
	MOVWF       FARG_PutConstString_s+2 
	CALL        _PutConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SendHttpResponse_length_L0+0 
	MOVF        R1, 0 
	MOVWF       SendHttpResponse_length_L0+1 
;WiFi.c,531 :: 		if(length != 0)                          // If there is some data (in txBuffer) which is not sent
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendHttpResponse110
	MOVLW       0
	XORWF       R0, 0 
L__SendHttpResponse110:
	BTFSC       STATUS+0, 2 
	GOTO        L_SendHttpResponse35
;WiFi.c,532 :: 		Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, length, &numOfSentBytes);
	MOVF        _socketChild+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_socketHandle+0 
	MOVLW       _txBuffer+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+0 
	MOVLW       hi_addr(_txBuffer+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_dat+1 
	MOVF        SendHttpResponse_length_L0+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+0 
	MOVF        SendHttpResponse_length_L0+1, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_datLength+1 
	MOVLW       SendHttpResponse_numOfSentBytes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+0 
	MOVLW       hi_addr(SendHttpResponse_numOfSentBytes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_SendBytes_numOfSendBytes+1 
	CALL        _Net_Wireless_MCW1001_TCP_SendBytes+0, 0
L_SendHttpResponse35:
;WiFi.c,534 :: 		}
L_SendHttpResponse34:
;WiFi.c,535 :: 		}
L_end_SendHttpResponse:
	RETURN      0
; end of _SendHttpResponse

_RunHttpServer:

;WiFi.c,539 :: 		void RunHttpServer() {
;WiFi.c,541 :: 		while(1) {
L_RunHttpServer36:
;WiFi.c,542 :: 		socketHandle = 0;
	CLRF        _socketHandle+0 
;WiFi.c,543 :: 		backLog = 1;
	MOVLW       1
	MOVWF       _backLog+0 
;WiFi.c,544 :: 		localPort = 80;
	MOVLW       80
	MOVWF       _localPort+0 
	MOVLW       0
	MOVWF       _localPort+1 
;WiFi.c,545 :: 		Net_Wireless_MCW1001_SocketCreate(&socketHandle, _NET_WIRELESS_MCW1001_SOCKET_TYPE_TCP);   // Create TCP socket
	MOVLW       _socketHandle+0
	MOVWF       FARG_Net_Wireless_MCW1001_SocketCreate_socketHandle+0 
	MOVLW       hi_addr(_socketHandle+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SocketCreate_socketHandle+1 
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_SocketCreate_socketType+0 
	CALL        _Net_Wireless_MCW1001_SocketCreate+0, 0
;WiFi.c,546 :: 		Net_Wireless_MCW1001_SocketBind(socketHandle, &localPort, &bindResponse);                  // Bind socket to the listen port
	MOVF        _socketHandle+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_SocketBind_socketHandle+0 
	MOVLW       _localPort+0
	MOVWF       FARG_Net_Wireless_MCW1001_SocketBind_localport+0 
	MOVLW       hi_addr(_localPort+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SocketBind_localport+1 
	MOVLW       _bindResponse+0
	MOVWF       FARG_Net_Wireless_MCW1001_SocketBind_bindResult+0 
	MOVLW       hi_addr(_bindResponse+0)
	MOVWF       FARG_Net_Wireless_MCW1001_SocketBind_bindResult+1 
	CALL        _Net_Wireless_MCW1001_SocketBind+0, 0
;WiFi.c,547 :: 		Net_Wireless_MCW1001_TCP_Listen(socketHandle, &backLog, &listenResponse);                  // Prepare the socket to listen for connection
	MOVF        _socketHandle+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Listen_socketHandle+0 
	MOVLW       _backLog+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Listen_backLog+0 
	MOVLW       hi_addr(_backLog+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Listen_backLog+1 
	MOVLW       _listenResponse+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Listen_listenResponse+0 
	MOVLW       hi_addr(_listenResponse+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Listen_listenResponse+1 
	CALL        _Net_Wireless_MCW1001_TCP_Listen+0, 0
;WiFi.c,549 :: 		while(1) {
L_RunHttpServer38:
;WiFi.c,550 :: 		socketChild = socketHandle;
	MOVF        _socketHandle+0, 0 
	MOVWF       _socketChild+0 
;WiFi.c,551 :: 		Net_Wireless_MCW1001_TCP_Accept(&socketChild, &remotePort, remoteIpAdd);                 // Accept incoming conncetion
	MOVLW       _socketChild+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_socketHandle+0 
	MOVLW       hi_addr(_socketChild+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_socketHandle+1 
	MOVLW       _remotePort+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_remotePort+0 
	MOVLW       hi_addr(_remotePort+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_remotePort+1 
	MOVLW       _remoteIpAdd+0
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_remoteIP+0 
	MOVLW       hi_addr(_remoteIpAdd+0)
	MOVWF       FARG_Net_Wireless_MCW1001_TCP_Accept_remoteIP+1 
	CALL        _Net_Wireless_MCW1001_TCP_Accept+0, 0
;WiFi.c,552 :: 		if (socketChild != 254) {                                                                // Accept function set socketChild.
	MOVF        _socketChild+0, 0 
	XORLW       254
	BTFSC       STATUS+0, 2 
	GOTO        L_RunHttpServer40
;WiFi.c,553 :: 		break;                                                                                 // If socketChild == 254 there is no incoming connection
	GOTO        L_RunHttpServer39
;WiFi.c,554 :: 		}
L_RunHttpServer40:
;WiFi.c,555 :: 		}
	GOTO        L_RunHttpServer38
L_RunHttpServer39:
;WiFi.c,557 :: 		SendHttpResponse();
	CALL        _SendHttpResponse+0, 0
;WiFi.c,558 :: 		Net_Wireless_MCW1001_SocketClose(socketChild);                                             // Close sockets
	MOVF        _socketChild+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_SocketClose_socketHandle+0 
	CALL        _Net_Wireless_MCW1001_SocketClose+0, 0
;WiFi.c,559 :: 		Net_Wireless_MCW1001_SocketClose(socketHandle);
	MOVF        _socketHandle+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_SocketClose_socketHandle+0 
	CALL        _Net_Wireless_MCW1001_SocketClose+0, 0
;WiFi.c,560 :: 		}
	GOTO        L_RunHttpServer36
;WiFi.c,561 :: 		}
L_end_RunHttpServer:
	RETURN      0
; end of _RunHttpServer

_SearchSSID:

;WiFi.c,565 :: 		void SearchSSID() {
;WiFi.c,570 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,571 :: 		Lcd_Out(1,1,"Search SSID...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_WiFi+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_WiFi+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,572 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_SearchSSID41:
	DECFSZ      R13, 1, 1
	BRA         L_SearchSSID41
	DECFSZ      R12, 1, 1
	BRA         L_SearchSSID41
	DECFSZ      R11, 1, 1
	BRA         L_SearchSSID41
;WiFi.c,573 :: 		markFound = 0;
	CLRF        SearchSSID_markFound_L0+0 
;WiFi.c,574 :: 		while(markFound != 1) {
L_SearchSSID42:
	MOVF        SearchSSID_markFound_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SearchSSID43
;WiFi.c,575 :: 		while(1) {
L_SearchSSID44:
;WiFi.c,576 :: 		response = Net_Wireless_MCW1001_ScanStart(255, &numOfScanRes);                           // Scan network
	MOVLW       255
	MOVWF       FARG_Net_Wireless_MCW1001_ScanStart_connectionProfile+0 
	MOVLW       SearchSSID_numOfScanRes_L0+0
	MOVWF       FARG_Net_Wireless_MCW1001_ScanStart_numOfScanResult+0 
	MOVLW       hi_addr(SearchSSID_numOfScanRes_L0+0)
	MOVWF       FARG_Net_Wireless_MCW1001_ScanStart_numOfScanResult+1 
	CALL        _Net_Wireless_MCW1001_ScanStart+0, 0
;WiFi.c,577 :: 		if(response == 0)                                                                        // Check if scanning successful
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SearchSSID46
;WiFi.c,578 :: 		break;
	GOTO        L_SearchSSID45
L_SearchSSID46:
;WiFi.c,579 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_SearchSSID47:
	DECFSZ      R13, 1, 1
	BRA         L_SearchSSID47
	DECFSZ      R12, 1, 1
	BRA         L_SearchSSID47
	DECFSZ      R11, 1, 1
	BRA         L_SearchSSID47
	NOP
;WiFi.c,580 :: 		}
	GOTO        L_SearchSSID44
L_SearchSSID45:
;WiFi.c,582 :: 		for(i = 1; i <= numOfScanRes; i++) {
	MOVLW       1
	MOVWF       SearchSSID_i_L0+0 
L_SearchSSID48:
	MOVF        SearchSSID_i_L0+0, 0 
	SUBWF       SearchSSID_numOfScanRes_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SearchSSID49
;WiFi.c,583 :: 		response = Net_Wireless_MCW1001_GetScanResult(i);
	MOVF        SearchSSID_i_L0+0, 0 
	MOVWF       FARG_Net_Wireless_MCW1001_GetScanResult_listIndex+0 
	CALL        _Net_Wireless_MCW1001_GetScanResult+0, 0
;WiFi.c,584 :: 		strncpy(strTmp, Net_Wireless_MCW1001_ScanResult.SSID, Net_Wireless_MCW1001_ScanResult.SSIDLength);
	MOVLW       SearchSSID_strTmp_L0+0
	MOVWF       FARG_strncpy_to+0 
	MOVLW       hi_addr(SearchSSID_strTmp_L0+0)
	MOVWF       FARG_strncpy_to+1 
	MOVLW       _Net_Wireless_MCW1001_ScanResult+7
	MOVWF       FARG_strncpy_from+0 
	MOVLW       hi_addr(_Net_Wireless_MCW1001_ScanResult+7)
	MOVWF       FARG_strncpy_from+1 
	MOVF        _Net_Wireless_MCW1001_ScanResult+6, 0 
	MOVWF       FARG_strncpy_size+0 
	MOVLW       0
	MOVWF       FARG_strncpy_size+1 
	CALL        _strncpy+0, 0
;WiFi.c,586 :: 		if(Net_Wireless_MCW1001_ScanResult.SSIDLength > 13) {
	MOVF        _Net_Wireless_MCW1001_ScanResult+6, 0 
	SUBLW       13
	BTFSC       STATUS+0, 0 
	GOTO        L_SearchSSID51
;WiFi.c,587 :: 		strTmp[14] = '\0';
	CLRF        SearchSSID_strTmp_L0+14 
;WiFi.c,588 :: 		strTmp[13] = '.';
	MOVLW       46
	MOVWF       SearchSSID_strTmp_L0+13 
;WiFi.c,589 :: 		strTmp[12] = '.';
	MOVLW       46
	MOVWF       SearchSSID_strTmp_L0+12 
;WiFi.c,590 :: 		strTmp[11] = '.';
	MOVLW       46
	MOVWF       SearchSSID_strTmp_L0+11 
;WiFi.c,591 :: 		}
	GOTO        L_SearchSSID52
L_SearchSSID51:
;WiFi.c,593 :: 		strTmp[Net_Wireless_MCW1001_ScanResult.SSIDLength] = '\0';
	MOVLW       SearchSSID_strTmp_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(SearchSSID_strTmp_L0+0)
	MOVWF       FSR1H 
	MOVF        _Net_Wireless_MCW1001_ScanResult+6, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
L_SearchSSID52:
;WiFi.c,595 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,596 :: 		Lcd_Out(1,1,"SSIDs Found:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_WiFi+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_WiFi+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,597 :: 		Lcd_Out(2,1,strTmp);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       SearchSSID_strTmp_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(SearchSSID_strTmp_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,598 :: 		if(strncmp(Net_Wireless_MCW1001_ScanResult.SSID, strSSID, Net_Wireless_MCW1001_ScanResult.SSIDLength) == 0) {
	MOVLW       _Net_Wireless_MCW1001_ScanResult+7
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_Net_Wireless_MCW1001_ScanResult+7)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       _strSSID+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(_strSSID+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVF        _Net_Wireless_MCW1001_ScanResult+6, 0 
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SearchSSID113
	MOVLW       0
	XORWF       R0, 0 
L__SearchSSID113:
	BTFSS       STATUS+0, 2 
	GOTO        L_SearchSSID53
;WiFi.c,599 :: 		markFound = 1;
	MOVLW       1
	MOVWF       SearchSSID_markFound_L0+0 
;WiFi.c,600 :: 		Delay_ms(700);
	MOVLW       29
	MOVWF       R11, 0
	MOVLW       105
	MOVWF       R12, 0
	MOVLW       165
	MOVWF       R13, 0
L_SearchSSID54:
	DECFSZ      R13, 1, 1
	BRA         L_SearchSSID54
	DECFSZ      R12, 1, 1
	BRA         L_SearchSSID54
	DECFSZ      R11, 1, 1
	BRA         L_SearchSSID54
;WiFi.c,601 :: 		break;
	GOTO        L_SearchSSID49
;WiFi.c,602 :: 		}
L_SearchSSID53:
;WiFi.c,603 :: 		Delay_ms(700);
	MOVLW       29
	MOVWF       R11, 0
	MOVLW       105
	MOVWF       R12, 0
	MOVLW       165
	MOVWF       R13, 0
L_SearchSSID55:
	DECFSZ      R13, 1, 1
	BRA         L_SearchSSID55
	DECFSZ      R12, 1, 1
	BRA         L_SearchSSID55
	DECFSZ      R11, 1, 1
	BRA         L_SearchSSID55
;WiFi.c,582 :: 		for(i = 1; i <= numOfScanRes; i++) {
	INCF        SearchSSID_i_L0+0, 1 
;WiFi.c,604 :: 		}
	GOTO        L_SearchSSID48
L_SearchSSID49:
;WiFi.c,605 :: 		}
	GOTO        L_SearchSSID42
L_SearchSSID43:
;WiFi.c,606 :: 		}
L_end_SearchSSID:
	RETURN      0
; end of _SearchSSID

_ConnectToAp:

;WiFi.c,610 :: 		void ConnectToAp() {
;WiFi.c,611 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,612 :: 		Lcd_Out(1,1,txt6);                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt6+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,613 :: 		Lcd_Out(2,1,txt7);                 // Write text in second row
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt7+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt7+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,616 :: 		Net_Wireless_MCW1001_TimeToWait = 1;
	MOVLW       1
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+0 
	MOVLW       0
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+1 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+2 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+3 
;WiFi.c,617 :: 		Net_Wireless_MCW1001_Connect(_NET_WIRELESS_MCW1001_CP_1, &wifiStatus);
	MOVLW       1
	MOVWF       FARG_Net_Wireless_MCW1001_Connect_connectionProfile+0 
	MOVLW       _wifiStatus+0
	MOVWF       FARG_Net_Wireless_MCW1001_Connect_connectionStatus+0 
	MOVLW       hi_addr(_wifiStatus+0)
	MOVWF       FARG_Net_Wireless_MCW1001_Connect_connectionStatus+1 
	CALL        _Net_Wireless_MCW1001_Connect+0, 0
;WiFi.c,623 :: 		Net_Wireless_MCW1001_Properties.networkStatus = _NET_WIRELESS_MCW1001_STATUS_NOTCONN_STATIC_IP;
	CLRF        _Net_Wireless_MCW1001_Properties+18 
;WiFi.c,624 :: 		while(1) {
L_ConnectToAp56:
;WiFi.c,625 :: 		Net_Wireless_MCW1001_GetNetworkStatus();
	CALL        _Net_Wireless_MCW1001_GetNetworkStatus+0, 0
;WiFi.c,626 :: 		if(Net_Wireless_MCW1001_Properties.networkStatus == _NET_WIRELESS_MCW1001_STATUS_CONN_STATIC_IP)
	MOVF        _Net_Wireless_MCW1001_Properties+18, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ConnectToAp58
;WiFi.c,627 :: 		break;
	GOTO        L_ConnectToAp57
L_ConnectToAp58:
;WiFi.c,628 :: 		DrawRfIcon();
	CALL        _DrawRfIcon+0, 0
;WiFi.c,629 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_ConnectToAp59:
	DECFSZ      R13, 1, 1
	BRA         L_ConnectToAp59
	DECFSZ      R12, 1, 1
	BRA         L_ConnectToAp59
	DECFSZ      R11, 1, 1
	BRA         L_ConnectToAp59
	NOP
;WiFi.c,630 :: 		}
	GOTO        L_ConnectToAp56
L_ConnectToAp57:
;WiFi.c,631 :: 		Net_Wireless_MCW1001_TimeToWait = 5;
	MOVLW       5
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+0 
	MOVLW       0
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+1 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+2 
	MOVWF       _Net_Wireless_MCW1001_TimeToWait+3 
;WiFi.c,632 :: 		Sound_Play(800, 400);            // Play sound at 800Hz for 40ms
	MOVLW       32
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;WiFi.c,633 :: 		Delay_ms(50);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_ConnectToAp60:
	DECFSZ      R13, 1, 1
	BRA         L_ConnectToAp60
	DECFSZ      R12, 1, 1
	BRA         L_ConnectToAp60
	DECFSZ      R11, 1, 1
	BRA         L_ConnectToAp60
;WiFi.c,634 :: 		Sound_Play(800, 400);            // Play sound at 800Hz for 40ms
	MOVLW       32
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;WiFi.c,635 :: 		}
L_end_ConnectToAp:
	RETURN      0
; end of _ConnectToAp

_main:

;WiFi.c,679 :: 		void main() {
;WiFi.c,680 :: 		InitMcu();
	CALL        _InitMcu+0, 0
;WiFi.c,683 :: 		LED_Array(EEPROM_Read(0x01));
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_LED_Array_array+0 
	CALL        _LED_Array+0, 0
;WiFi.c,684 :: 		LATA.F5=EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	BTFSC       R0, 0 
	GOTO        L__main116
	BCF         LATA+0, 5 
	GOTO        L__main117
L__main116:
	BSF         LATA+0, 5 
L__main117:
;WiFi.c,685 :: 		LATC.F0=EEPROM_Read(0x00);              // before C2
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	BTFSC       R0, 0 
	GOTO        L__main118
	BCF         LATC+0, 0 
	GOTO        L__main119
L__main118:
	BSF         LATC+0, 0 
L__main119:
;WiFi.c,687 :: 		UART1_Init(19200);
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;WiFi.c,688 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main61:
	DECFSZ      R13, 1, 1
	BRA         L_main61
	DECFSZ      R12, 1, 1
	BRA         L_main61
	DECFSZ      R11, 1, 1
	BRA         L_main61
;WiFi.c,689 :: 		InitWiFi();
	CALL        _InitWiFi+0, 0
;WiFi.c,690 :: 		SearchSSID();
	CALL        _SearchSSID+0, 0
;WiFi.c,691 :: 		ConnectToAp();
	CALL        _ConnectToAp+0, 0
;WiFi.c,692 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;WiFi.c,693 :: 		Lcd_Out(1,1,"System Published");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_WiFi+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_WiFi+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;WiFi.c,695 :: 		Delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main62:
	DECFSZ      R13, 1, 1
	BRA         L_main62
	DECFSZ      R12, 1, 1
	BRA         L_main62
	DECFSZ      R11, 1, 1
	BRA         L_main62
;WiFi.c,696 :: 		find_parameter();
	CALL        _find_parameter+0, 0
;WiFi.c,697 :: 		RunHttpServer();
	CALL        _RunHttpServer+0, 0
;WiFi.c,698 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
