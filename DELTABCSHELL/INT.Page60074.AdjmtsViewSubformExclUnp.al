page 60074 "Adjmts. View Subform-Excl. Unp"
{
    Caption = 'Posted G/L Entries Only';
    Editable = false;
    PageType = ListPart;
    SourceTable = "G/L Entry";
    SourceTableView = SORTING("Global Dimension 1 Code", "Posting Date")
                      WHERE("Global Dimension 1 Code" = FILTER(<> ''));
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
                field("Entry No."; Rec."Entry No.")
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
        lrecCorpAccPeriod: Record "Corporate Accounting Period";
        ltxtEntryNoFilter: Text;
    begin
        Rec.SetFilter("Posting Date", ptxtDateFilter);

        if poptExcludeEntries in [poptExcludeEntries::"Reclassification Reversals", poptExcludeEntries::"Reclassification Reversals and Closing Date"] then begin
            Rec.SetRange("GAAP Adjustment Reason", Rec."GAAP Adjustment Reason"::Reclassification);
            if Rec.FindSet then begin
                repeat
                    if (Rec."Reversal Entry No." <> 0) or lrecCorpAccPeriod.Get(Rec."Posting Date") then begin
                        if ltxtEntryNoFilter <> '' then
                            ltxtEntryNoFilter += '&';

                        ltxtEntryNoFilter += StrSubstNo('<>%1', Rec."Entry No.");
                    end;
                until Rec.Next = 0;
            end;
            Rec.SetFilter("Entry No.", ltxtEntryNoFilter);
            Rec.SetRange("GAAP Adjustment Reason");
        end;

        if Rec.FindFirst then;
        CurrPage.Update(false);
    end;

    //[Scope('Internal')]
    procedure gfcnGetCopy(var precGLEntry: Record "G/L Entry")
    begin
        precGLEntry.Copy(Rec);
    end;
}

