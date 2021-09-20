#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27,16,2); 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define max_count_ReceiveData 10
#define led_Pin 13 // led xanh close
#define led1_Pin 12 // led do close
#define sw_Pin 2
#define led_on HIGH
#define led_off LOW
#define led1_on HIGH
#define led1_off LOW
int count = 0;
int led1_state = 0;
int led2_state = 0;
int last_led1_state = 0;
int last_led2_state = 0;
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count5 = 0;
int count6 = 0;
int last_swStatus = 0;
String data_change = "";
String data_change1 = "";
char ReceiveData;
char ReceiveData1;
char start_sign = '@';
char end_sign = '&';
char start1_sign = '@';
char end1_sign = '&';
char count_ReceiveData = 0;
char buf_string_receive[max_count_ReceiveData];
char start_Data, end_Data;
char receive_complete = 0;
String buf_string_send1 = "";
String buf_string_send = "";
void setup() {
  // put your setup code here, to run once:
  pinMode(led_Pin, OUTPUT);
  pinMode(led1_Pin, OUTPUT);
  digitalWrite(led_Pin, led_on);
  digitalWrite(led1_Pin, led1_off);
  pinMode(sw_Pin, INPUT_PULLUP);
  Serial3.begin(4800, SERIAL_8N1);
  Serial.begin(9600);
  Serial.println("|------------------------------------------------------------------------|");
  Serial.println("| EXERCISE 2:OVERSEES OPENING AND CLOSING OPERATIONS - ARDUINO MEGA 2560 |");
  Serial.println("|------------------------------------------------------------------------|"); 
  lcd.init();                    
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("STATUS");  
  lcd.setCursor(7,0);
  lcd.print("CLOSED");
  lcd.setCursor(0,1);
  lcd.print("OP");
  lcd.setCursor(7,1);
  lcd.print("CL");
}
void SW_ISR()
{
  count++;
  count6 = count ;
  buf_string_send ="@S" + String(count6) + '&';
  Serial3.print(buf_string_send);
  Serial.println(buf_string_send);
}
void SW_ISR1()
{
  count5++;
  count6 = count5 ;
  buf_string_send1 = "@s" + String(count6) + '&';
  Serial3.print(buf_string_send1);
  Serial.print(buf_string_send1);
}

void loop() {
  delay(50);
  // put your main code here, to run repeatedly:
  int swStatus = digitalRead(sw_Pin);
  if (swStatus != last_swStatus){
  if (swStatus == LOW)
  {
    digitalWrite(led_Pin,led_off);
    digitalWrite(led1_Pin,led1_on);
    Serial.println(" >>> Door Opened");
    Serial.println("|------------------------------------------------------------------------|"); 
    lcd.init();                    
    lcd.backlight();
    lcd.setCursor(1,0);
    lcd.print("STATUS");
    lcd.setCursor(0,1);
    lcd.print("OP");
    lcd.setCursor(7,1);
    lcd.print("CL"); 
    lcd.setCursor(8,0);
    lcd.print("OPENED");
    lcd.setCursor(4,1);
    lcd.print(count6);
    lcd.setCursor(11,1);
    lcd.print(count6);
  }
  else
  {
    digitalWrite(led_Pin,led_on);
    digitalWrite(led1_Pin,led1_off);
    Serial.println(" >>> Door Closed");
    Serial.println("|------------------------------------------------------------------------|"); 
    lcd.init();                    
    lcd.backlight();
    lcd.setCursor(1,0);
    lcd.print("STATUS");
    lcd.setCursor(0,1);
    lcd.print("OP");
    lcd.setCursor(7,1);
    lcd.print("CL"); 
    lcd.setCursor(8,0);
    lcd.print("CLOSED");
    lcd.setCursor(4,1);
    lcd.print(count6);
    lcd.setCursor(11,1);
    lcd.print(count6+1);
  }
  }
  last_swStatus = swStatus;
  led1_state = digitalRead(led_Pin);
  led2_state = digitalRead(led1_Pin);
  if (led1_state != last_led1_state){
    if(led1_state == HIGH){
      count1++;
      count3 = count1 - 1;
      SW_ISR();
      serialEvent3();   
      Serial.println(data_change);
      Serial.println("|------------------------------------------------------------------------|"); 
    }
  }
  delay(50);
   last_led1_state = led1_state;
  if (led2_state != last_led2_state){
    if(led2_state == HIGH){
      count2++;
      SW_ISR1();
      serialEvent3();
      Serial.println(data_change1);
      Serial.println("|------------------------------------------------------------------------|"); 
    } 
  }
    last_led2_state = led2_state;
}
void serialEvent3()
{
  ReceiveData = Serial3.read();
  
  if(ReceiveData == start_sign)
  {
    count_ReceiveData = 0;
    start_Data = ReceiveData;
    buf_string_receive[count_ReceiveData] = ReceiveData;
  }

  else if (ReceiveData = start1_sign)                       
  {
    count_ReceiveData = 0;
    start_Data = ReceiveData;
    buf_string_receive[count_ReceiveData] = ReceiveData;
  }

  
  if(ReceiveData == end_sign)
  {
    end_Data = ReceiveData;
    buf_string_receive[count_ReceiveData] = ReceiveData;
  }
 
  else if (ReceiveData == end1_sign)
  {
    end_Data = ReceiveData;
    buf_string_receive[count_ReceiveData] = ReceiveData;  
  }

  if((start_Data == start_sign) && (end_Data == end_sign))
  {
    receive_complete = 1;
    count_ReceiveData = 0;
    start_Data = NULL;
    end_Data = NULL;
  }
  else if ((start_Data == start1_sign) && (end_Data == end1_sign))
  {
    receive_complete = 1;
    count_ReceiveData = 0;
    start_Data = NULL;
    end_Data = NULL;
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
    
  }
  
void Clear_buf_string_receive(void){
  for(char i = 0; i<= max_count_ReceiveData; i++){
    buf_string_receive[i] = NULL;
  }
}
