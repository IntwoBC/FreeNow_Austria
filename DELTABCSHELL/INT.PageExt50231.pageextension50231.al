pageextension 50231 pageextension50231 extends "Service Quotes"
{
    layout
    {

        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 121)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 119)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;
    }

    var
        DimMgt: Codeunit DimensionManagement;
}

