tableextension 50106 tableextension50106 extends "Sales Cr.Memo Line"
{

    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 8)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(SalesLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := SalesCrMemoHeader."Posting Date";
    "Document No." := SalesCrMemoHeader."No.";
    Quantity := SalesLine."Qty. to Invoice";
    "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";

    OnAfterInitFromSalesLine(Rec,SalesCrMemoHeader,SalesLine);
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

