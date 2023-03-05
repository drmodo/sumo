#line 1 "D:/PSUT/First Semester 2021-2022/Embedded Systems/project/project2/PROJECT3/New folder/projectFinal.c"
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
void myDelay2(void){
 unsigned char j;
 unsigned int k;
 for(j=0; j<90; j++){
 for(k=0;k<2000; k++){
 j=j;
 k=k;
 }

 }

}

void myShortDelay(void){
 unsigned char j;
 unsigned int k;
 for(j=0; j<15; j++){
 for(k=0;k<2000; k++){
 j=j;
 k=k;
 }

 }

}

void interrupt(void){

if(INTCON&0x02){
 move_backward();
 myDelay2();
 turn_right();
 myDelay2();
 move_forward();


 INTCON = INTCON & 0xFD;

}


if(INTCON&0x04){
 TMR0=248;
 Mcntr++;
 Dcntr++;
 if(Dcntr==500){
 Dcntr=0;


 }
 INTCON = INTCON & 0xFB;
}
 }

int time_taken;
int distance;





int main()
{ TRISD=0X0F;
#line 93 "D:/PSUT/First Semester 2021-2022/Embedded Systems/project/project2/PROJECT3/New folder/projectFinal.c"
 TRISB=0x05;
 T1CON=0x10;
 INTCON=0XB0;
 OPTION_REG = 0X87;

 Dcntr=0;
 cntr=0;
 Mcntr=0;
 TMR0=248;

 delay_ms(5000);
while(1)
 {
#line 127 "D:/PSUT/First Semester 2021-2022/Embedded Systems/project/project2/PROJECT3/New folder/projectFinal.c"
 move_forward();







 return 0;
}
