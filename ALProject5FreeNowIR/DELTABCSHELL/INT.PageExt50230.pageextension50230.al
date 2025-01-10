pageextension 50230 pageextension50230 extends "Purchase Return Order List"
{
    layout
    {

        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 113)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 111)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;
    }


    //Unsupported feature: Property Modification (Id) on "ReadyToPostQst(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReadyToPostQst : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReadyToPostQst : 2000;
    //Variable type has not been exported.

    var
        DimMgt: Codeunit DimensionManagement;
}

