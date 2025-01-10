tableextension 50186 tableextension50186 extends "Prod. Order Line"
{

    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 50)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Quantity * xRec.Quantity > 0) and
       ("Item No." = xRec."Item No.") and
       ("Location Code" = xRec."Location Code") and
    #4..6

    "Bin Code" := '';
    if ("Location Code" <> '') and ("Item No." <> '') then begin
      "Bin Code" := WMSManagement.GetLastOperationFromBinCode("Routing No.","Routing Version Code","Location Code",false,0);
      GetLocation("Location Code");
      if "Bin Code" = '' then
        "Bin Code" := Location."From-Production Bin Code";
      if ("Bin Code" = '') and Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
        WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code");
    end;
    Validate("Bin Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      GetLocation("Location Code");
      if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
    #15..17
    */
    //end;
}

