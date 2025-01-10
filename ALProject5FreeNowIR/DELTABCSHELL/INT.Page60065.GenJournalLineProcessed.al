page 60065 "Gen. Journal Line (Processed)"
{
    Caption = 'Gen. Journal Line (Processed)';
    PageType = List;
    SourceTable = "Gen. Journal Line (Processed)";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field("Debit/Credit Indicator"; Rec."Debit/Credit Indicator")
                {
                }
                field("Additional Curr Amnt"; Rec."Additional Curr Amnt")
                {
                }
                field("Company No."; Rec."Company No.")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

