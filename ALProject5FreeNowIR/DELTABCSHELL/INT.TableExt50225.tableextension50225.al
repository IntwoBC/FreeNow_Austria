tableextension 50225 tableextension50225 extends "Sales Cue"
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Delayed(Field 5)".

    }

    //Unsupported feature: Code Modification on "CalculateAverageDaysDelayed(PROCEDURE 2)".

    //procedure CalculateAverageDaysDelayed();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FilterOrders(SalesHeader,FieldNo(Delayed));
    if SalesHeader.FindSet then begin
      repeat
        SumDelayDays += MaximumDelayAmongLines(SalesHeader);
        CountDelayedInvoices += 1;
      until SalesHeader.Next = 0;
      AverageDays := SumDelayDays / CountDelayedInvoices;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
        SumDelayDays += WorkDate - SalesHeader."Shipment Date";
    #5..8
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalesOrderWithBlankShipmentDateCount) (VariableCollection) on "CountOrders(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "CountOrders(PROCEDURE 9)".

    //procedure CountOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CountSalesOrders.SetRange(Status,CountSalesOrders.Status::Released);
    CountSalesOrders.SetRange(Completely_Shipped,false);
    FilterGroup(2);
    #4..17
      FieldNo(Delayed):
        begin
          CountSalesOrders.SetRange(Ship);
          CountSalesOrders.SetFilter(Date_Filter,GetFilter("Date Filter"));
          CountSalesOrders.SetRange(Late_Order_Shipping,true);
        end;
    end;
    CountSalesOrders.Open;
    CountSalesOrders.Read;
    exit(CountSalesOrders.Count_Orders);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
          CountSalesOrders.SetRange(Shipment_Date,0D);
          CountSalesOrders.Open;
          CountSalesOrders.Read;
          SalesOrderWithBlankShipmentDateCount := CountSalesOrders.Count_Orders;
          CountSalesOrders.SetFilter(Shipment_Date,GetFilter("Date Filter"));
    #23..26
    exit(CountSalesOrders.Count_Orders - SalesOrderWithBlankShipmentDateCount);
    */
    //end;


    //Unsupported feature: Code Modification on "FilterOrders(PROCEDURE 11)".

    //procedure FilterOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::Order);
    SalesHeader.SetRange(Status,SalesHeader.Status::Released);
    SalesHeader.SetRange("Completely Shipped",false);
    #4..14
      FieldNo(Delayed):
        begin
          SalesHeader.SetRange(Ship);
          SalesHeader.SetFilter("Date Filter",GetFilter("Date Filter"));
          SalesHeader.SetRange("Late Order Shipping",true);
        end;
    end;
    FilterGroup(2);
    SalesHeader.SetFilter("Responsibility Center",GetFilter("Responsibility Center Filter"));
    FilterGroup(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
          SalesHeader.SetFilter("Shipment Date",GetFilter("Date Filter"));
          SalesHeader.FilterGroup(2);
          SalesHeader.SetFilter("Shipment Date",'<>%1',0D);
          SalesHeader.FilterGroup(0);
    #20..24
    */
    //end;
}

