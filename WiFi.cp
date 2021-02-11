#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
sbit Net_Wireless_MCW1001_Chip_RST at LATE0_bit;
sbit Net_Wireless_MCW1001_Chip_RST_Direction at TRISE0_bit;
#line 7 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
sbit Chip_Select at LATE2_bit;
sbit Chip_Select_Direction at TRISE2_bit;




sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;



char txt1[] = "  Electricity  ";
char txt2[] = "Monitoring Systm";

char txt4[] = "Initialize";
char txt5[] = "WiFi Module...";
char txt6[] = "Connecting to";
char txt7[] = "AccessPoint";

char txt22[4];
extern float current_read_float;
extern float Power_Factor_Float;








void find_parameter();
extern unsigned long No_Timer_OF;
extern unsigned voltage;
extern unsigned short freq2write;
extern unsigned long Price;

const unsigned int MAX_SIZE_OF_DATA = 489;
char txBuffer[MAX_SIZE_OF_DATA];
unsigned int bufferIndex = 0;
unsigned short Switches;
bit Action;
unsigned short bitMask;

char channels[11] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
char strSSID[13] = "Home-Network";
char wpaPassword[11] = "AAAAAAAA";
char response, wifiStatus, connInProgressMark = 0;
char bindResponse, listenResponse, socketHandle, backLog, socketChild;

unsigned int remotePort, localPort;
char remoteIpAdd[4];

unsigned char myMacAddr[6] = {0x22, 0x33, 0x44, 0x55, 0x66, 0x88};
unsigned char myIpAddr[4] = {192, 168, 3, 119} ;
unsigned char gwIpAddr[4] = {192, 168, 3, 33} ;
unsigned char ipMask[4] = {255, 255, 255, 0 } ;

unsigned char getRequest[15] ;
unsigned char dyna[29] ;
unsigned long httpCounter = 0 ;
#line 82 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
const code char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: " ;
const code char httpMimeTypeHTML[] = "text/html\n\n" ;
const code char httpMimeTypeScript[] = "text/plain\n\n" ;
unsigned char httpMethod[] = "GET /";
#line 92 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
const code char *indexPage =
#line 138 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
"<meta http-equiv=\"refresh\" content=\"8;url=http://192.168.3.119\"><HTML><head><title>Electricity Monitoring System</title><script src=/s></script><style type=\"text/css\">.Type {        background-color: #FFFFFF;        font-size: 16px;        font-style: normal;        font-weight: bold;        height: 0.5cm;}.Switches {        background-color: #CCC;}.HeaderName {       font-size: 20px;       background-color: #666666;       font-weight: bold;       color: #FFF;}.Voltage {        font-family: \"Quartz MS\";        font-size: 36px;        font-weight: normal;        background-color: #000000;        color: #F00;        text-align: center;}.Status {        background-color: #999;}.HeadTitle {        font-size: 50px;        font-weight: bold;        background-color: #FC0;        text-align: center;        color: #000;}.Price {        background-color: #CCFF00;        font-size: 24px;        color: #000;}" ;

const code char *indexPage2 =
#line 219 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
"</style></head><body><table width=\"730\" height=\"400\" border=\"1\" align=\"center\">  <tr>    <td width=\"730\" height=\"200\" colspan=\"6\" align=\"center\" class=\"HeadTitle\"><p>Electricity Monitoring System</p>    <p>for Home User</p></td>  </tr>  <tr class=\"HeaderName\">    <td width=\"53\" height=\"40\" align=\"center\">Status</td>    <td width=\"166\" align=\"center\">Voltage</td>    <td width=\"166\" align=\"center\">Current</td>    <td width=\"154\" align=\"center\">Frequency</td>    <td width=\"58\" align=\"center\">Power Factor</td>    <td width=\"133\" align=\"center\">Action</td>  </tr>  <tr>    <script>                        var str;                        str=\"\";                        {if(AN0>150)                           {str+=\"<td align=\"+\"center\"+\" bgcolor=#FF0000>ON\";}                         else                            {str+=\"<td align=\"+\"center\"+\" bgcolor=#999999>OFF\";}                        str+=\"</td>\";}                        document.write(str) ;    </script>    <td class=\"Voltage\"><script>document.write(AN0)</script></td>    <td class=\"Voltage\"><script>document.write(AN1)</script></td>    <td class=\"Voltage\"><script>document.write(AN2)</script></td>    <td class=\"Voltage\"><script>document.write(AN3)</script></td>    <script>                        var str;                        str=\"\";                        if(Action)                        {                                str+=\"<td align=center bgcolor=#00FF00><a href=/l0>Line<br>ON</a></td>\";                        }                        else                         {                                str+=\"<td align=center bgcolor=#999999><a href=/l1>Line<br>OFF</a></td>\";                        }                        document.write(str) ;    </script>  </tr></table><table  width=\"730\" border=\"1\" align=\"center\">  <tr>    <td align=\"center\" class=\"Price\" height=\"40\">Your bill for month if you continue with this consuming</td>    <td align=\"center\" class=\"Price\" height=\"40\"><script>document.write(AN4)I.D</script></td>  </tr></table><table  width=\"730\" border=\"1\" align=\"center\">  <tr>    <td colspan=\"8\" align=\"center\" class=\"HeaderName\" height=\"40\"><span class=\"HeaderName\">Switches</td>  </tr>  <tr>    <script>        var i,str;        str=\"\";                for(i=0;i<8;i++)        {        if(Switches&(1<<i))        {                str+=\"<td class=Switches align=center bgcolor=#FF0000><a href=/t\"+i+\">Switch<br>ON</a></td>\";        }        else         {                str+=\"<td class=Switches align=center bgcolor=#FFFFFF><a href=/t\"+i+\">Switch<br>OFF</a></td>\";        }        }        document.write(str)        </script>  </tr></table></body></HTML>" ;




