pageextension 50167 pageextension50167 extends "Transfer Orders"
{
    layout
    {

        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 10)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 12)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;
    }


    //Unsupported feature: Property Modification (Id) on "IsFoundationEnabled(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsFoundationEnabled : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsFoundationEnabled : 2000;
    //Variable type has not been exported.

    var
        DimMgt: Codeunit DimensionManagement;
}

