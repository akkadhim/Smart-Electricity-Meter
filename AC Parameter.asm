
_convert_float_current:

;AC Parameter.c,38 :: 		void convert_float_current(unsigned long number){
;AC Parameter.c,41 :: 		memset(float_current,'0',6);
	MOVLW       _float_current+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_float_current+0)
	MOVWF       FARG_memset_p1+1 
	MOVLW       48
	MOVWF       FARG_memset_character+0 
	MOVLW       6
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;AC Parameter.c,43 :: 		float_current[0]=(integer/10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_float_current_integer_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_integer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+0 
;AC Parameter.c,44 :: 		float_current[1]=(integer%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_float_current_integer_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_integer_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+1 
;AC Parameter.c,45 :: 		float_current[2]='.';
	MOVLW       46
	MOVWF       _float_current+2 
;AC Parameter.c,46 :: 		decimal= (number-integer)*125;
	MOVF        convert_float_current_integer_L0+0, 0 
	SUBWF       FARG_convert_float_current_number+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_integer_L0+1, 0 
	SUBWFB      FARG_convert_float_current_number+1, 0 
	MOVWF       R1 
	MOVLW       125
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       convert_float_current_decimal_L0+0 
	MOVF        R1, 0 
	MOVWF       convert_float_current_decimal_L0+1 
;AC Parameter.c,47 :: 		float_current[3]=((decimal%10000)/1000)+48;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+3 
;AC Parameter.c,48 :: 		float_current[4]=((decimal%1000)/100)+48;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        convert_float_current_decimal_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_decimal_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+4 
;AC Parameter.c,49 :: 		float_current[5]=((decimal%100)/10)+48;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_float_current_decimal_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_decimal_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+5 
;AC Parameter.c,50 :: 		float_current[6]=(decimal%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_float_current_decimal_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_float_current_decimal_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_current+6 
;AC Parameter.c,51 :: 		}
L_end_convert_float_current:
	RETURN      0
; end of _convert_float_current

_convert_float_powerfactor:

;AC Parameter.c,53 :: 		void convert_float_powerfactor(unsigned int angle){
;AC Parameter.c,54 :: 		memset(float_powerfactor,'0',5);
	MOVLW       _float_powerfactor+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_float_powerfactor+0)
	MOVWF       FARG_memset_p1+1 
	MOVLW       48
	MOVWF       FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;AC Parameter.c,56 :: 		float_powerfactor[0]=((angle%10000)/1000)+48;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        FARG_convert_float_powerfactor_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_convert_float_powerfactor_angle+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_powerfactor+0 
;AC Parameter.c,57 :: 		float_powerfactor[1]='.';
	MOVLW       46
	MOVWF       _float_powerfactor+1 
;AC Parameter.c,58 :: 		float_powerfactor[2]=((angle%1000)/100)+48;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_convert_float_powerfactor_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_convert_float_powerfactor_angle+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_powerfactor+2 
;AC Parameter.c,59 :: 		float_powerfactor[3]=((angle%100)/10)+48;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_convert_float_powerfactor_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_convert_float_powerfactor_angle+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_powerfactor+3 
;AC Parameter.c,60 :: 		float_powerfactor[4]=(angle%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_convert_float_powerfactor_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_convert_float_powerfactor_angle+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _float_powerfactor+4 
;AC Parameter.c,61 :: 		}
L_end_convert_float_powerfactor:
	RETURN      0
; end of _convert_float_powerfactor

_Hall_Read:

;AC Parameter.c,64 :: 		unsigned Hall_Read() {
;AC Parameter.c,67 :: 		unsigned short buffer = 0;
	CLRF        Hall_Read_buffer_L0+0 
;AC Parameter.c,70 :: 		Chip_Select = 0;          // Select MCP3201
	BCF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;AC Parameter.c,71 :: 		tmp0 = SPI2_Read(buffer);  // Get value
	MOVF        Hall_Read_buffer_L0+0, 0 
	MOVWF       FARG_SPI2_Read_buffer+0 
	CALL        _SPI2_Read+0, 0
	MOVF        R0, 0 
	MOVWF       Hall_Read_tmp0_L0+0 
	MOVLW       0
	MOVWF       Hall_Read_tmp0_L0+1 
;AC Parameter.c,72 :: 		tmp1 = SPI2_Read(buffer);  // Get value
	MOVF        Hall_Read_buffer_L0+0, 0 
	MOVWF       FARG_SPI2_Read_buffer+0 
	CALL        _SPI2_Read+0, 0
	MOVF        R0, 0 
	MOVWF       Hall_Read_tmp1_L0+0 
	MOVLW       0
	MOVWF       Hall_Read_tmp1_L0+1 
;AC Parameter.c,73 :: 		Chip_Select = 1;          // Deselect MCP3201
	BSF         LATE2_bit+0, BitPos(LATE2_bit+0) 
;AC Parameter.c,75 :: 		total_hall=((tmp1) | (tmp0<<8));
	MOVF        Hall_Read_tmp0_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        Hall_Read_tmp1_L0+0, 0 
	IORWF       R0, 1 
	MOVF        Hall_Read_tmp1_L0+1, 0 
	IORWF       R1, 1 
;AC Parameter.c,77 :: 		return total_hall;            // Returns value
;AC Parameter.c,78 :: 		}
L_end_Hall_Read:
	RETURN      0
; end of _Hall_Read

_get_Current:

;AC Parameter.c,80 :: 		float get_Current(){
;AC Parameter.c,81 :: 		current_read_float=0;
	CLRF        _current_read_float+0 
	CLRF        _current_read_float+1 
	CLRF        _current_read_float+2 
	CLRF        _current_read_float+3 
;AC Parameter.c,82 :: 		current_read=Hall_Read();
	CALL        _Hall_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _current_read+0 
	MOVF        R1, 0 
	MOVWF       _current_read+1 
;AC Parameter.c,83 :: 		if (((current_read)>>15) == 0) {
	MOVLW       15
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__get_Current18:
	BZ          L__get_Current19
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__get_Current18
L__get_Current19:
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_Current20
	MOVLW       0
	XORWF       R2, 0 
L__get_Current20:
	BTFSS       STATUS+0, 2 
	GOTO        L_get_Current0
;AC Parameter.c,84 :: 		current_read = current_read & 0x1FFF;                     // Get [13:0] bits of current value
	MOVLW       255
	ANDWF       _current_read+0, 0 
	MOVWF       R1 
	MOVF        _current_read+1, 0 
	ANDLW       31
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _current_read+0 
	MOVF        R2, 0 
	MOVWF       _current_read+1 
;AC Parameter.c,86 :: 		if(current_read>4096)
	MOVF        R2, 0 
	SUBLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L__get_Current21
	MOVF        R1, 0 
	SUBLW       0
L__get_Current21:
	BTFSC       STATUS+0, 0 
	GOTO        L_get_Current1
;AC Parameter.c,88 :: 		current_read = current_read - 4096;                       // Map the current value
	MOVLW       0
	SUBWF       _current_read+0, 0 
	MOVWF       R0 
	MOVLW       16
	SUBWFB      _current_read+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _current_read+0 
	MOVF        R1, 0 
	MOVWF       _current_read+1 
;AC Parameter.c,89 :: 		current_read_float = ((float)current_read * 0.0125);        // Calculate the current value in Amperes
	CALL        _Word2Double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       120
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _current_read_float+0 
	MOVF        R1, 0 
	MOVWF       _current_read_float+1 
	MOVF        R2, 0 
	MOVWF       _current_read_float+2 
	MOVF        R3, 0 
	MOVWF       _current_read_float+3 
;AC Parameter.c,90 :: 		}
	GOTO        L_get_Current2
L_get_Current1:
;AC Parameter.c,94 :: 		current_read_float = -1*((float)current_read * 0.0125);        // Calculate the current value in Amperes
	MOVF        _current_read+0, 0 
	MOVWF       R0 
	MOVF        _current_read+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       120
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _current_read_float+0 
	MOVF        R1, 0 
	MOVWF       _current_read_float+1 
	MOVF        R2, 0 
	MOVWF       _current_read_float+2 
	MOVF        R3, 0 
	MOVWF       _current_read_float+3 
;AC Parameter.c,95 :: 		}
L_get_Current2:
;AC Parameter.c,97 :: 		}
L_get_Current0:
;AC Parameter.c,98 :: 		return current_read_float;
	MOVF        _current_read_float+0, 0 
	MOVWF       R0 
	MOVF        _current_read_float+1, 0 
	MOVWF       R1 
	MOVF        _current_read_float+2, 0 
	MOVWF       R2 
	MOVF        _current_read_float+3, 0 
	MOVWF       R3 
;AC Parameter.c,99 :: 		}
L_end_get_Current:
	RETURN      0