const char character0[] = {0,0,0,0,0,0,0,0};
const char character1[] = {0,0,0,0,0,0,16,0};
const char character2[] = {0,0,0,0,24,4,20,0};
const char character3[] = {0,0,28,2,25,5,21,0};
char rfIconMark = 1;

void DrawRfIcon() {
 char i;
 const char *ch;

 if(rfIconMark == 4) {
 ch = character0;
 rfIconMark = 0;
 }
 else {
 switch(rfIconMark) {
 case 1: {
 ch = character1;
 break;
 }
 case 2: {
 ch = character2;
 break;
 }
 case 3: {
 ch = character3;
 break;
 }
 }
 }
 rfIconMark++;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(ch[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(2, 16, 0);
}




unsigned int wifiTmr = 0;
void interrupt() {
 if (TMR0IF_bit) {
 wifiTmr++;
 if(wifiTmr >= 122) {
 Net_Wireless_MCW1001_Time++ ;
 wifiTmr = 0;
 }
 TMR0IF_bit = 0;
 TMR0L = 0;
 }

 if (TMR1IF_bit){
 No_Timer_OF++ ;
 if (No_Timer_OF==9){
 TMR1H = 0x3B;
 TMR1L = 0xCE;
 }
 TMR1IF_bit=0;
 }
}



void LED_Array(unsigned short array){
 LATD.F2=(array & (1<<0));
 LATD.F3=(array & (1<<1))>>1;
 LATD.F4=(array & (1<<2))>>2;
 LATD.F5=(array & (1<<3))>>3;
 LATD.F6=(array & (1<<4))>>4;
 LATD.F7=(array & (1<<5))>>5;
 LATC.F3=(array & (1<<6))>>6;
 LATC.F2=(array & (1<<7))>>7;
}





void InitMcu() {
 ANSELB = 0;
 ANSELC = 0;
 ANSELD = 0;
 ANSELE = 0;
 ANSELA.F0=1;
 ANSELA.F1=1;
 ANSELA.F4=0;
 ANSELA.F5=0;

 TRISA.F0=1;
 TRISA.F1=1;
 TRISA.F4=1;
 TRISA.F5=0;
 TRISD =0;
 TRISC.F2=0;
 TRISC.F3=0;
 TRISC.F1=0;
 TRISC.F0=0;
 SLRCON = 0;

 LATD=0;
 LATC.F0=0;
 LATC.F1=0;
 LATC.F2=0;
 LATC.F3=0;


 TMR0L = 0;
 T0CON = 0xC7;
 GIE_bit = 1;
 TMR0IE_bit = 1;

 Chip_Select_Direction =0;
 Chip_Select = 1;

 SPI2_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_HIGH_2_LOW);
 Delay_ms(100);

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,txt1);
 Lcd_Out(2,1,txt2);
 Delay_ms(2000);

 Sound_Init(&PORTE, 1);
 Net_Wireless_MCW1001_HwReset();
 Sound_Play(1000, 400);

}




