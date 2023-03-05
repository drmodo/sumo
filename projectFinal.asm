
_move_forward:

;projectFinal.c,5 :: 		void move_forward(void)
;projectFinal.c,7 :: 		PORTD = 0X60;
	MOVLW      96
	MOVWF      PORTD+0
;projectFinal.c,9 :: 		}
L_end_move_forward:
	RETURN
; end of _move_forward

_move_backward:

;projectFinal.c,10 :: 		void move_backward(void)
;projectFinal.c,12 :: 		PORTD = 0X90;
	MOVLW      144
	MOVWF      PORTD+0
;projectFinal.c,13 :: 		}
L_end_move_backward:
	RETURN
; end of _move_backward

_turn_left:

;projectFinal.c,14 :: 		void turn_left(void)
;projectFinal.c,16 :: 		PORTD = 0X40;
	MOVLW      64
	MOVWF      PORTD+0
;projectFinal.c,17 :: 		}
L_end_turn_left:
	RETURN
; end of _turn_left

_turn_right:

;projectFinal.c,19 :: 		void turn_right(void)
;projectFinal.c,21 :: 		PORTD = 0X20;
	MOVLW      32
	MOVWF      PORTD+0
;projectFinal.c,22 :: 		}
L_end_turn_right:
	RETURN
; end of _turn_right

_myDelay1:

;projectFinal.c,23 :: 		void myDelay1(unsigned int x){
;projectFinal.c,24 :: 		Mcntr=0;
	CLRF       _Mcntr+0
	CLRF       _Mcntr+1
;projectFinal.c,25 :: 		while(Mcntr<x);
L_myDelay10:
	MOVF       FARG_myDelay1_x+1, 0
	SUBWF      _Mcntr+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay130
	MOVF       FARG_myDelay1_x+0, 0
	SUBWF      _Mcntr+0, 0
L__myDelay130:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay11
	GOTO       L_myDelay10
L_myDelay11:
;projectFinal.c,28 :: 		}
L_end_myDelay1:
	RETURN
; end of _myDelay1

_myDelay2:

