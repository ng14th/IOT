
_Clear_buf_string_receive:

;BAIVENHApic.c,48 :: 		void Clear_buf_string_receive(void)
;BAIVENHApic.c,50 :: 		for (i=0;i<max_count_ReceiveData; i++)
	CLRF        _i+0 
L_Clear_buf_string_receive0:
	MOVLW       10
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Clear_buf_string_receive1
;BAIVENHApic.c,52 :: 		buf_string_receive[i] = '\0';
	MOVLW       _buf_string_receive+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buf_string_receive+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;BAIVENHApic.c,50 :: 		for (i=0;i<max_count_ReceiveData; i++)
	INCF        _i+0, 1 
;BAIVENHApic.c,53 :: 		}
	GOTO        L_Clear_buf_string_receive0
L_Clear_buf_string_receive1:
;BAIVENHApic.c,54 :: 		}
L_end_Clear_buf_string_receive:
	RETURN      0
; end of _Clear_buf_string_receive

_interrupt:

;BAIVENHApic.c,56 :: 		void interrupt(void)
;BAIVENHApic.c,58 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt3
;BAIVENHApic.c,60 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;BAIVENHApic.c,61 :: 		count++ ;
	INFSNZ      _count+0, 1 
	INCF        _count+1, 1 
;BAIVENHApic.c,62 :: 		sprintf(buffer,"@s%d&", count);
	MOVLW       _buffer+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_BAIVENHApic+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _count+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _count+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;BAIVENHApic.c,63 :: 		sprintf(buffer2,"%d",count+1);
	MOVLW       _buffer2+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_buffer2+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_2_BAIVENHApic+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_2_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_2_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       1
	ADDWF       _count+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVLW       0
	ADDWFC      _count+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;BAIVENHApic.c,64 :: 		UART1_Write_Text(buffer);
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BAIVENHApic.c,66 :: 		}
L_interrupt3:
;BAIVENHApic.c,67 :: 		while(INTCON.INT0IF == 0);
L_interrupt4:
	BTFSC       INTCON+0, 1 
	GOTO        L_interrupt5
	GOTO        L_interrupt4
L_interrupt5:
;BAIVENHApic.c,69 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;BAIVENHApic.c,70 :: 		count1++ ;
	INFSNZ      _count1+0, 1 
	INCF        _count1+1, 1 
;BAIVENHApic.c,71 :: 		sprintf(buffer1,"@S%d&", count1+1);
	MOVLW       _buffer1+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_buffer1+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_3_BAIVENHApic+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_3_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_3_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       1
	ADDWF       _count1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVLW       0
	ADDWFC      _count1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;BAIVENHApic.c,72 :: 		sprintf(buffer3,"%d",count1+1);
	MOVLW       _buffer3+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_buffer3+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_4_BAIVENHApic+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_4_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_4_BAIVENHApic+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       1
	ADDWF       _count1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVLW       0
	ADDWFC      _count1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;BAIVENHApic.c,73 :: 		UART1_Write_Text(buffer1);
	MOVLW       _buffer1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;BAIVENHApic.c,76 :: 		if(PIR1.RCIF == 1)
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt6
;BAIVENHApic.c,78 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;BAIVENHApic.c,79 :: 		ReceiveData = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ReceiveData+0 
;BAIVENHApic.c,80 :: 		if (ReceiveData == start_sign)
	MOVF        R0, 0 
	XORWF       _start_sign+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;BAIVENHApic.c,82 :: 		count_ReceiveData = 0;
	CLRF        _count_ReceiveData+0 
;BAIVENHApic.c,83 :: 		start_Data = ReceiveData;
	MOVF        _ReceiveData+0, 0 
	MOVWF       _start_Data+0 
;BAIVENHApic.c,84 :: 		buf_string_receive[count_ReceiveData] = ReceiveData;
	MOVLW       _buf_string_receive+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buf_string_receive+0)
	MOVWF       FSR1H 
	MOVF        _count_ReceiveData+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _ReceiveData+0, 0 
	MOVWF       POSTINC1+0 
;BAIVENHApic.c,85 :: 		}
L_interrupt7:
;BAIVENHApic.c,86 :: 		if (ReceiveData == end_sign)
	MOVF        _ReceiveData+0, 0 
	XORWF       _end_sign+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;BAIVENHApic.c,88 :: 		end_Data = ReceiveData;
	MOVF        _ReceiveData+0, 0 
	MOVWF       _end_Data+0 
;BAIVENHApic.c,89 :: 		buf_string_receive[count_ReceiveData] = ReceiveData;
	MOVLW       _buf_string_receive+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buf_string_receive+0)
	MOVWF       FSR1H 
	MOVF        _count_ReceiveData+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _ReceiveData+0, 0 
	MOVWF       POSTINC1+0 
;BAIVENHApic.c,90 :: 		}
L_interrupt8:
;BAIVENHApic.c,91 :: 		if ((start_Data == start_sign) && (end_Data == end_sign))
	MOVF        _start_Data+0, 0 
	XORWF       _start_sign+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
	MOVF        _end_Data+0, 0 
	XORWF       _end_sign+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
L__interrupt18:
;BAIVENHApic.c,93 :: 		receive_complete = 1;
	MOVLW       1
	MOVWF       _receive_complete+0 
