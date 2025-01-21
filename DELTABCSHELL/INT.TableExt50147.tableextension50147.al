tableextension 50147 tableextension50147 extends "IC Inbox Transaction"
{

    //Unsupported feature: Code Modification on "InboxCheckAccept(PROCEDURE 40)".

    //procedure InboxCheckAccept();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeInboxCheckAccept(Rec,IsHandled);
    if IsHandled then
    #4..33
    then begin
      ICInboxPurchHeader.Get("Transaction No.","IC Partner Code","Transaction Source");
      if ICInboxPurchHeader."Your Reference" <> '' then begin
        PurchHeader.SetRange("Your Reference",ICInboxPurchHeader."Your Reference");
        if PurchHeader.FindFirst then
          Message(Text003,ICInboxPurchHeader."IC Transaction No.",ICInboxPurchHeader."Your Reference")
        else begin
          PurchInvHeader.SetRange("Your Reference",ICInboxPurchHeader."Your Reference");
          if PurchInvHeader.FindFirst then
            if not ConfirmManagement.ConfirmProcess(
                 StrSubstNo(
    #45..50
    end;

    OnAfterInboxCheckAccept(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..36
        PurchHeader.SetRange("No.",ICInboxPurchHeader."Your Reference");
    #38..40
          PurchInvHeader.SetCurrentKey("Order No.");
          PurchInvHeader.SetRange("Order No.",ICInboxPurchHeader."Your Reference");
    #42..53
    */
    //end;
}

