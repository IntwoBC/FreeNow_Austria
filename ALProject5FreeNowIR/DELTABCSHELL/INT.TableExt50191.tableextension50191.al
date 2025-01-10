tableextension 50191 tableextension50191 extends "Warehouse Activity Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Location Code"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Location Code" <> xRec."Location Code" then
          if LineExist then
            Error(Text002,FieldCaption("Location Code"));
        #4..8
        GetLocation("Location Code");
        case Type of
          Type::"Invt. Put-away":
            if Location.RequireReceive("Location Code") and ("Source Document" <> "Source Document"::"Prod. Output") then
              Validate("Source Document","Source Document"::"Prod. Output");
          Type::"Invt. Pick":
            if Location.RequireShipment("Location Code") then
              Location.TestField("Require Shipment",false);
          Type::"Invt. Movement":
            Location.TestField("Directed Put-away and Pick",false);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
            if Location.RequireReceive("Location Code") then
              Location.TestField("Require Receive",false);
        #14..19
        */
        //end;


        //Unsupported feature: Code Modification on ""Source Document"(Field 7307).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Source Document" <> xRec."Source Document" then begin
          if LineExist then
            Error(Text002,FieldCaption("Source Document"));
          "Source No." := '';
          ClearDestinationFields;
          if Type = Type::"Invt. Put-away" then begin
            GetLocation("Location Code");
            if Location.RequireReceive("Location Code") then
              TestField("Source Document","Source Document"::"Prod. Output");
          end;
        end;

        case "Source Document" of
        #14..61
          "Source Type" := 0;
          "Source Subtype" := 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        #11..64
        */
        //end;
    }
}