void InitWiFi() {
 char response;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,txt4);
 Lcd_Out(2,1,txt5);
 Delay_ms(2000);

 Net_Wireless_MCW1001_TimeToWait = 1;
 response = 1;

 while(response != 0){
 response = Net_Wireless_MCW1001_SetMode(_NET_WIRELESS_MCW1001_CP_2, _NET_WIRELESS_MCW1001_MODE_INFRASTRUCTURE);
 }

 Net_Wireless_MCW1001_TimeToWait = 5;
 Net_Wireless_MCW1001_SetChannelList(11, channels);
 Net_Wireless_MCW1001_SetSecurity_WPA(_NET_WIRELESS_MCW1001_CP_1, _NET_WIRELESS_MCW1001_WPA_PSK2, wpaPassword);
 Net_Wireless_MCW1001_SetSSID(_NET_WIRELESS_MCW1001_CP_1, strSSID);


 Net_Wireless_MCW1001_SetNetworkMask(ipMask);
 Net_Wireless_MCW1001_SetGatewayIP(gwIpAddr);
 Net_Wireless_MCW1001_SetMAC(myMacAddr);
 Net_Wireless_MCW1001_SetIP(myIpAddr);

 Net_Wireless_MCW1001_SetArpTime(1);
 Net_Wireless_MCW1001_SetRetryCount(5, 0);
 Net_Wireless_MCW1001_SocketAllocate(2, 0, 2048, 2048, 0, 0);

}




unsigned int PutConstString(const code char *s) {
 unsigned int numOfSentBytes;

 while(*s) {
 txBuffer[bufferIndex++] = *s++;
 if(bufferIndex == MAX_SIZE_OF_DATA) {
 Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, MAX_SIZE_OF_DATA, &numOfSentBytes);
 bufferIndex = 0;
 }
 }
 return(bufferIndex) ;
}




unsigned int PutString(char *s) {
 unsigned int numOfSentBytes;

 while(*s) {
 txBuffer[bufferIndex++] = *s++;
 if(bufferIndex == MAX_SIZE_OF_DATA) {
 Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, MAX_SIZE_OF_DATA, &numOfSentBytes);
 bufferIndex = 0;
 }
 }
 return(bufferIndex) ;
}



void SendHttpResponse()
{

 char response, i , AnCounter;
 unsigned int numOfReceiveBytes = 0, numOfSentBytes;
 unsigned int length ;
 char StatusVar[4];

 length = 0;
 Net_Wireless_MCW1001_TCP_ReadBytes(&socketChild, 10, getRequest, &numOfReceiveBytes);
 getRequest[10] = 0;

 if(memcmp(getRequest, httpMethod, 5)) {
 return;
 }


 httpCounter++ ;
 if(getRequest[5] == 's') {

 find_parameter();


 bufferIndex = 0;
 PutConstString(httpHeader) ;
 PutConstString(httpMimeTypeScript) ;



 WordToStr(voltage,dyna) ;
 PutConstString("var AN0=") ;
 PutString(Rtrim(Ltrim(dyna)));
 PutConstString(";") ;

 PutConstString("var AN1=") ;
 floattostr(current_read_float,dyna);
 PutString(dyna);
 PutConstString(";") ;

 ByteToStr(freq2write,dyna) ;
 PutConstString("var AN2=") ;
 PutString(Rtrim(Ltrim(dyna)));
 PutConstString(";") ;

 floattostr(Power_Factor_Float,dyna);
 PutConstString("var AN3=") ;
 PutString(dyna);
 PutConstString(";") ;

 LongWordToStr(Price,dyna) ;
 PutConstString("var AN4=") ;
 PutString(Rtrim(Ltrim(dyna)));
 PutConstString(";") ;

 Action=EEPROM_Read(0x00)& 1;
 memset(txt22,0,4);
 txt22[0]=Action+48;
 PutConstString("var Action=") ;
 PutString(Rtrim(Ltrim(txt22))) ;
 PutConstString(";") ;

 Switches=(EEPROM_Read(0x01));
 Bytetostr(Switches,txt22);
 PutConstString("var Switches=") ;
 PutString(Rtrim(Ltrim(txt22))) ;
 length = PutConstString(";") ;

 if(length != 0)
 Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, length, &numOfSentBytes);

 }

 else if(getRequest[5] == 't') {
 bitMask = 0 ;
 Sound_Play(800, 40);
 if(isdigit(getRequest[6])) {
 bitMask = getRequest[6] - '0' ;
 bitMask = 1 << bitMask ;
 Switches ^= bitMask ;
 EEPROM_Write(0x01,Switches);
 LED_Array(Switches);
 }

 }

 else if(getRequest[5] == 'l') {
 bitMask = 0 ;
 Sound_Play(800, 40);
 if(isdigit(getRequest[6])) {
 bitMask = getRequest[6] - '0' ;
 Action = bitMask ;
 lata.f5 = Action;
 latc.f0 = Action;
 EEPROM_Write(0x00,Action);
 }

 }

 if(length == 0) {

 bufferIndex = 0;
 PutConstString(httpHeader) ;
 PutConstString(httpMimeTypeHTML) ;
 PutConstString(indexPage) ;
 length = PutConstString(indexPage2) ;
 if(length != 0)
 Net_Wireless_MCW1001_TCP_SendBytes(socketChild, txBuffer, length, &numOfSentBytes);

 }
}



