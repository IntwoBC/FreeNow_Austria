tableextension 50189 tableextension50189 extends "Item Substitution"
{
    fields
    {

        //Unsupported feature: Code Modification on "Type(Field 100).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type <> xRec.Type then begin
          if Interchangeable then
            DeleteInterchangeableItem(
        #4..6
              "Substitute Type",
              "Substitute No.",
              "Substitute Variant Code");
          if xRec."No." <> '' then
            Validate("No.",'');
          Validate("Substitute No.",'');
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
          Validate("No.",'');
          Validate("Substitute No.",'');
        end;
        */
        //end;
    }
}

