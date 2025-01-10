page 70015 "Bank Acc. Recon. Lines Match"
{
    // #MyTaxi.W1.CRE.BANKR.001 29/01/2018 CCFR.SDE : Unmatched entries update history
    //   Page creation

    Caption = 'Bank Account Reconciliation Match';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Reconciliation Line";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Matched; Rec.Matched)
                {
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("New Bal. Account Type"; Rec."New Bal. Account Type")
                {
                }
                field("New Bal. Account No."; Rec."New Bal. Account No.")
                {
                }
                field(Applied; Rec.Applied)
                {
                }
                field("Applyment Confidence"; Rec."Applyment Confidence")
                {
                }
                field("Bank Acc. Ledg. Entry No."; Rec."Bank Acc. Ledg. Entry No.")
                {
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Statement No."; Rec."Statement No.")
                {
                }
                field("Statement Line No."; Rec."Statement Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                }
                field(Difference; Rec.Difference)
                {
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }

                field("Applied Entries"; Rec."Applied Entries")
                {
                }
                field("Value Date"; Rec."Value Date")
                {
                }
                field("Ready for Application"; Rec."Ready for Application")
                {
                }
                field("Check No."; Rec."Check No.")
                {
                }
                field("Related-Party Name"; Rec."Related-Party Name")
                {
                }
                field("Additional Transaction Info"; Rec."Additional Transaction Info")
                {
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                }
                field("Data Exch. Line No."; Rec."Data Exch. Line No.")
                {
                }
                field("Statement Type"; Rec."Statement Type")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Transaction Text"; Rec."Transaction Text")
                {
                }
                field("Related-Party Bank Acc. No."; Rec."Related-Party Bank Acc. No.")
                {
                }
                field("Related-Party Address"; Rec."Related-Party Address")
                {
                }
                field("Related-Party City"; Rec."Related-Party City")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Sorting Order"; Rec."Sorting Order")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                Caption = 'Details';
                RunObject = Page "Bank Statement Line Details";
                RunPageLink = "Data Exch. No." = FIELD("Data Exch. Entry No."),
                              "Line No." = FIELD("Data Exch. Line No.");
            }
        }
    }

    //[Scope('Internal')]
    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then
            Rec.SetRange(Matched, true)
        else
            Rec.Reset;
        CurrPage.Update;
    end;

    //[Scope('Internal')]
    procedure ToggleUnMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then
            Rec.SetRange(Matched, false)
        else
            Rec.Reset;
        CurrPage.Update;
    end;
}

