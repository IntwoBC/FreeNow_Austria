tableextension 50109 tableextension50109 extends "Purch. Cr. Memo Line"
{

    //Unsupported feature: Code Modification on "InitFromPurchLine(PROCEDURE 8)".

    //procedure InitFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(PurchLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := PurchCrMemoHdr."Posting Date";
    "Document No." := PurchCrMemoHdr."No.";
    Quantity := PurchLine."Qty. to Invoice";
    "Quantity (Base)" := PurchLine."Qty. to Invoice (Base)";

    OnAfterInitFromPurchLine(PurchCrMemoHdr,PurchLine,Rec);
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

