tableextension 50102 tableextension50102 extends "Sales Shipment Line"
{

    //Unsupported feature: Code Modification on "InsertInvLineFromShptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromShptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeCodeInsertInvLineFromShptLine(Rec,SalesLine,IsHandled);
    if IsHandled then
    #4..18
      SalesLine."Line No." := NextLineNo;
      SalesLine."Document Type" := TempSalesLine."Document Type";
      SalesLine."Document No." := TempSalesLine."Document No.";
      LanguageManagement.SetGlobalLanguageByCode(SalesInvHeader."Language Code");
      SalesLine.Description := StrSubstNo(Text000,"Document No.");
      LanguageManagement.RestoreGlobalLanguage;
      IsHandled := false;
      OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(Rec,SalesLine,NextLineNo,IsHandled);
      if not IsHandled then begin
        SalesLine.Insert;
        OnAfterDescriptionSalesLineInsert(SalesLine,Rec,NextLineNo);
        NextLineNo := NextLineNo + 10000;
      end;
    end;

    TransferOldExtLines.ClearLineNumbers;
    #35..80
      SalesLine."Shipment Line No." := "Line No.";
      ClearSalesLineValues(SalesLine);
      if not ExtTextLine and (SalesLine.Type <> 0) then begin
        IsHandled := false;
        OnInsertInvLineFromShptLineOnBeforeValidateQuantity(Rec,SalesLine,IsHandled);
        if SalesLine."Deferral Code" <> '' then
    #87..90

        OnInsertInvLineFromShptLineOnAfterCalcQuantities(SalesLine,SalesOrderLine);

        SalesLine.Validate("Unit Price",SalesOrderLine."Unit Price");
        SalesLine."Allow Line Disc." := SalesOrderLine."Allow Line Disc.";
        SalesLine."Allow Invoice Disc." := SalesOrderLine."Allow Invoice Disc.";
    #97..135
      SalesLine."Dimension Set ID" := "Dimension Set ID";
      OnBeforeInsertInvLineFromShptLine(Rec,SalesLine,SalesOrderLine);
      SalesLine.Insert;
      OnAfterInsertInvLineFromShptLine(SalesLine,SalesOrderLine,NextLineNo,Rec);

      ItemTrackingMgt.CopyHandledItemTrkgToInvLine(SalesOrderLine,SalesLine);

    #143..148
      SalesOrderHeader."Get Shipment Used" := true;
      SalesOrderHeader.Modify;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21

      LanguageManagement.SetGlobalLanguageByCode(SalesInvHeader."Language Code");

      SalesLine.Description := StrSubstNo(Text000,"Document No.");

    #24..31

    #32..83

    #84..93

    #94..138

      OnAfterInsertInvLineFromShptLine(SalesLine,SalesOrderLine,NextLineNo,Rec);

    #140..151
    */
    //end;
}