; end of _get_Current

_find_parameter:

;AC Parameter.c,101 :: 		void find_parameter(){
;AC Parameter.c,106 :: 		T0CON  = 0b01101111;
	MOVLW       111
	MOVWF       T0CON+0 
;AC Parameter.c,107 :: 		T1CON  = 0x40;
	MOVLW       64
	MOVWF       T1CON+0 
;AC Parameter.c,108 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;AC Parameter.c,109 :: 		TMR1IF_bit=0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;AC Parameter.c,110 :: 		TMR1IE_bit=1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;AC Parameter.c,111 :: 		TMR0L=0;                              // clear TMR0
	CLRF        TMR0L+0 
;AC Parameter.c,112 :: 		TMR0ON_bit=1;                        //start Counting
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;AC Parameter.c,113 :: 		Delay_ms(1000);                      // Delay 1 Sec
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_find_parameter3:
	DECFSZ      R13, 1, 1
	BRA         L_find_parameter3
	DECFSZ      R12, 1, 1
	BRA         L_find_parameter3
	DECFSZ      R11, 1, 1
	BRA         L_find_parameter3
;AC Parameter.c,114 :: 		TMR0ON_bit=0;                        //Stop Counting
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;AC Parameter.c,115 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AC Parameter.c,116 :: 		Lcd_Out(2,1,"F=");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,117 :: 		freq2write =TMR0L;                  // divide by 2
	MOVF        TMR0L+0, 0 
	MOVWF       _freq2write+0 
;AC Parameter.c,118 :: 		ByteToStr(freq2write ,txt);
	MOVF        _freq2write+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _txt+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;AC Parameter.c,119 :: 		Lcd_Out_Cp(Rtrim(Ltrim(txt)));
	MOVLW       _txt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AC Parameter.c,120 :: 		Lcd_Out_Cp("Hz");
	MOVLW       ?lstr2_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AC Parameter.c,122 :: 		TMR0L = 0;               // Timer0 initial value
	CLRF        TMR0L+0 
;AC Parameter.c,123 :: 		T0CON = 0xC7;            // Set TMR0 to 8bit mode and prescaler to 256
	MOVLW       199
	MOVWF       T0CON+0 
;AC Parameter.c,124 :: 		GIE_bit = 1;             // Enable global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;AC Parameter.c,125 :: 		TMR0IE_bit = 1;          // Enable Timer0 interrupt
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;AC Parameter.c,127 :: 		Voltage_Detect_LED=1;
	BSF         LATC1_bit+0, BitPos(LATC1_bit+0) 
;AC Parameter.c,130 :: 		Price=0;
	CLRF        _Price+0 
	CLRF        _Price+1 
	CLRF        _Price+2 
	CLRF        _Price+3 
;AC Parameter.c,131 :: 		power=0;
	CLRF        _power+0 
	CLRF        _power+1 
	CLRF        _power+2 
	CLRF        _power+3 
;AC Parameter.c,132 :: 		voltage=0;
	CLRF        _voltage+0 
	CLRF        _voltage+1 
;AC Parameter.c,133 :: 		current=0;
	CLRF        _current+0 
	CLRF        _current+1 
	CLRF        _current+2 
	CLRF        _current+3 
;AC Parameter.c,134 :: 		count=0;
	CLRF        _count+0 
	CLRF        _count+1 
	CLRF        _count+2 
	CLRF        _count+3 
;AC Parameter.c,136 :: 		TMR1H         = 0x00;
	CLRF        TMR1H+0 
;AC Parameter.c,137 :: 		TMR1L         = 0x00;
	CLRF        TMR1L+0 
;AC Parameter.c,138 :: 		No_Timer_OF=0;
	CLRF        _No_Timer_OF+0 
	CLRF        _No_Timer_OF+1 
	CLRF        _No_Timer_OF+2 
	CLRF        _No_Timer_OF+3 
;AC Parameter.c,140 :: 		TMR1ON_bit =1;
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,141 :: 		while(!(No_Timer_OF==10))                                        //count 20ms
L_find_parameter4:
	MOVLW       0
	MOVWF       R0 
	XORWF       _No_Timer_OF+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter23
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter23
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter23
	MOVF        _No_Timer_OF+0, 0 
	XORLW       10
L__find_parameter23:
	BTFSC       STATUS+0, 2 
	GOTO        L_find_parameter5
;AC Parameter.c,143 :: 		voltage_float=ADC_Read(0)*0.336;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       49
	MOVWF       R4 
	MOVLW       8
	MOVWF       R5 
	MOVLW       44
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage_float+0 
	MOVF        R1, 0 
	MOVWF       _voltage_float+1 
	MOVF        R2, 0 
	MOVWF       _voltage_float+2 
	MOVF        R3, 0 
	MOVWF       _voltage_float+3 
;AC Parameter.c,144 :: 		current = get_Current();
	CALL        _get_Current+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__find_parameter+0 
	MOVF        R1, 0 
	MOVWF       FLOC__find_parameter+1 
	MOVF        R2, 0 
	MOVWF       FLOC__find_parameter+2 
	MOVF        R3, 0 
	MOVWF       FLOC__find_parameter+3 
	MOVF        FLOC__find_parameter+0, 0 
	MOVWF       _current+0 
	MOVF        FLOC__find_parameter+1, 0 
	MOVWF       _current+1 
	MOVF        FLOC__find_parameter+2, 0 
	MOVWF       _current+2 
	MOVF        FLOC__find_parameter+3, 0 
	MOVWF       _current+3 
;AC Parameter.c,145 :: 		power=power+(voltage*current);
	MOVF        _voltage+0, 0 
	MOVWF       R0 
	MOVF        _voltage+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__find_parameter+0, 0 
	MOVWF       R4 
	MOVF        FLOC__find_parameter+1, 0 
	MOVWF       R5 
	MOVF        FLOC__find_parameter+2, 0 
	MOVWF       R6 
	MOVF        FLOC__find_parameter+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _power+0, 0 
	MOVWF       R4 
	MOVF        _power+1, 0 
	MOVWF       R5 
	MOVF        _power+2, 0 
	MOVWF       R6 
	MOVF        _power+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _power+0 
	MOVF        R1, 0 
	MOVWF       _power+1 
	MOVF        R2, 0 
	MOVWF       _power+2 
	MOVF        R3, 0 
	MOVWF       _power+3 
;AC Parameter.c,146 :: 		count++;
	MOVLW       1
	ADDWF       _count+0, 1 
	MOVLW       0
	ADDWFC      _count+1, 1 
	ADDWFC      _count+2, 1 
	ADDWFC      _count+3, 1 
;AC Parameter.c,147 :: 		}
	GOTO        L_find_parameter4
