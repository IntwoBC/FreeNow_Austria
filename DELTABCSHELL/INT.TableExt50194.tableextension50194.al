tableextension 50194 tableextension50194 extends "Item Charge Assignment (Purch)"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Amount to Assign"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchLine.Get("Document Type","Document No.","Document Line No.");
        if not Currency.Get(PurchLine."Currency Code") then
          Currency.InitRoundingPrecision;
        "Amount to Assign" := Round("Qty. to Assign" * "Unit Cost",Currency."Amount Rounding Precision");
        ItemChargeAssgntPurch.SuggestAssgntFromLine(Rec);
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

