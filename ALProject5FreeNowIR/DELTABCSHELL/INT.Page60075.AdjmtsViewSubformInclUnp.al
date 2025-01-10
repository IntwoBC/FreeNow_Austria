page 60075 "Adjmts. View Subform-Incl. Unp"
{
    Caption = 'Posted and Un-posted Entries';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Adjustment Entry Buffer";
    SourceTableTemporary = true;
    SourceTableView = SORTING("Posting Date", "Document No.");
    ApplicationArea = all;//SPS
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Adjustment Role"; Rec."Adjustment Role")
                {
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
                field(Reversible; Rec.Reversible)
                {
                    Visible = false;
                }
                field("Reversed at"; Rec."Reversed at")
                {
                    Visible = false;
                }
                field("Reversal Entry No."; Rec."Reversal Entry No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        // Workaroound for MS bug
    end;

    //[Scope('Internal')]
    procedure gfcnUpdate(ptxtDateFilter: Text; poptExcludeEntries: Option " ","Reclassification Reversals","Closing Date","Reclassification Reversals and Closing Date")
    var
        lmdlAdjmtsMgt: Codeunit "Adjustments Management";
        lrecGLEntry: Record "G/L Entry";
    begin
        lrecGLEntry.SetCurrentKey("Global Dimension 1 Code", "Posting Date");
        lrecGLEntry.SetFilter("Global Dimension 1 Code", '<>%1', '');
        lrecGLEntry.SetFilter("Posting Date", ptxtDateFilter);

        lmdlAdjmtsMgt.gfcnGetEntries(Rec, lrecGLEntry, true, poptExcludeEntries in [poptExcludeEntries::"Reclassification Reversals", poptExcludeEntries::"Reclassification Reversals and Closing Date"]);

        if Rec.FindFirst then;
    end;
}

