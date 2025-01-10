tableextension 50208 tableextension50208 extends "Warehouse Journal Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""From Bin Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not PhysInvtEntered then
          TestField("Phys. Inventory",false);

        #4..8
          GetBinType("Location Code","From Bin Code");

        Bin.CalcFields("Adjustment Bin");
        if Bin."Adjustment Bin" and ("Entry Type" <> "Entry Type"::"Positive Adjmt.") then
          Bin.FieldError("Adjustment Bin");

        if "From Bin Code" <> '' then
          "From Zone Code" := Bin."Zone Code";

        if "Entry Type" = "Entry Type"::"Negative Adjmt." then
          SetUpAdjustmentBin;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        Bin.TestField("Adjustment Bin",false);
        #14..19
        */
        //end;


        //Unsupported feature: Code Modification on ""To Bin Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not PhysInvtEntered then
          TestField("Phys. Inventory",false);

        #4..7
        GetBin("Location Code","To Bin Code");

        Bin.CalcFields("Adjustment Bin");
        if Bin."Adjustment Bin" and ("Entry Type" <> "Entry Type"::"Negative Adjmt.") then
          Bin.FieldError("Adjustment Bin");

        if "To Bin Code" <> '' then
          "To Zone Code" := Bin."Zone Code";

        if "Entry Type" = "Entry Type"::"Positive Adjmt." then
          SetUpAdjustmentBin;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        Bin.TestField("Adjustment Bin",false);
        #13..18
        */
        //end;
    }
}

