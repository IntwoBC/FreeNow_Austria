tableextension 50229 tableextension50229 extends "G/L Budget Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Business Unit Code"(Field 10)".

    }

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckIfBlocked;
    DeleteAnalysisViewBudgetEntries;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckIfBlocked;
    */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 7)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if GetFilter("Budget Name") <> '' then begin
      GLBudgetName.SetFilter(Name,GetFilter("Budget Name"));
      if not GLBudgetName.FindFirst then
        Clear(GLBudgetName);
    end;
    case BudgetDimType of
      1:
        begin
    #9..32
          exit(Text004);
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if GetFilter("Budget Name") <> '' then
      if GLBudgetName.Name <> GetRangeMin("Budget Name") then
        if not GLBudgetName.Get(GetRangeMin("Budget Name")) then
          Clear(GLBudgetName);
    #6..35
    */
    //end;

    //Unsupported feature: Property Deletion (Permissions).

}

