pageextension 50245 pageextension50245 extends "Item Availability Line List"
{

    //Unsupported feature: Code Modification on "LookupEntries(PROCEDURE 3)".

    //procedure LookupEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case "Table No." of
      DATABASE::"Item Ledger Entry":
        begin
    #4..56
        end;
      DATABASE::"Prod. Order Component":
        begin
          ProdOrderComp.FindLinesWithItemToPlan(Item,true);
          PAGE.RunModal(0,ProdOrderComp);
        end;
      DATABASE::"Requisition Line":
    #64..122
    end;

    OnAfterLookupEntries(Item,"Table No.",Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..59
          ProdOrderComp.FindLinesWithItemToPlan(Item,false);
    #61..125
    */
    //end;
}