void RunHttpServer() {

 while(1) {
 socketHandle = 0;
 backLog = 1;
 localPort = 80;
 Net_Wireless_MCW1001_SocketCreate(&socketHandle, _NET_WIRELESS_MCW1001_SOCKET_TYPE_TCP);
 Net_Wireless_MCW1001_SocketBind(socketHandle, &localPort, &bindResponse);
 Net_Wireless_MCW1001_TCP_Listen(socketHandle, &backLog, &listenResponse);

 while(1) {
 socketChild = socketHandle;
 Net_Wireless_MCW1001_TCP_Accept(&socketChild, &remotePort, remoteIpAdd);
 if (socketChild != 254) {
 break;
 }
 }

 SendHttpResponse();
 Net_Wireless_MCW1001_SocketClose(socketChild);
 Net_Wireless_MCW1001_SocketClose(socketHandle);
 }
}



void SearchSSID() {
char markFound, numOfScanRes, response, i;
char strTmp[33];


 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Search SSID...");
 Delay_ms(1000);
 markFound = 0;
 while(markFound != 1) {
 while(1) {
 response = Net_Wireless_MCW1001_ScanStart(255, &numOfScanRes);
 if(response == 0)
 break;
 Delay_ms(500);
 }

 for(i = 1; i <= numOfScanRes; i++) {
 response = Net_Wireless_MCW1001_GetScanResult(i);
 strncpy(strTmp, Net_Wireless_MCW1001_ScanResult.SSID, Net_Wireless_MCW1001_ScanResult.SSIDLength);

 if(Net_Wireless_MCW1001_ScanResult.SSIDLength > 13) {
 strTmp[14] = '\0';
 strTmp[13] = '.';
 strTmp[12] = '.';
 strTmp[11] = '.';
 }
 else
 strTmp[Net_Wireless_MCW1001_ScanResult.SSIDLength] = '\0';

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"SSIDs Found:");
 Lcd_Out(2,1,strTmp);
 if(strncmp(Net_Wireless_MCW1001_ScanResult.SSID, strSSID, Net_Wireless_MCW1001_ScanResult.SSIDLength) == 0) {
 markFound = 1;
 Delay_ms(700);
 break;
 }
 Delay_ms(700);
 }
 }
}



void ConnectToAp() {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,txt6);
 Lcd_Out(2,1,txt7);


 Net_Wireless_MCW1001_TimeToWait = 1;
 Net_Wireless_MCW1001_Connect(_NET_WIRELESS_MCW1001_CP_1, &wifiStatus);





 Net_Wireless_MCW1001_Properties.networkStatus = _NET_WIRELESS_MCW1001_STATUS_NOTCONN_STATIC_IP;
 while(1) {
 Net_Wireless_MCW1001_GetNetworkStatus();
 if(Net_Wireless_MCW1001_Properties.networkStatus == _NET_WIRELESS_MCW1001_STATUS_CONN_STATIC_IP)
 break;
 DrawRfIcon();
 Delay_ms(500);
 }
 Net_Wireless_MCW1001_TimeToWait = 5;
 Sound_Play(800, 400);
 Delay_ms(50);
 Sound_Play(800, 400);
}
#line 679 "D:/programming&CCt Design/Microcontroller/Projects/Electricity Monitoring System/AC Parameter Wifi with Hall with Home network/AC Parameter Wifi PF Turki/WiFi.c"
void main() {
 InitMcu();


 LED_Array(EEPROM_Read(0x01));
 LATA.F5=EEPROM_Read(0x00);
 LATC.F0=EEPROM_Read(0x00);

 UART1_Init(19200);
 Delay_ms(1000);
 InitWiFi();
 SearchSSID();
 ConnectToAp();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"System Published");

 Delay_ms(1000);
 find_parameter();
 RunHttpServer();
}
