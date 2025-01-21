pageextension 50120 pageextension50120 extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            field("Closed by Amount (LCY)"; Rec."Closed by Amount (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }
}