;projectFinal.c,29 :: 		void myDelay2(void){    // delay function without using any timer because it will used inside the interrupt
;projectFinal.c,32 :: 		for(j=0; j<90; j++){
	CLRF       R1+0
L_myDelay22:
	MOVLW      90
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay23
;projectFinal.c,33 :: 		for(k=0;k<2000; k++){
	CLRF       R2+0
	CLRF       R2+1
L_myDelay25:
	MOVLW      7
	SUBWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay232
	MOVLW      208
	SUBWF      R2+0, 0
L__myDelay232:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay26
;projectFinal.c,34 :: 		j=j;
;projectFinal.c,35 :: 		k=k;
;projectFinal.c,33 :: 		for(k=0;k<2000; k++){
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;projectFinal.c,36 :: 		}
	GOTO       L_myDelay25
L_myDelay26:
;projectFinal.c,32 :: 		for(j=0; j<90; j++){
	INCF       R1+0, 1
;projectFinal.c,38 :: 		}
	GOTO       L_myDelay22
L_myDelay23:
;projectFinal.c,40 :: 		}
L_end_myDelay2:
	RETURN
; end of _myDelay2

_myShortDelay:

;projectFinal.c,42 :: 		void myShortDelay(void){ // delay function without using any timer because it will used inside the interrupt
;projectFinal.c,45 :: 		for(j=0; j<15; j++){
	CLRF       R1+0
L_myShortDelay8:
	MOVLW      15
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_myShortDelay9
;projectFinal.c,46 :: 		for(k=0;k<2000; k++){
	CLRF       R2+0
	CLRF       R2+1
L_myShortDelay11:
	MOVLW      7
	SUBWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myShortDelay34
	MOVLW      208
	SUBWF      R2+0, 0
L__myShortDelay34:
	BTFSC      STATUS+0, 0
	GOTO       L_myShortDelay12
;projectFinal.c,47 :: 		j=j;
;projectFinal.c,48 :: 		k=k;
;projectFinal.c,46 :: 		for(k=0;k<2000; k++){
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;projectFinal.c,49 :: 		}
	GOTO       L_myShortDelay11
L_myShortDelay12:
;projectFinal.c,45 :: 		for(j=0; j<15; j++){
	INCF       R1+0, 1
;projectFinal.c,51 :: 		}
	GOTO       L_myShortDelay8
L_myShortDelay9:
;projectFinal.c,53 :: 		}
L_end_myShortDelay:
	RETURN
; end of _myShortDelay

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;projectFinal.c,55 :: 		void interrupt(void){
;projectFinal.c,57 :: 		if(INTCON&0x02){ // when an external interrupt occurs
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt14
;projectFinal.c,58 :: 		move_backward();
	CALL       _move_backward+0
;projectFinal.c,59 :: 		myDelay2();
	CALL       _myDelay2+0
;projectFinal.c,60 :: 		turn_right();
	CALL       _turn_right+0
;projectFinal.c,61 :: 		myDelay2();
	CALL       _myDelay2+0
;projectFinal.c,62 :: 		move_forward();
	CALL       _move_forward+0
;projectFinal.c,65 :: 		INTCON = INTCON & 0xFD;// Clear the interrupt flag
	MOVLW      253
	ANDWF      INTCON+0, 1
;projectFinal.c,67 :: 		}
L_interrupt14:
;projectFinal.c,70 :: 		if(INTCON&0x04){// will get here every 1ms
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt15
;projectFinal.c,71 :: 		TMR0=248;
	MOVLW      248
	MOVWF      TMR0+0
;projectFinal.c,72 :: 		Mcntr++;
	INCF       _Mcntr+0, 1
	BTFSC      STATUS+0, 2
	INCF       _Mcntr+1, 1
;projectFinal.c,73 :: 		Dcntr++;
	INCF       _Dcntr+0, 1
	BTFSC      STATUS+0, 2
	INCF       _Dcntr+1, 1
;projectFinal.c,74 :: 		if(Dcntr==500){
	MOVF       _Dcntr+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt37
	MOVLW      244
	XORWF      _Dcntr+0, 0
L__interrupt37:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
;projectFinal.c,75 :: 		Dcntr=0;
	CLRF       _Dcntr+0
	CLRF       _Dcntr+1
;projectFinal.c,78 :: 		}
L_interrupt16:
;projectFinal.c,79 :: 		INTCON = INTCON & 0xFB; //clear T0IF
	MOVLW      251
	ANDWF      INTCON+0, 1
;projectFinal.c,80 :: 		}
L_interrupt15:
;projectFinal.c,81 :: 		}
L_end_interrupt:
L__interrupt36:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;projectFinal.c,90 :: 		int main()
;projectFinal.c,91 :: 		{   TRISD=0X0F; // the pins RD4-RD7 are connected to the h-bridge and they are used to control the direction of the movement
	MOVLW      15
	MOVWF      TRISD+0
;projectFinal.c,93 :: 		RB1 is set as output pin and used for triger ultrasonic sesor, RB2 is set as input and connected to "echo" pin of ultrasonic sensor */
	MOVLW      5
	MOVWF      TRISB+0
;projectFinal.c,94 :: 		T1CON=0x10;// enable Timer1 with prescaler 1:2, is used for triger ultrasonic sensor
	MOVLW      16
	MOVWF      T1CON+0
;projectFinal.c,95 :: 		INTCON=0XB0; //enable the global interrupt, external interrupt, and the TM0 overflow interrupt.
	MOVLW      176
	MOVWF      INTCON+0
;projectFinal.c,96 :: 		OPTION_REG = 0X87; //Set the external interrupt on the faling edge of the IR sensor, 256 prescaler, overflow every 1ms
	MOVLW      135
	MOVWF      OPTION_REG+0
;projectFinal.c,98 :: 		Dcntr=0;
	CLRF       _Dcntr+0
	CLRF       _Dcntr+1
;projectFinal.c,99 :: 		cntr=0;
	CLRF       _cntr+0
;projectFinal.c,100 :: 		Mcntr=0;
	CLRF       _Mcntr+0
	CLRF       _Mcntr+1
;projectFinal.c,101 :: 		TMR0=248;
	MOVLW      248
	MOVWF      TMR0+0
;projectFinal.c,102 :: 		myDelay1(5000);
	MOVLW      136
	MOVWF      FARG_myDelay1_x+0
	MOVLW      19
	MOVWF      FARG_myDelay1_x+1
	CALL       _myDelay1+0
;projectFinal.c,103 :: 		while(1)
L_main17:
;projectFinal.c,105 :: 		TMR1H =0;
	CLRF       TMR1H+0
;projectFinal.c,106 :: 		TMR1L =0; //clear the timer bits
	CLRF       TMR1L+0
;projectFinal.c,107 :: 		PORTB = (PORTB|0x02);// Enable Triger on pin RB1
	BSF        PORTB+0, 1
;projectFinal.c,108 :: 		delay_us(10);// we used the built-in function to give accurate delay and to use it in distance calculations.
	MOVLW      6
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	NOP
;projectFinal.c,109 :: 		PORTB = (PORTB&0xFD);   // Disable Triger on RB1
	MOVLW      253
	ANDWF      PORTB+0, 1
;projectFinal.c,111 :: 		while ((PORTB&0x04) == 0); //when echo is equal to 1, enable timer1
L_main20:
	MOVLW      4
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main21
	GOTO       L_main20
L_main21:
;projectFinal.c,112 :: 		T1CON = (T1CON |0x01);
	BSF        T1CON+0, 0
;projectFinal.c,113 :: 		while ((PORTB&0x04) == 1); //when echo becomes 0, disable timer1
L_main22:
	MOVLW      4
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	GOTO       L_main22
L_main23:
;projectFinal.c,114 :: 		T1CON=(T1CON&0xFB);
	MOVLW      251
	ANDWF      T1CON+0, 1
;projectFinal.c,116 :: 		time_taken = (TMR1L | (TMR1H<<8));  // concatenate the Timer1 High and Timer1 Low (16bit)
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _time_taken+0
	MOVF       R0+1, 0
	MOVWF      _time_taken+1
;projectFinal.c,117 :: 		distance= (time_taken)/58.58;//    Timer1 Frequency = Fosc / 4 = time_taken * 1 /  2MHz * 2 = time_taken * 1 microsecond
	CALL       _int2double+0
	MOVLW      236
	MOVWF      R4+0
	MOVLW      81
	MOVWF      R4+1
	MOVLW      106
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _distance+0
	MOVF       R0+1, 0
	MOVWF      _distance+1
;projectFinal.c,120 :: 		if (distance < 150)    // see if ther is an object with distance < 150cm (the ring diameter )
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVLW      150
	SUBWF      R0+0, 0
L__main39:
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;projectFinal.c,122 :: 		move_forward();
	CALL       _move_forward+0
;projectFinal.c,124 :: 		}
L_main24:
;projectFinal.c,125 :: 		}
	GOTO       L_main17
;projectFinal.c,135 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
