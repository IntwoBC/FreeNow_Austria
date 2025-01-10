tableextension 50197 tableextension50197 extends "Inventory Adjmt. Entry (Order)"
{

    //Unsupported feature: Code Modification on "CalcCurrencyFactor(PROCEDURE 24)".

    //procedure CalcCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetRoundingPrecision(AmtRndgPrec,AmtRndgPrecACY);
    if GLSetup."Additional Reporting Currency" <> '' then begin
      OutputItemLedgEntry.SetCurrentKey("Order Type","Order No.","Order Line No.","Entry Type");
      OutputItemLedgEntry.SetRange("Order Type","Order Type");
      OutputItemLedgEntry.SetRange("Order No.","Order No.");
      if "Order Type" = "Order Type"::Production then begin
        OutputItemLedgEntry.SetRange("Order Line No.","Order Line No.");
        OutputItemLedgEntry.SetRange("Entry Type",OutputItemLedgEntry."Entry Type"::Output);
      end else
        OutputItemLedgEntry.SetRange("Entry Type",OutputItemLedgEntry."Entry Type"::"Assembly Output");

      if OutputItemLedgEntry.FindLast then
        exit(CurrExchRate.ExchangeRate(OutputItemLedgEntry."Posting Date",GLSetup."Additional Reporting Currency"));
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      if "Order Type" = "Order Type"::Production then
        OutputItemLedgEntry.SetRange("Order Line No.","Order Line No.");
      OutputItemLedgEntry.SetRange("Entry Type",OutputItemLedgEntry."Entry Type"::Output);
    #12..14
    */
    //end;
}

