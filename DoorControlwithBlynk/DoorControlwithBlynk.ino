#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27,16,2); 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#define sw_Pin 2   
#define led_Pin 16 
#define led1_Pin 0 
#define led_on HIGH
#define led_off LOW
#define led1_on HIGH
#define led1_off LOW
int buttonPushCounter = 0;   
int buttonState = 0;        
int lastButtonState = 0;  
String count_string_send = "";
String count_string_send1 = "";
char auth[] = "9rOqk_5Gwnigy0VfAqq_c2J3mUMBRK4F";
char ssid[] = "ngeenth";
char pass[] = "147258369";

WidgetTerminal terminal(V1);
BLYNK_WRITE(V1)
{
  if (String("Open") == param.asStr())
  {
      digitalWrite(led_Pin,led_off);
      digitalWrite(led1_Pin,led1_on); 
      buttonPushCounter++;
      Serial.println(buttonPushCounter);
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
      lcd.print(buttonPushCounter);
      lcd.setCursor(11,1);
      lcd.print(buttonPushCounter);
      count_string_send ="So Lan Cua Mo " + String(buttonPushCounter);
      terminal.println(count_string_send);
      terminal.flush(); 
  }
  else if (String("Close") == param.asStr())
  { 
      digitalWrite(led1_Pin,led1_off);
      digitalWrite(led_Pin,led_on);
      lcd.init();                    
      lcd.backlight();
      lcd.setCursor(1,0);
      lcd.print("STATUS");
      lcd.setCursor(0,1);
      lcd.print("OP");
      lcd.setCursor(7,1);
      lcd.print("CL"); 
      lcd.setCursor(4,1);
      lcd.print(buttonPushCounter);
      lcd.setCursor(8,0);
      lcd.print("CLOSED");
      lcd.setCursor(11,1);
      lcd.print(buttonPushCounter+1);
      count_string_send1 ="So Lan Cua Dong " + String(buttonPushCounter+1);
      terminal.println(count_string_send1); 
      terminal.flush();     
  }
  terminal.flush();
}

void setup() 
{
  pinMode(sw_Pin, INPUT);
  pinMode(led_Pin, OUTPUT);
  pinMode(led1_Pin, OUTPUT);
  Serial.begin(115200);
  digitalWrite(led_Pin,led_on);
  digitalWrite(led1_Pin,led1_off);
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
  Blynk.begin(auth, ssid, pass);
  terminal.clear();
  terminal.flush();
}


void loop() 
{    
  buttonState = digitalRead(sw_Pin);
  if (buttonState != lastButtonState) 
  {
    if (buttonState == LOW) 
    {
      digitalWrite(led_Pin,led_off);
      digitalWrite(led1_Pin,led1_on); 
      buttonPushCounter++;
      Serial.println(buttonPushCounter);
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
      lcd.print(buttonPushCounter);
      lcd.setCursor(11,1);
      lcd.print(buttonPushCounter);
      count_string_send ="So Lan Cua Mo " + String(buttonPushCounter);
      terminal.println(count_string_send);
      terminal.flush(); 
    }
    else 
    {
      digitalWrite(led_Pin,led_on);
      digitalWrite(led1_Pin,led1_off); 
      Serial.println(buttonPushCounter);
      lcd.init();                    
      lcd.backlight();
      lcd.setCursor(1,0);
      lcd.print("STATUS");
      lcd.setCursor(0,1);
      lcd.print("OP");
      lcd.setCursor(7,1);
      lcd.print("CL"); 
      lcd.setCursor(4,1);
      lcd.print(buttonPushCounter);
      lcd.setCursor(8,0);
      lcd.print("CLOSED");
      lcd.setCursor(11,1);
      lcd.print(buttonPushCounter+1);
      count_string_send1 ="So Lan Cua Dong " + String(buttonPushCounter+1);
      terminal.println(count_string_send1); 
      terminal.flush();     
    }
    delay(500);
  }
  lastButtonState = buttonState;
  Blynk.run();
}
