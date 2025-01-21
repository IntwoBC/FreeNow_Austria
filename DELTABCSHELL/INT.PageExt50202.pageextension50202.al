pageextension 50202 pageextension50202 extends "Invt. Put-away Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1901991804)".

    }

    //Unsupported feature: Code Modification on "CallSplitLine(PROCEDURE 8)".

    //procedure CallSplitLine();
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

