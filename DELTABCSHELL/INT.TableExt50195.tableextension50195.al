tableextension 50195 tableextension50195 extends "Item Charge Assignment (Sales)"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Amount to Assign"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesLine.Get("Document Type","Document No.","Document Line No.");
        if not Currency.Get(SalesLine."Currency Code") then
          Currency.InitRoundingPrecision;
        "Amount to Assign" := Round("Qty. to Assign" * "Unit Cost",Currency."Amount Rounding Precision");
        ItemChargeAssgntSales.SuggestAssignmentFromLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        */
        //end;
    }
}