L_find_parameter5:
;AC Parameter.c,148 :: 		TMR1ON_bit =0;
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,150 :: 		power=power/count;
	MOVF        _count+0, 0 
	MOVWF       R0 
	MOVF        _count+1, 0 
	MOVWF       R1 
	MOVF        _count+2, 0 
	MOVWF       R2 
	MOVF        _count+3, 0 
	MOVWF       R3 
	CALL        _Longword2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _power+0, 0 
	MOVWF       R0 
	MOVF        _power+1, 0 
	MOVWF       R1 
	MOVF        _power+2, 0 
	MOVWF       R2 
	MOVF        _power+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _power+0 
	MOVF        R1, 0 
	MOVWF       _power+1 
	MOVF        R2, 0 
	MOVWF       _power+2 
	MOVF        R3, 0 
	MOVWF       _power+3 
;AC Parameter.c,151 :: 		Price=power * 1440;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Longword+0, 0
	MOVF        R0, 0 
	MOVWF       _Price+0 
	MOVF        R1, 0 
	MOVWF       _Price+1 
	MOVF        R2, 0 
	MOVWF       _Price+2 
	MOVF        R3, 0 
	MOVWF       _Price+3 
;AC Parameter.c,152 :: 		if (Price<1001) Price=Price*10;
	MOVLW       0
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter24
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter24
	MOVLW       3
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter24
	MOVLW       233
	SUBWF       R0, 0 
