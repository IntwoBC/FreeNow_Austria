pageextension 50127 pageextension50127 extends "Assembly BOM"
{
    layout
    {
        modify("Resource Usage Type")
        {
            Editable = IsResource;
            HideValue = NOT IsResource;
        }

        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsEmptyOrItem := Type in [Type::" ",Type::Item];
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IsResource := Type = Type::Resource
        */
        //end;
    }


    //Unsupported feature: Property Modification (Id) on "IsEmptyOrItem(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsEmptyOrItem : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsEmptyOrItem : 1001;
    //Variable type has not been exported.

    var
        [InDataSet]
        IsResource: Boolean;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsEmptyOrItem := Type in [Type::" ",Type::Item];
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IsResource := Type = Type::Resource
        */
        //end;
}

