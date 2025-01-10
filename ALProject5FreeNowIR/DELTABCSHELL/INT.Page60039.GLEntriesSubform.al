page 60039 "G/L Entries Subform"
{
    // MP 27-11-12
    // Amended function gfcnSetFilters in order to allow filtering on G/L Account (CR 30)
    // 
    // MP 11-11-14
    // Upgrade to NAV 2013 R2

    Caption = 'G/L Entries Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Gen. Journal Line";
    ApplicationArea = all;//SPS
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
        area(processing)
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

    //[Scope('Internal')]
    procedure gfcnSetFilters(var precGLEntry: Record "G/L Entry")
    var
        lmdlCompanyTypeMgt: Codeunit "Company Type Management";
        lmdlTGenJournalLine: Codeunit "T:Gen. Journal Line";
    begin
        precGLEntry.CopyFilter("Posting Date", Rec."Posting Date");
        precGLEntry.CopyFilter("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        precGLEntry.CopyFilter("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
        precGLEntry.CopyFilter("Business Unit Code", Rec."Business Unit Code");
        precGLEntry.CopyFilter("GAAP Adjustment Reason", Rec."GAAP Adjustment Reason");
        // MP 27-11-12 >>
        //IF NOT lmdlCompanyTypeMgt.gfcnCorpAccInUse THEN
        if precGLEntry.GetFilter("G/L Account No.") <> '' then // MP 23-04-14 Replaces above
            lmdlTGenJournalLine.gfcnMarkLocalAccLines(Rec, precGLEntry.GetFilter("G/L Account No.")) // MP 24-May-16 Replaced by codeunit call
        else
            // MP 27-11-12 <<
            lmdlTGenJournalLine.gfcnMarkCorpAccLines(Rec, precGLEntry.GetFilter("Corporate G/L Account No.")); // MP 24-May-16 Replaced by codeunit call
    end;
}