L__find_parameter24:
	BTFSC       STATUS+0, 0 
	GOTO        L_find_parameter6
	MOVF        _Price+0, 0 
	MOVWF       R0 
	MOVF        _Price+1, 0 
	MOVWF       R1 
	MOVF        _Price+2, 0 
	MOVWF       R2 
	MOVF        _Price+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Price+0 
	MOVF        R1, 0 
	MOVWF       _Price+1 
	MOVF        R2, 0 
	MOVWF       _Price+2 
	MOVF        R3, 0 
	MOVWF       _Price+3 
L_find_parameter6:
;AC Parameter.c,153 :: 		if (Price<2001) Price=Price*20;
	MOVLW       0
	SUBWF       _Price+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter25
	MOVLW       0
	SUBWF       _Price+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter25
	MOVLW       7
	SUBWF       _Price+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter25
	MOVLW       209
	SUBWF       _Price+0, 0 
L__find_parameter25:
	BTFSC       STATUS+0, 0 
	GOTO        L_find_parameter7
	MOVF        _Price+0, 0 
	MOVWF       R0 
	MOVF        _Price+1, 0 
	MOVWF       R1 
	MOVF        _Price+2, 0 
	MOVWF       R2 
	MOVF        _Price+3, 0 
	MOVWF       R3 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Price+0 
	MOVF        R1, 0 
	MOVWF       _Price+1 
	MOVF        R2, 0 
	MOVWF       _Price+2 
	MOVF        R3, 0 
	MOVWF       _Price+3 
