pageextension 50172 pageextension50172 extends "Item Charge Assignment (Sales)"
{

    //Unsupported feature: Code Modification on "QtytoAssignOnAfterValidate(PROCEDURE 19000177)".

    //procedure QtytoAssignOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.Update(false);
    UpdateQtyAssgnt;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.Update(true);
    UpdateQtyAssgnt;
    */
    //end;
}

