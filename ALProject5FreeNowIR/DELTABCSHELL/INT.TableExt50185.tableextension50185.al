tableextension 50185 tableextension50185 extends "Item Unit of Measure"
{

    //Unsupported feature: Code Modification on "TestNoWhseAdjmtEntriesExist(PROCEDURE 7)".

    //procedure TestNoWhseAdjmtEntriesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseEntry.SetRange("Item No.","Item No.");
    WhseEntry.SetRange("Unit of Measure Code",xRec.Code);
    if Location.FindSet then
      repeat
        if Bin.Get(Location.Code,Location."Adjustment Bin Code") then begin
          WhseEntry.SetRange("Zone Code",Bin."Zone Code");
          if not WhseEntry.IsEmpty then
            Error(CannotModifyUOMWithWhseEntriesErr,TableCaption,xRec.Code,"Item No.");
        end;
      until Location.Next = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WhseEntry.SetRange("Item No.","Item No.");
    WhseEntry.SetRange("Unit of Measure Code",xRec.Code);
    Location.Find('-');
    repeat
      if Bin.Get(Location.Code,Location."Adjustment Bin Code") then begin
        WhseEntry.SetRange("Zone Code",Bin."Zone Code");
        if not WhseEntry.IsEmpty then
          Error(CannotModifyUOMWithWhseEntriesErr,TableCaption,xRec.Code,"Item No.");
      end;
    until Location.Next = 0;
    */
    //end;
}

