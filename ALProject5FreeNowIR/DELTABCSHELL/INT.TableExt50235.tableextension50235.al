tableextension 50235 tableextension50235 extends "Planning Assignment"
{

    //Unsupported feature: Code Modification on "ChkAssignOne(PROCEDURE 1)".

    //procedure ChkAssignOne();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReorderingPolicy := Item."Reordering Policy"::" ";

    if SKU.Get(LocationCode,ItemNo,VariantCode) then
      ReorderingPolicy := SKU."Reordering Policy"
    else
      if Item.Get(ItemNo) then
        ReorderingPolicy := Item."Reordering Policy";

    if ReorderingPolicy <> Item."Reordering Policy"::" " then
      AssignOne(ItemNo,VariantCode,LocationCode,UpdateDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Item.Get(ItemNo) then
      if Item."Reordering Policy" <> Item."Reordering Policy"::" " then
        AssignOne(ItemNo,VariantCode,LocationCode,UpdateDate);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "ChkAssignOne(PROCEDURE 1).SKU(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "ChkAssignOne(PROCEDURE 1).ReorderingPolicy(Variable 1006)".

}

