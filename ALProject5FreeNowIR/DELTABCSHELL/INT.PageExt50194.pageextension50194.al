pageextension 50194 pageextension50194 extends "Purchase Return List Archive"
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

    var
        DimMgt: Codeunit DimensionManagement;
}

