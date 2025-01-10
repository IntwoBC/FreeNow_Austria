pageextension 50182 pageextension50182 extends "Troubleshooting Setup"
{

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TypeVisible := GetFilter(Type) = '';
    NoVisible := GetFilter("No.") = '';

    if (GetFilter(Type) <> '') and (GetFilter("No.") <> '') then begin
      RecType := GetRangeMin(Type);
      No := GetRangeMin("No.");
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      xRec.Validate(Type,GetRangeMin(Type));
      xRec.Validate("No.",GetRangeMin("No."));
    end;
    */
    //end;
}

