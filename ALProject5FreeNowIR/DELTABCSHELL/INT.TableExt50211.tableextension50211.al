tableextension 50211 tableextension50211 extends Bin
{

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestField("Location Code");
    GetLocation("Location Code");
    if Location."Directed Put-away and Pick" then begin
      TestField("Zone Code");
      TestField("Bin Type Code");
    end else begin
      TestField("Zone Code",'');
      TestField("Bin Type Code",'');
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..9
    */
    //end;
}

