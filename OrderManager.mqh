//+------------------------------------------------------------------+
//|                                                 OrderManager.mqh |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"

#include "OrderObject.mqh";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OrderManager
{
private:
    
    OrderObject orders[];

public:
     OrderManager(){};
    ~OrderManager(){};
    
    /**
    * ������������� Order
    */
    void placeOrder(){
        //
    }
    
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
OrderManager::OrderManager()
  {
  }
*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
OrderManager::~OrderManager()
  {
  }
*/
//+------------------------------------------------------------------+
