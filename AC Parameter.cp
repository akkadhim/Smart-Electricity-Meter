#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/AC Parameter.c"
sbit Voltage_Detect_LED at LATC1_bit;

sbit Chip_Select at LATE2_bit;
sbit Chip_Select_Direction at TRISE2_bit;

unsigned int current_read,old_value;
float current_read_float;
float current;

float power;
unsigned long count;
unsigned long Price;

float Power_Factor_Float;

unsigned long timer;
unsigned long total;
unsigned long No_Timer_OF;
const unsigned long full_timer = 65535;

unsigned voltage;
unsigned new_value=0;
unsigned value=0;
float voltage_float;
unsigned long sum_of_voltage;

unsigned short freq2write;

char txt[15];
char float_current[10];
char float_powerfactor[10];
float sum_of_current;

unsigned short test=0;



void convert_float_current(unsigned long number){
 unsigned int integer,decimal;

 memset(float_current,'0',6);

 float_current[0]=(integer/10)+48;
 float_current[1]=(integer%10)+48;
 float_current[2]='.';
 decimal= (number-integer)*125;
 float_current[3]=((decimal%10000)/1000)+48;
 float_current[4]=((decimal%1000)/100)+48;
 float_current[5]=((decimal%100)/10)+48;
 float_current[6]=(decimal%10)+48;
}

void convert_float_powerfactor(unsigned int angle){
 memset(float_powerfactor,'0',5);

 float_powerfactor[0]=((angle%10000)/1000)+48;
 float_powerfactor[1]='.';
 float_powerfactor[2]=((angle%1000)/100)+48;
 float_powerfactor[3]=((angle%100)/10)+48;
 float_powerfactor[4]=(angle%10)+48;
}


unsigned Hall_Read() {

 volatile unsigned int tmp0 , tmp1 ;
 unsigned short buffer = 0;
 unsigned int total_hall = 0;

 Chip_Select = 0;
 tmp0 = SPI2_Read(buffer);
 tmp1 = SPI2_Read(buffer);
 Chip_Select = 1;

 total_hall=((tmp1) | (tmp0<<8));

 return total_hall;
}

float get_Current(){
 current_read_float=0;
 current_read=Hall_Read();
 if (((current_read)>>15) == 0) {
 current_read = current_read & 0x1FFF;

 if(current_read>4096)
 {
 current_read = current_read - 4096;
 current_read_float = ((float)current_read * 0.0125);
 }

 else
 {
 current_read_float = -1*((float)current_read * 0.0125);
 }

 }
 return current_read_float;
}

void find_parameter(){




 T0CON = 0b01101111;
 T1CON = 0x40;
 INTCON = 0xC0;
 TMR1IF_bit=0;
 TMR1IE_bit=1;
 TMR0L=0;
 TMR0ON_bit=1;
 Delay_ms(1000);
 TMR0ON_bit=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1,"F=");
 freq2write =TMR0L;
 ByteToStr(freq2write ,txt);
 Lcd_Out_Cp(Rtrim(Ltrim(txt)));
 Lcd_Out_Cp("Hz");

 TMR0L = 0;
 T0CON = 0xC7;
 GIE_bit = 1;
 TMR0IE_bit = 1;

 Voltage_Detect_LED=1;


 Price=0;
 power=0;
 voltage=0;
 current=0;
 count=0;

 TMR1H = 0x00;
 TMR1L = 0x00;
 No_Timer_OF=0;

 TMR1ON_bit =1;
 while(!(No_Timer_OF==10))
 {
 voltage_float=ADC_Read(0)*0.336;
 current = get_Current();
 power=power+(voltage*current);
 count++;
 }
 TMR1ON_bit =0;

 power=power/count;
 Price=power * 1440;
 if (Price<1001) Price=Price*10;
 if (Price<2001) Price=Price*20;
 if (Price<4001) Price=Price*30;
 if (Price>4001) Price=Price*50;




 voltage=0;
 sum_of_voltage=0;
 count=0;
 TMR1H = 0x00;
 TMR1L = 0x00;
 No_Timer_OF=0;
 TMR1ON_bit =1;
 while(!(No_Timer_OF==10))
 {
 new_value=ADC_Read(0)*0.336 ;
 sum_of_voltage= sum_of_voltage+(new_value*new_value);
 count++;
 }
 TMR1ON_bit =0;
 voltage= sqrt((sum_of_voltage*2) / count);



 sum_of_current=0;
 count=0;
 current=0;
 TMR1H = 0x00;
 TMR1L = 0x00;
 No_Timer_OF=0;
 TMR1ON_bit =1;
 while(!(No_Timer_OF==10))
 {
 current = get_Current();
 sum_of_current= sum_of_current+(current*current);
 count++;
 }
 TMR1ON_bit =0;
 current_read_float=sqrt(sum_of_current/count);




 Power_Factor_Float= power/(voltage*current_read_float);




 Lcd_Out(1,1,"                ");
 WordToStr(voltage,txt);
 Lcd_Out(1,1,"V=");
 Lcd_Out_Cp(Rtrim(Ltrim(txt)));

 convert_float_current(current_read_float*1000);
 Lcd_Out(1,8,"C=");
 Lcd_Out_Cp(Rtrim(Ltrim(float_current)));


 Lcd_Out(2,8,"           ");
 Lcd_Out(2,8,"P.F=");
 convert_float_powerfactor(Power_Factor_Float*1000);
 Lcd_Out_Cp(float_powerfactor);
#line 219 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/AC Parameter.c"
}
