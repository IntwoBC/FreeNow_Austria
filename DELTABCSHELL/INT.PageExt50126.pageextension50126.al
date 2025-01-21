pageextension 50126 pageextension50126 extends "Item Turnover Lines"
{
    layout
    {

        //Unsupported feature: Code Modification on "PurchasesLCY(Control 6).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowValueEntries(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowItemEntries(false);
        */
        //end;


        //Unsupported feature: Code Modification on "SalesLCY(Control 10).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowValueEntries(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowItemEntries(true);
        */
        //end;
    }

    var
        ItemLedgEntry: Record "Item Ledger Entry";

        //Unsupported feature: Deletion (VariableCollection) on "ShowItemEntries(PROCEDURE 2).ItemLedgEntry(Variable 1001)".

}

