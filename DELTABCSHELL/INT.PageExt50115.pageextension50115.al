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
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
            }
        }
        addafter("G/L Account Name")
        {
            field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Corporate G/L Account No. field.', Comment = '%';
            }
        }
    }
}