L_find_parameter7:
;AC Parameter.c,154 :: 		if (Price<4001) Price=Price*30;
	MOVLW       0
	SUBWF       _Price+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter26
	MOVLW       0
	SUBWF       _Price+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter26
	MOVLW       15
	SUBWF       _Price+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter26
	MOVLW       161
	SUBWF       _Price+0, 0 
L__find_parameter26:
	BTFSC       STATUS+0, 0 
	GOTO        L_find_parameter8
	MOVF        _Price+0, 0 
	MOVWF       R0 
	MOVF        _Price+1, 0 
	MOVWF       R1 
	MOVF        _Price+2, 0 
	MOVWF       R2 
	MOVF        _Price+3, 0 
	MOVWF       R3 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Price+0 
	MOVF        R1, 0 
	MOVWF       _Price+1 
	MOVF        R2, 0 
	MOVWF       _Price+2 
	MOVF        R3, 0 
	MOVWF       _Price+3 
L_find_parameter8:
;AC Parameter.c,155 :: 		if (Price>4001) Price=Price*50;
	MOVF        _Price+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter27
	MOVF        _Price+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter27
	MOVF        _Price+1, 0 
	SUBLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter27
	MOVF        _Price+0, 0 
	SUBLW       161
L__find_parameter27:
	BTFSC       STATUS+0, 0 
	GOTO        L_find_parameter9
	MOVF        _Price+0, 0 
	MOVWF       R0 
	MOVF        _Price+1, 0 
	MOVWF       R1 
	MOVF        _Price+2, 0 
	MOVWF       R2 
	MOVF        _Price+3, 0 
	MOVWF       R3 
	MOVLW       50
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Price+0 
	MOVF        R1, 0 
	MOVWF       _Price+1 
	MOVF        R2, 0 
	MOVWF       _Price+2 
	MOVF        R3, 0 
	MOVWF       _Price+3 
