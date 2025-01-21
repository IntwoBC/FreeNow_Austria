pageextension 50169 pageextension50169 extends "Whse. Pick Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1900206104)".


        //Unsupported feature: Code Modification on "SplitWhseActivityLine(Action 1900206104).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseActivLine.Copy(Rec);
        SplitLine(WhseActivLine);
        Copy(WhseActivLine);
        CurrPage.Update(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WhseActivLine.Copy(Rec);
        SplitLine(WhseActivLine);
        CurrPage.Update(false);
        */
        //end;
    }
}

