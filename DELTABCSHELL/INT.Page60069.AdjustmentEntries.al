page 60069 "Adjustment Entries"
{
    Caption = 'Adjustment Entries';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Adjustment Entry Buffer";
    SourceTableView = SORTING("Posting Date", "Document No.");
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
                {
                }
                field("Corporate G/L Account Name"; Rec."Corporate G/L Account Name")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                }
                field("GAAP Adjustment Reason"; Rec."GAAP Adjustment Reason")
                {
                }
                field("Adjustment Role"; Rec."Adjustment Role")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Equity Correction Code"; Rec."Equity Correction Code")
                {
                }
                field("G/L Entry No."; Rec."G/L Entry No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

