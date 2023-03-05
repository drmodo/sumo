unsigned char i;
unsigned int Dcntr;
unsigned int Mcntr;
unsigned char cntr;
void move_forward(void)
{
  PORTD = 0X60;

}
void move_backward(void)
{
 PORTD = 0X90;
}
void turn_left(void)
{
PORTD = 0X40;
}

void turn_right(void)
{
PORTD = 0X20;
}
void myDelay1(unsigned int x){
     Mcntr=0;
     while(Mcntr<x);


}
void myDelay2(void){    // delay function without using any timer because it will used inside the interrupt
    unsigned  char j;
    unsigned int k;
    for(j=0; j<90; j++){
       for(k=0;k<2000; k++){
         j=j;
         k=k;
       }

    }

}

void myShortDelay(void){ // delay function without using any timer because it will used inside the interrupt
    unsigned  char j;
    unsigned int k;
    for(j=0; j<15; j++){
       for(k=0;k<2000; k++){
         j=j;
         k=k;
       }

    }

}

void interrupt(void){

if(INTCON&0x02){ // when an external interrupt occurs
     move_backward();
     myDelay2();
     turn_right();
     myDelay2();
     move_forward();


     INTCON = INTCON & 0xFD;// Clear the interrupt flag

}


if(INTCON&0x04){// will get here every 1ms
    TMR0=248;
    Mcntr++;
    Dcntr++;
    if(Dcntr==500){
      Dcntr=0;


    }
  INTCON = INTCON & 0xFB; //clear T0IF
}
      }

int time_taken;
int distance;





int main()
{   TRISD=0X0F; // the pins RD4-RD7 are connected to the h-bridge and they are used to control the direction of the movement
    TRISB=0x05; /*The pin RB0 is connected to IR senesor and it will cause an interrupt in the falling edge,
    RB1 is set as output pin and used for triger ultrasonic sesor, RB2 is set as input and connected to "echo" pin of ultrasonic sensor */
    T1CON=0x10;// enable Timer1 with prescaler 1:2, is used for triger ultrasonic sensor
    INTCON=0XB0; //enable the global interrupt, external interrupt, and the TM0 overflow interrupt.
    OPTION_REG = 0X87; //Set the external interrupt on the faling edge of the IR sensor, 256 prescaler, overflow every 1ms

    Dcntr=0;
    cntr=0;
    Mcntr=0;
    TMR0=248;
   // myDelay1(5000);
   delay_ms(5000);
while(1)
    {
       /*TMR1H =0;
        TMR1L =0; //clear the timer bits
        PORTB = (PORTB|0x02);// Enable Triger on pin RB1
        delay_us(10);// we used the built-in function to give accurate delay and to use it in distance calculations.
        PORTB = (PORTB&0xFD);   // Disable Triger on RB1

        while ((PORTB&0x04) == 0); //when echo is equal to 1, enable timer1
        T1CON = (T1CON |0x01);
        while ((PORTB&0x04) == 1); //when echo becomes 0, disable timer1
         T1CON=(T1CON&0xFB);

       time_taken = (TMR1L | (TMR1H<<8));  // concatenate the Timer1 High and Timer1 Low (16bit)
       distance= (time_taken)/58.58;*///    Timer1 Frequency = Fosc / 4 = time_taken * 1 /  2MHz * 2 = time_taken * 1 microsecond
       //distance = time_taken * 0.034 / 2  =  time_taken * 0.017 =  time_taken / 58.58

      /*if (distance < 150)    // see if ther is an object with distance < 150cm (the ring diameter )
       {
       move_forward();

       }
           }*/
       move_forward();







    return 0;
}