#define on 1
#define off 0
#define max_count_ReceiveData 10
#define len_code 5
unsigned char i;
char ReceiveData;
char buffer[15];
char buffer1[15];
char buffer2[15];
char buffer3[15];
int count =0;
int count1 =0;
int count2 = 0;
int count3 = 0;
bit oldstate;
char led_on_code[]= "le_on";
char led_off_code[]= "le_of";
char start_sign ='@';
char end_sign = '&';
char count_ReceiveData = 0;
char buf_string_receive[max_count_ReceiveData];
char start_Data, end_Data;
char receive_complete = 0;

// LCD //

sbit LCD_RS at LATD1_bit;
sbit LCD_EN at LATD2_bit;
sbit LCD_D4 at LATD3_bit;
sbit LCD_D5 at LATD4_bit;
sbit LCD_D6 at LATD5_bit;
sbit LCD_D7 at LATD7_bit;

sbit LCD_RS_Direction at TRISD1_bit;
sbit LCD_EN_Direction at TRISD2_bit;
sbit LCD_D4_Direction at TRISD3_bit;
sbit LCD_D5_Direction at TRISD4_bit;
sbit LCD_D6_Direction at TRISD5_bit;
sbit LCD_D7_Direction at TRISD7_bit;








void Clear_buf_string_receive(void)
{
    for (i=0;i<max_count_ReceiveData; i++)
    {
        buf_string_receive[i] = '\0';
    }
}

void interrupt(void)
{
  if(INTCON.INT0IF == 1)
  {
    INTCON.INT0IF = 0;
    count++ ;
    sprintf(buffer,"@s%d&", count);
    sprintf(buffer2,"%d",count+1);
    UART1_Write_Text(buffer);

  }
   while(INTCON.INT0IF == 0);
   {
    INTCON.INT0IF = 0;
    count1++ ;
    sprintf(buffer1,"@S%d&", count1+1);
    sprintf(buffer3,"%d",count1+1);
    UART1_Write_Text(buffer1);

   }
  if(PIR1.RCIF == 1)
  {
    PIR1.RCIF = 0;
    ReceiveData = UART1_Read();
    if (ReceiveData == start_sign)
    {
     count_ReceiveData = 0;
     start_Data = ReceiveData;
     buf_string_receive[count_ReceiveData] = ReceiveData;
    }
    if (ReceiveData == end_sign)
    {
     end_Data = ReceiveData;
     buf_string_receive[count_ReceiveData] = ReceiveData;
    }
    if ((start_Data == start_sign) && (end_Data == end_sign))
    {
      receive_complete = 1;
      count_ReceiveData = 0;
      start_Data = '\0';
      end_Data = '\0';
    }
    else
    {
     buf_string_receive[count_ReceiveData] = ReceiveData;
     count_ReceiveData++;
     if(count_ReceiveData > max_count_ReceiveData)
       {
        count_ReceiveData = 0;
       }
    }
      receive_complete = 0;
      count_ReceiveData = 0;
      Clear_buf_string_receive();
    }
}




void main()
{
  Lcd_Init();
  Lcd_Cmd(_Lcd_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Out(2,12,"1");
  Lcd_Out(2,5,"0");
  ADCON1 |= 0x0F;
  CMCON  |= 7;
  PORTB= 0x00;
  LATB = 0x00;
  TRISB.TRISB0 = 1;
  PORTE = 0x00;
  LATE = 0x00;
  TRISE.TRISE0 = off;
  PORTD = 0x00;
  LATD = 0x00;
  TRISD.TRISD0 = off;
  INTCON.INT0IF = 0;
  INTCON.INT0IE = 1;
  INTCON2.INTEDG0 =1;
  PIR1.RCIF = 0;
  PIE1.RCIE = 1;
  INTCON.GIE =1;
  INTCON.PEIE = 1;
  UART1_Init(4800);
  while(1)
  {
         Lcd_Out(1,1, "STATUS");
         Lcd_Out(2,2, "OP");
         Lcd_Out(2,9, "CL");

         if(PORTB.B0 == 1 )
        {
         LATE.B0 = 1;
         LATD.B0 = 0;
         Lcd_Out(1,8,"CLOSED");
         Lcd_out(2,12,buffer3);
        }
         else
        {
         LATD.B0 = 1;
         LATE.B0 = 0;
         Lcd_Out(1,8,"OPENED");
         Lcd_out(2,5,buffer2);
        }
  }
}