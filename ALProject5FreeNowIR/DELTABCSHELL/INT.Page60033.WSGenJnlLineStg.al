page 60033 "WS Gen Jnl Line Stg"
{
    Caption = 'WS Gen Jnl Line Stg';
    PageType = List;
    SourceTable = "Gen. Journal Line (Staging)";
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
                field("Business Unit"; Rec."Business Unit")
                {
                }
                field("Debit/Credit Indicator"; Rec."Debit/Credit Indicator")
                {
                }
                field("Additional Curr Amnt"; Rec."Additional Curr Amnt")
                {
                    Caption = '<Additional Curr Amount>';
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
                field("GAAP Adjmt Reason"; Rec."GAAP Adjmt Reason")
                {
                    Caption = '<GAAP Adjmt Reason>';
                }
                field("Adjustment Role"; Rec."Adjustment Role")
                {
                }
                field("Tax Adjmt Reason"; Rec."Tax Adjmt Reason")
                {
                    Caption = '<Tax Adjmt Reason>';
                }
                field("Equity Corr Code"; Rec."Equity Corr Code")
                {
                }
                field("Shortcut Dim 1 Code"; Rec."Shortcut Dim 1 Code")
                {
                }
                field("Client Entry No."; Rec."Client Entry No.")
                {
                }
                field("Description (English)"; Rec."Description (English)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

