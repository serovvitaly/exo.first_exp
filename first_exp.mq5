//+------------------------------------------------------------------+
//|                                                    first_exp.mq5 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"



//#include "OrderManager.mqh";
#include <Trade\Trade.mqh>

input int long_sl  = 30;  // ������� Stop Loss ��� ������� �������
input int long_tp  = 100; // ������� Take Profit ��� ������� �������
input int short_sl = 30;  // ������� Stop Loss ��� �������� �������
input int short_tp = 110; // ������� Take Profit ��� �������� �������
input int max_lot  = 1;   // ������ ������������� ����

int myMACD;

string ords[];

datetime current_time, btimes[1]; 

double macd_buffer[];
double signal_bufer[];

MqlTick current_price;
CTrade trade;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //EventSetTimer(60);
   
   ArraySetAsSeries(macd_buffer,true);
   ArraySetAsSeries(signal_bufer,true); 
   
   myMACD = iMACD(NULL, 0, 12, 26, 9,  PRICE_CLOSE);
   
   ChartIndicatorAdd(ChartID(), 0, myMACD);
      
//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//--- destroy timer
   //EventKillTimer();
      
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    CopyTime(_Symbol,0,0,1, btimes);
    
    // ���������, ���� ������������� ���
    if (current_time != btimes[0]) {
        
        CopyBuffer(myMACD, 0, 0, 2, macd_buffer);
        CopyBuffer(myMACD, 1, 0, 2, signal_bufer);
        
        
        SymbolInfoTick(_Symbol, current_price);
        
        // �������� ������ �� �������
        if (signal_bufer[0] > 0 && macd_buffer[0] > 0 && signal_bufer[0] > macd_buffer[0]) {
            
            if (signal_bufer[1] <= macd_buffer[1]) {
                
                double price = current_price.ask;
                
                trade.PositionOpen(_Symbol, ORDER_TYPE_BUY, max_lot, price, price - _Point * long_sl, price + _Point * long_tp);
                
            }
            
        }
        
        
        // �������� ������ �� �������
        if (signal_bufer[0] < 0 && macd_buffer[0] < 0 && signal_bufer[0] < macd_buffer[0]) {
            
            if (signal_bufer[1] >= macd_buffer[1]) {
                
                double price = current_price.bid;
                
                trade.PositionOpen(_Symbol, ORDER_TYPE_SELL, max_lot, price, price + _Point * short_sl, price - _Point * short_tp);
                
            }
            
        }
        
        
        current_time = btimes[0];
    }
    
}