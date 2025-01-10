tableextension 50204 tableextension50204 extends "Return Receipt Line"
{

    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 10)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(SalesLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := ReturnRcptHeader."Posting Date";
    "Document No." := ReturnRcptHeader."No.";
    Quantity := SalesLine."Return Qty. to Receive";
    #8..20
    end;

    OnAfterInitFromSalesLine(ReturnRcptHeader,SalesLine,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Init;
    TransferFields(SalesLine);
    #5..23
    */
    //end;
}

