pageextension 50121 pageextension50121 extends "Sales Journal"
{
    // SUP:Ticket:#121664  09/05/2023 COSMO.ABT
    //    # Show the fields "FA Posting Type", "IBAN / Bank Account", "URL", "E-mail" and "Sales Order No.".
    // #1..7
    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            field(URL; Rec.URL)
            {
                ApplicationArea = all;
            }
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

