pageextension 50115 pageextension50115 extends "General Ledger Entries"
{
    // SUP:ISSUE:#117922  24/08/2022 COSMO.ABT
    //    # Show new field "Purchase Order No.".
    layout
    {

        addafter("Entry No.")
        {
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

