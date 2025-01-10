page 70014 "Bank Acc. Recon. Match"
{
    // #MyTaxi.W1.CRE.BANKR.001 29/01/2018 CCFR.SDE : Unmatched entries update history
    //   Page creation

    Caption = 'Bank Acc. Reconciliation';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;//SPS
    PromotedActionCategories = 'New,Process,Report,Bank,Matching';
    SaveValues = false;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(StatementNo; Rec."Statement No.")
                {
                    Caption = 'Statement No.';
                }
                field(StatementDate; Rec."Statement Date")
                {
                    Caption = 'Statement Date';
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    Caption = 'Balance Last Statement';
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    Caption = 'Statement Ending Balance';
                }
                field(MatchingProgress; MatchingProgress)
                {
                    Caption = 'Matching Progress';
                    ExtendedDatatype = Ratio;
                }
                field(MatchedLinesTotal; MatchedLinesTotal)
                {
                    Caption = 'No. Matched Lines';
                }
                field(RecordsTotal; RecordsTotal)
                {
                    Caption = 'No. All Lines';
                }
                field(NonmatchedLinesTotal; NonmatchedLinesTotal)
                {
                    Caption = 'Nonnmatched Lines';
                }
            }
            group(Control8)
            {
                ShowCaption = false;
                part(StmtLine; "Bank Acc. Recon. Lines Match")
                {
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                }
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
            group("&Recon.")
            {
                Caption = '&Recon.';
                Image = BankAccountRec;
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page "Bank Account Card";
                    RunPageLink = "No." = FIELD("Bank Account No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Match Bank Entries MyTaxi")
                {
                    Caption = 'Match Bank Entries MyTaxi';
                    Ellipsis = true;
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        BankAccReconciliation.Reset;
                        BankAccReconciliation.SetRange("Statement Type", Rec."Statement Type");
                        BankAccReconciliation.SetRange("Bank Account No.", Rec."Bank Account No.");
                        BankAccReconciliation.SetRange("Statement No.", Rec."Statement No.");
                        MatchBankEntriesMyTaxi.SetTableView(BankAccReconciliation);
                        MatchBankEntriesMyTaxi.Run;
                    end;
                }
            }
            group("M&atching")
            {
                Caption = 'M&atching';
                action(All)
                {
                    Caption = 'Show All';
                    Image = AddWatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(false);
                    end;
                }
                action(NotMatched)
                {
                    Caption = 'Show Nonmatched';
                    Image = AddWatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleUnMatchedFilter(true);
                    end;
                }
                action(Matched)
                {
                    Caption = 'Show matched';
                    Image = AddWatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.StmtLine.PAGE.ToggleMatchedFilter(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankAccReconciliationLine.Reset;
        BankAccReconciliationLine.SetRange("Statement Type", Rec."Statement Type");
        BankAccReconciliationLine.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankAccReconciliationLine.SetRange("Statement No.", Rec."Statement No.");
        RecordsTotal := BankAccReconciliationLine.Count;
        BankAccReconciliationLine.SetRange(Matched, true);
        MatchedLinesTotal := BankAccReconciliationLine.Count;
        NonmatchedLinesTotal := RecordsTotal - MatchedLinesTotal;
        if RecordsTotal <> 0 then
            MatchingProgress := 10000 * (MatchedLinesTotal / RecordsTotal);
    end;

    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        MatchBankEntriesMyTaxi: Report "Match Bank Entries MyTaxi";
        RecordsTotal: Integer;
        MatchedLinesTotal: Integer;
        NonmatchedLinesTotal: Integer;
        MatchingProgress: Decimal;
}

