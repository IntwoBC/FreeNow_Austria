pageextension 50171 pageextension50171 extends "Item Charge Assignment (Purch)"
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

