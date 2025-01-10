pageextension 50203 pageextension50203 extends "Invt. Pick Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1900206104)".

    }

    //Unsupported feature: Code Modification on "CallSplitLine(PROCEDURE 7300)".

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

