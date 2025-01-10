pageextension 50204 pageextension50204 extends "Invt. Movement Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1900206104)".

    }

    //Unsupported feature: Code Modification on "SplitLines(PROCEDURE 6)".

    //procedure SplitLines();
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

