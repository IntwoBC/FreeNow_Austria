tableextension 50104 tableextension50104 extends "Sales Invoice Line"
{

    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 12)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(SalesLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := SalesInvHeader."Posting Date";
    "Document No." := SalesInvHeader."No.";
    Quantity := SalesLine."Qty. to Invoice";
    "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";

    OnAfterInitFromSalesLine(Rec,SalesInvHeader,SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Init;
    TransferFields(SalesLine);
    #5..10
    */
    //end;
}

