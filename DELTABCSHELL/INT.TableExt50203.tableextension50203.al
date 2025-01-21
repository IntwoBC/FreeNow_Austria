tableextension 50203 tableextension50203 extends "Return Shipment Line"
{

    //Unsupported feature: Code Modification on "InitFromPurchLine(PROCEDURE 10)".

    //procedure InitFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    TransferFields(PurchLine);
    if ("No." = '') and (Type in [Type::"G/L Account"..Type::"Charge (Item)"]) then
      Type := Type::" ";
    "Posting Date" := ReturnShptHeader."Posting Date";
    "Document No." := ReturnShptHeader."No.";
    Quantity := PurchLine."Return Qty. to Ship";
    #8..19
    end;

    OnAfterInitFromPurchLine(ReturnShptHeader,PurchLine,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Init;
    TransferFields(PurchLine);
    #5..22
    */
    //end;
}