L_find_parameter9:
;AC Parameter.c,160 :: 		voltage=0;
	CLRF        _voltage+0 
	CLRF        _voltage+1 
;AC Parameter.c,161 :: 		sum_of_voltage=0;
	CLRF        _sum_of_voltage+0 
	CLRF        _sum_of_voltage+1 
	CLRF        _sum_of_voltage+2 
	CLRF        _sum_of_voltage+3 
;AC Parameter.c,162 :: 		count=0;
	CLRF        _count+0 
	CLRF        _count+1 
	CLRF        _count+2 
	CLRF        _count+3 
;AC Parameter.c,163 :: 		TMR1H         = 0x00;
	CLRF        TMR1H+0 
;AC Parameter.c,164 :: 		TMR1L         = 0x00;
	CLRF        TMR1L+0 
;AC Parameter.c,165 :: 		No_Timer_OF=0;
	CLRF        _No_Timer_OF+0 
	CLRF        _No_Timer_OF+1 
	CLRF        _No_Timer_OF+2 
	CLRF        _No_Timer_OF+3 
;AC Parameter.c,166 :: 		TMR1ON_bit =1;
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,167 :: 		while(!(No_Timer_OF==10))                                        //count 20ms
L_find_parameter10:
	MOVLW       0
	MOVWF       R0 
	XORWF       _No_Timer_OF+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter28
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter28
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter28
	MOVF        _No_Timer_OF+0, 0 
	XORLW       10
L__find_parameter28:
	BTFSC       STATUS+0, 2 
	GOTO        L_find_parameter11
;AC Parameter.c,169 :: 		new_value=ADC_Read(0)*0.336 ;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       49
	MOVWF       R4 
	MOVLW       8
	MOVWF       R5 
	MOVLW       44
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _new_value+0 
	MOVF        R1, 0 
	MOVWF       _new_value+1 
;AC Parameter.c,170 :: 		sum_of_voltage= sum_of_voltage+(new_value*new_value);
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _sum_of_voltage+0, 1 
	MOVF        R1, 0 
	ADDWFC      _sum_of_voltage+1, 1 
	MOVLW       0
	ADDWFC      _sum_of_voltage+2, 1 
	ADDWFC      _sum_of_voltage+3, 1 
;AC Parameter.c,171 :: 		count++;
	MOVLW       1
	ADDWF       _count+0, 1 
	MOVLW       0
	ADDWFC      _count+1, 1 
	ADDWFC      _count+2, 1 
	ADDWFC      _count+3, 1 
;AC Parameter.c,172 :: 		}
	GOTO        L_find_parameter10
L_find_parameter11:
;AC Parameter.c,173 :: 		TMR1ON_bit =0;
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,174 :: 		voltage= sqrt((sum_of_voltage*2) / count);
	MOVF        _sum_of_voltage+0, 0 
	MOVWF       R0 
	MOVF        _sum_of_voltage+1, 0 
	MOVWF       R1 
	MOVF        _sum_of_voltage+2, 0 
	MOVWF       R2 
	MOVF        _sum_of_voltage+3, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        _count+0, 0 
	MOVWF       R4 
	MOVF        _count+1, 0 
	MOVWF       R5 
	MOVF        _count+2, 0 
	MOVWF       R6 
	MOVF        _count+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	CALL        _Longword2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
