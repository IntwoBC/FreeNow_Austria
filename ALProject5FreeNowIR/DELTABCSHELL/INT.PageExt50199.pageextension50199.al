pageextension 50199 pageextension50199 extends "Warehouse Movement Subform"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1900724104)".

    }

    //Unsupported feature: Code Modification on "CallSplitLine(PROCEDURE 6)".

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

