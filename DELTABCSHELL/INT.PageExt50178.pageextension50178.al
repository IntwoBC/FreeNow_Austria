pageextension 50178 pageextension50178 extends "BOM Cost Shares"
{

    //Unsupported feature: Code Modification on "RefreshPage(PROCEDURE 2)".

    //procedure RefreshPage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.SetFilter("No.",ItemFilter);
    Item.SetRange("Date Filter",0D,WorkDate);
    CalcBOMTree.SetItemFilter(Item);

    case ShowBy of
      ShowBy::Item:
        begin
          Item.FindSet;
          repeat
            HasBOM := Item.HasBOM or (Item."Routing No." <> '')
          until HasBOM or (Item.Next = 0);

          if not HasBOM then
            Error(Text000);
          CalcBOMTree.GenerateTreeForItems(Item,Rec,2);
        end;
    #17..20
    end;

    CurrPage.Update(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
          Item.FindFirst;
          if (not Item.HasBOM) and (Item."Routing No." = '') then
    #14..23
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "RefreshPage(PROCEDURE 2).HasBOM(Variable 1001)".

}

