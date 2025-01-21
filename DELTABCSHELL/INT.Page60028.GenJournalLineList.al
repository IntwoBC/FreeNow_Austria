page 60028 "Gen. Journal Line List"
{
    Caption = 'Gen. Journal Line List';
    Editable = false;
    PageType = List;
    SourceTable = "Gen. Journal Line";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                }
                field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
                {
                }
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
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("GAAP Adjustment Reason"; Rec."GAAP Adjustment Reason")
                {
                }
                field("Adjustment Role"; Rec."Adjustment Role")
                {
                }
                field("Tax Adjustment Reason"; Rec."Tax Adjustment Reason")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                }
                field("Bal. Corporate G/L Account No."; Rec."Bal. Corporate G/L Account No.")
                {
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("<Action29>")
            {
                Caption = 'Open Journal';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrecGenJnlBatch: Record "Gen. Journal Batch";
                    lmdlGenJnlMgt: Codeunit GenJnlManagement;
                begin
                    lrecGenJnlBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                    lmdlGenJnlMgt.TemplateSelectionFromBatch(lrecGenJnlBatch);
                end;
            }
        }
    }
}

