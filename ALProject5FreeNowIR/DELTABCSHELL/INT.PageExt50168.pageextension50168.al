pageextension 50168 pageextension50168 extends "Whse. Put-away Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1901991804)".


        //Unsupported feature: Code Modification on "SplitWhseActivityLine(Action 1901991804).OnAction".

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