;AC Parameter.c,178 :: 		sum_of_current=0;
	CLRF        _sum_of_current+0 
	CLRF        _sum_of_current+1 
	CLRF        _sum_of_current+2 
	CLRF        _sum_of_current+3 
;AC Parameter.c,179 :: 		count=0;
	CLRF        _count+0 
	CLRF        _count+1 
	CLRF        _count+2 
	CLRF        _count+3 
;AC Parameter.c,180 :: 		current=0;
	CLRF        _current+0 
	CLRF        _current+1 
	CLRF        _current+2 
	CLRF        _current+3 
;AC Parameter.c,181 :: 		TMR1H         = 0x00;
	CLRF        TMR1H+0 
;AC Parameter.c,182 :: 		TMR1L         = 0x00;
	CLRF        TMR1L+0 
;AC Parameter.c,183 :: 		No_Timer_OF=0;
	CLRF        _No_Timer_OF+0 
	CLRF        _No_Timer_OF+1 
	CLRF        _No_Timer_OF+2 
	CLRF        _No_Timer_OF+3 
;AC Parameter.c,184 :: 		TMR1ON_bit =1;
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,185 :: 		while(!(No_Timer_OF==10))                                        //count 20ms
L_find_parameter12:
	MOVLW       0
	MOVWF       R0 
	XORWF       _No_Timer_OF+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter29
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter29
	MOVF        R0, 0 
	XORWF       _No_Timer_OF+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__find_parameter29
	MOVF        _No_Timer_OF+0, 0 
	XORLW       10
L__find_parameter29:
	BTFSC       STATUS+0, 2 
	GOTO        L_find_parameter13
;AC Parameter.c,187 :: 		current = get_Current();
	CALL        _get_Current+0, 0
	MOVF        R0, 0 
	MOVWF       _current+0 
	MOVF        R1, 0 
	MOVWF       _current+1 
	MOVF        R2, 0 
	MOVWF       _current+2 
	MOVF        R3, 0 
	MOVWF       _current+3 
;AC Parameter.c,188 :: 		sum_of_current= sum_of_current+(current*current);
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _sum_of_current+0, 0 
	MOVWF       R4 
	MOVF        _sum_of_current+1, 0 
	MOVWF       R5 
	MOVF        _sum_of_current+2, 0 
	MOVWF       R6 
	MOVF        _sum_of_current+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _sum_of_current+0 
	MOVF        R1, 0 
	MOVWF       _sum_of_current+1 
	MOVF        R2, 0 
	MOVWF       _sum_of_current+2 
	MOVF        R3, 0 
	MOVWF       _sum_of_current+3 
;AC Parameter.c,189 :: 		count++;
	MOVLW       1
	ADDWF       _count+0, 1 
	MOVLW       0
	ADDWFC      _count+1, 1 
	ADDWFC      _count+2, 1 
	ADDWFC      _count+3, 1 
;AC Parameter.c,190 :: 		}
	GOTO        L_find_parameter12
L_find_parameter13:
;AC Parameter.c,191 :: 		TMR1ON_bit =0;
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;AC Parameter.c,192 :: 		current_read_float=sqrt(sum_of_current/count);
	MOVF        _count+0, 0 
	MOVWF       R0 
	MOVF        _count+1, 0 
	MOVWF       R1 
	MOVF        _count+2, 0 
	MOVWF       R2 
	MOVF        _count+3, 0 
	MOVWF       R3 
	CALL        _Longword2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _sum_of_current+0, 0 
	MOVWF       R0 
	MOVF        _sum_of_current+1, 0 
	MOVWF       R1 
	MOVF        _sum_of_current+2, 0 
	MOVWF       R2 
	MOVF        _sum_of_current+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__find_parameter+0 
	MOVF        R1, 0 
	MOVWF       FLOC__find_parameter+1 
	MOVF        R2, 0 
	MOVWF       FLOC__find_parameter+2 
	MOVF        R3, 0 
	MOVWF       FLOC__find_parameter+3 
	MOVF        FLOC__find_parameter+0, 0 
	MOVWF       _current_read_float+0 
	MOVF        FLOC__find_parameter+1, 0 
	MOVWF       _current_read_float+1 
	MOVF        FLOC__find_parameter+2, 0 
	MOVWF       _current_read_float+2 
	MOVF        FLOC__find_parameter+3, 0 
	MOVWF       _current_read_float+3 
