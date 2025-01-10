pageextension 50157 pageextension50157 extends "Application Worksheet"
{

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Apply.SetCalledFromApplicationWorksheet(true);
    ReapplyTouchedEntries; // in case OnQueryClosePage trigger was not executed due to a sudden crash

    InventoryPeriod.IsValidDate(InventoryOpenedFrom);
    if InventoryOpenedFrom <> 0D then
      if GetFilter("Posting Date") = '' then
    #7..11
      end;

    UpdateFilterFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #4..14
    */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Apply.AnyTouchedEntries then begin
      if not Confirm(Text003) then
        exit(false);

      UnblockItems;
      Reapplyall;
    end;

    exit(true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      Reapplyall;
      UnblockItems;
    #7..9
    */
    //end;
}

