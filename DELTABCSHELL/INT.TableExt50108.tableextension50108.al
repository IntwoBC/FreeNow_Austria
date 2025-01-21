tableextension 50108 tableextension50108 extends "Purch. Inv. Line"
{

    //Unsupported feature: Code Modification on "InitFromPurchLine(PROCEDURE 12)".

    //procedure InitFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(PurchLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := PurchInvHeader."Posting Date";
    "Document No." := PurchInvHeader."No.";
    Quantity := PurchLine."Qty. to Invoice";
    "Quantity (Base)" := PurchLine."Qty. to Invoice (Base)";

    OnAfterInitFromPurchLine(PurchInvHeader,PurchLine,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Init;
    TransferFields(PurchLine);
    #5..10
    */
    //end;
}