;AC Parameter.c,197 :: 		Power_Factor_Float= power/(voltage*current_read_float);
	MOVF        _voltage+0, 0 
	MOVWF       R0 
	MOVF        _voltage+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__find_parameter+0, 0 
	MOVWF       R4 
	MOVF        FLOC__find_parameter+1, 0 
	MOVWF       R5 
	MOVF        FLOC__find_parameter+2, 0 
	MOVWF       R6 
	MOVF        FLOC__find_parameter+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _power+0, 0 
	MOVWF       R0 
	MOVF        _power+1, 0 
	MOVWF       R1 
	MOVF        _power+2, 0 
	MOVWF       R2 
	MOVF        _power+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _Power_Factor_Float+0 
	MOVF        R1, 0 
	MOVWF       _Power_Factor_Float+1 
	MOVF        R2, 0 
	MOVWF       _Power_Factor_Float+2 
	MOVF        R3, 0 
	MOVWF       _Power_Factor_Float+3 
;AC Parameter.c,202 :: 		Lcd_Out(1,1,"                ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,203 :: 		WordToStr(voltage,txt);
	MOVF        _voltage+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _voltage+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;AC Parameter.c,204 :: 		Lcd_Out(1,1,"V=");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,205 :: 		Lcd_Out_Cp(Rtrim(Ltrim(txt)));
	MOVLW       _txt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AC Parameter.c,207 :: 		convert_float_current(current_read_float*1000);
	MOVF        _current_read_float+0, 0 
	MOVWF       R0 
	MOVF        _current_read_float+1, 0 
	MOVWF       R1 
	MOVF        _current_read_float+2, 0 
	MOVWF       R2 
	MOVF        _current_read_float+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Longword+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_convert_float_current_number+0 
	MOVF        R1, 0 
	MOVWF       FARG_convert_float_current_number+1 
	MOVF        R2, 0 
	MOVWF       FARG_convert_float_current_number+2 
	MOVF        R3, 0 
	MOVWF       FARG_convert_float_current_number+3 
	CALL        _convert_float_current+0, 0
;AC Parameter.c,208 :: 		Lcd_Out(1,8,"C=");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,209 :: 		Lcd_Out_Cp(Rtrim(Ltrim(float_current)));
	MOVLW       _float_current+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_float_current+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Rtrim_string+0 
	MOVF        R1, 0 
	MOVWF       FARG_Rtrim_string+1 
	CALL        _Rtrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AC Parameter.c,212 :: 		Lcd_Out(2,8,"           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,213 :: 		Lcd_Out(2,8,"P.F=");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_AC_32Parameter+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_AC_32Parameter+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AC Parameter.c,214 :: 		convert_float_powerfactor(Power_Factor_Float*1000);
	MOVF        _Power_Factor_Float+0, 0 
	MOVWF       R0 
	MOVF        _Power_Factor_Float+1, 0 
	MOVWF       R1 
	MOVF        _Power_Factor_Float+2, 0 
	MOVWF       R2 
	MOVF        _Power_Factor_Float+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_convert_float_powerfactor_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_convert_float_powerfactor_angle+1 
	CALL        _convert_float_powerfactor+0, 0
;AC Parameter.c,215 :: 		Lcd_Out_Cp(float_powerfactor);
	MOVLW       _float_powerfactor+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(_float_powerfactor+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AC Parameter.c,219 :: 		}
L_end_find_parameter:
	RETURN      0
; end of _find_parameter