;BAIVENHApic.c,94 :: 		count_ReceiveData = 0;
	CLRF        _count_ReceiveData+0 
;BAIVENHApic.c,95 :: 		start_Data = '\0';
	CLRF        _start_Data+0 
;BAIVENHApic.c,96 :: 		end_Data = '\0';
	CLRF        _end_Data+0 
;BAIVENHApic.c,97 :: 		}
	GOTO        L_interrupt12
L_interrupt11:
;BAIVENHApic.c,100 :: 		buf_string_receive[count_ReceiveData] = ReceiveData;
	MOVLW       _buf_string_receive+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buf_string_receive+0)
	MOVWF       FSR1H 
	MOVF        _count_ReceiveData+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _ReceiveData+0, 0 
	MOVWF       POSTINC1+0 
;BAIVENHApic.c,101 :: 		count_ReceiveData++;
	INCF        _count_ReceiveData+0, 1 
;BAIVENHApic.c,102 :: 		if(count_ReceiveData > max_count_ReceiveData)
	MOVF        _count_ReceiveData+0, 0 
	SUBLW       10
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt13
;BAIVENHApic.c,104 :: 		count_ReceiveData = 0;
	CLRF        _count_ReceiveData+0 
;BAIVENHApic.c,105 :: 		}
L_interrupt13:
;BAIVENHApic.c,106 :: 		}
L_interrupt12:
;BAIVENHApic.c,107 :: 		receive_complete = 0;
	CLRF        _receive_complete+0 
;BAIVENHApic.c,108 :: 		count_ReceiveData = 0;
	CLRF        _count_ReceiveData+0 
;BAIVENHApic.c,109 :: 		Clear_buf_string_receive();
	CALL        _Clear_buf_string_receive+0, 0
;BAIVENHApic.c,110 :: 		}
L_interrupt6:
;BAIVENHApic.c,111 :: 		}
L_end_interrupt:
L__interrupt21:
	RETFIE      1
; end of _interrupt

_main:

;BAIVENHApic.c,116 :: 		void main()
;BAIVENHApic.c,118 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;BAIVENHApic.c,119 :: 		Lcd_Cmd(_Lcd_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BAIVENHApic.c,120 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BAIVENHApic.c,121 :: 		Lcd_Out(2,12,"1");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,122 :: 		Lcd_Out(2,5,"0");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,123 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;BAIVENHApic.c,124 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;BAIVENHApic.c,125 :: 		PORTB= 0x00;
	CLRF        PORTB+0 
;BAIVENHApic.c,126 :: 		LATB = 0x00;
	CLRF        LATB+0 
;BAIVENHApic.c,127 :: 		TRISB.TRISB0 = 1;
	BSF         TRISB+0, 0 
;BAIVENHApic.c,128 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;BAIVENHApic.c,129 :: 		LATE = 0x00;
	CLRF        LATE+0 
;BAIVENHApic.c,130 :: 		TRISE.TRISE0 = off;
	BCF         TRISE+0, 0 
;BAIVENHApic.c,131 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;BAIVENHApic.c,132 :: 		LATD = 0x00;
	CLRF        LATD+0 
;BAIVENHApic.c,133 :: 		TRISD.TRISD0 = off;
	BCF         TRISD+0, 0 
;BAIVENHApic.c,134 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;BAIVENHApic.c,135 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;BAIVENHApic.c,136 :: 		INTCON2.INTEDG0 =1;
	BSF         INTCON2+0, 6 
;BAIVENHApic.c,137 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;BAIVENHApic.c,138 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;BAIVENHApic.c,139 :: 		INTCON.GIE =1;
	BSF         INTCON+0, 7 
;BAIVENHApic.c,140 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;BAIVENHApic.c,141 :: 		UART1_Init(4800);
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       17
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BAIVENHApic.c,142 :: 		while(1)
L_main14:
;BAIVENHApic.c,144 :: 		Lcd_Out(1,1, "STATUS");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,145 :: 		Lcd_Out(2,2, "OP");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,146 :: 		Lcd_Out(2,9, "CL");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,148 :: 		if(PORTB.B0 == 1 )
	BTFSS       PORTB+0, 0 
	GOTO        L_main16
;BAIVENHApic.c,150 :: 		LATE.B0 = 1;
	BSF         LATE+0, 0 
;BAIVENHApic.c,151 :: 		LATD.B0 = 0;
	BCF         LATD+0, 0 
;BAIVENHApic.c,152 :: 		Lcd_Out(1,8,"CLOSED");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,153 :: 		Lcd_out(2,12,buffer3);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _buffer3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_buffer3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,154 :: 		}
	GOTO        L_main17
L_main16:
;BAIVENHApic.c,157 :: 		LATD.B0 = 1;
	BSF         LATD+0, 0 
;BAIVENHApic.c,158 :: 		LATE.B0 = 0;
	BCF         LATE+0, 0 
;BAIVENHApic.c,159 :: 		Lcd_Out(1,8,"OPENED");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_BAIVENHApic+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_BAIVENHApic+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,160 :: 		Lcd_out(2,5,buffer2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _buffer2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_buffer2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;BAIVENHApic.c,161 :: 		}
L_main17:
;BAIVENHApic.c,162 :: 		}
	GOTO        L_main14
;BAIVENHApic.c,163 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
