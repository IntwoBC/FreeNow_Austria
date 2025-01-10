pageextension 50220 pageextension50220 extends "Demand Forecast Entries"
{

    //Unsupported feature: Variable Insertion (Variable: LocationCode) (VariableCollection) on ""ProdForecastQtyBase_OnValidate"(PROCEDURE 4)".


    //Unsupported feature: Code Modification on ""ProdForecastQtyBase_OnValidate"(PROCEDURE 4)".

    //procedure "ProdForecastQtyBase_OnValidate"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ForecastType = ForecastType::Both then
      Error(Text000);
    ProdForecastEntry.SetCurrentKey("Production Forecast Name","Item No.","Location Code","Forecast Date","Component Forecast");
    #4..24
      "Production Forecast Name","Item No.","Location Code","Forecast Date","Component Forecast");
    if GetFilter("Location Filter") = '' then begin
      ProdForecastEntry2.CopyFilters(ProdForecastEntry);
      ProdForecastEntry2.SetFilter("Location Code",'>%1','');
      if ProdForecastEntry2.FindSet then
        repeat
          if ProdForecastByLocationQtyBase(ProdForecastEntry2) <> 0 then
            Error(Text003);
          ProdForecastEntry2.SetFilter("Location Code",'>%1',ProdForecastEntry2."Location Code");
        until ProdForecastEntry2.Next = 0;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..27
      ProdForecastEntry2.SetRange("Location Code");
      if ProdForecastEntry2.FindFirst then begin
        LocationCode := ProdForecastEntry2."Location Code";
        ProdForecastEntry2.FindLast;
        if ProdForecastEntry2."Location Code" <> LocationCode then
          Error(Text003);
      end;
    end;
    */
    //end;
}

