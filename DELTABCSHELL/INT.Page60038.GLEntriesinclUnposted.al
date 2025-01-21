page 60038 "G/L Entries (incl. Un-posted)"
{
    // MP 11-11-14
    // Upgrade to NAV 2013 R2

    Caption = 'General Ledger Entries';
    DataCaptionExpression = GetCaption;
    Editable = false;
    PageType = List;
    SourceTable = "G/L Entry";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    DrillDown = false;
                    Visible = false;
                }
                field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
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
                field(Description; Rec.Description)
                {
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
                field("Bal. Corporate G/L Account No."; Rec."Bal. Corporate G/L Account No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    Visible = false;
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    Visible = false;
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
            }
            part(UnpostedEntries; "G/L Entries Subform")
            {
                Caption = 'Un-posted Entries';
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SaveRecord;
                    end;
                }
                action("G/L Dimension Overview")
                {
                    Caption = 'G/L Dimension Overview';

                    trigger OnAction()
                    begin
                        PAGE.Run(PAGE::"G/L Entries Dimension Overview", Rec);
                    end;
                }
                action("Value Entries")
                {
                    Caption = 'Value Entries';
                    Image = ValueLedger;

                    trigger OnAction()
                    begin
                        Rec.ShowValueEntries;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Reverse Transaction")
                {
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        Clear(ReversalEntry);
                        if Rec.Reversed then
                            ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, Rec."Entry No.");
                        if Rec."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError;
                        Rec.TestField("Transaction No.");
                        ReversalEntry.ReverseTransaction(Rec."Transaction No.")
                    end;
                }
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
    begin
        CurrPage.UnpostedEntries.PAGE.gfcnSetFilters(Rec);
    end;

    var
        GLAcc: Record "G/L Account";

    local procedure GetCaption(): Text[250]
    begin
        if GLAcc."No." <> Rec."G/L Account No." then
            if not GLAcc.Get(Rec."G/L Account No.") then
                if Rec.GetFilter("G/L Account No.") <> '' then
                    if GLAcc.Get(Rec.GetRangeMin("G/L Account No.")) then;
        exit(StrSubstNo('%1 %2', GLAcc."No.", GLAcc.Name))
    end;
}

