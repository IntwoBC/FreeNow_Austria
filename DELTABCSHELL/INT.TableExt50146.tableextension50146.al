tableextension 50146 tableextension50146 extends "IC Partner"
{

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLEntry.SetRange("IC Partner Code",Code);
    AccountingPeriod.SetRange(Closed,false);
    if AccountingPeriod.FindFirst then
    #4..16
        Error(Text002,Code,Cust.TableCaption,Cust."No.");

    if "Vendor No." <> '' then
      if Vend.Get("Vendor No.") then
        Error(Text002,Code,Vend.TableCaption,Vend."No.");

    ICInbox.SetRange("IC Partner Code",Code);
    #24..37
    CommentLine.DeleteAll;

    DimMgt.DeleteDefaultDim(DATABASE::"IC Partner",Code);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
      if Vend.Get("Customer No.") then
    #21..40
    */
    //end;
}

