page 70016 "Bank Acc. Recon. List Match"
{
    // #MyTaxi.W1.CRE.BANKR.001 29/01/2018 CCFR.SDE : Unmatched entries update history
    //   Page creation

    Caption = 'Bank Acc. Reconciliation List Match';
    CardPageID = "Bank Acc. Recon. Match";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(BankAccountNo; Rec."Bank Account No.")
                {
                }
                field(StatementNo; Rec."Statement No.")
                {
                }
                field(StatementDate; Rec."Statement Date")
                {
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                }
                field(MatchingProgress; MatchingProgress)
                {
                    Caption = 'Matching Progress';
                    ExtendedDatatype = Ratio;
                }
                field(RecordsTotal; RecordsTotal)
                {
                    Caption = 'No. All Lines';
                }
                field(MatchedLinesTotal; MatchedLinesTotal)
                {
                    Caption = 'No. Matched Lines';
                }
                field(NonmatchedLinesTotal; NonmatchedLinesTotal)
                {
                    Caption = 'No. Nonnmatched Lines';
                }
                field(ApplymentProgress; ApplymentProgress)
                {
                    Caption = 'Applyment Progress';
                    ExtendedDatatype = Ratio;
                }
                field(CustVendLinesTotal; CustVendLinesTotal)
                {
                    Caption = 'No. Matched Lines To Reverse';
                }
                field(AppliedLinesTotal; AppliedLinesTotal)
                {
                    Caption = 'No. Applied Lines';
                }
                field(NotAppliedLinesTotal; NotAppliedLinesTotal)
                {
                    Caption = 'No. Not Applied Lines';
                }
                field(ApplymentConfidenceHighTotal; ApplymentConfidenceHighTotal)
                {
                    Caption = 'No. High Applyment Confidence';
                }
                field(Control19; ApplymentConfidenceMediumTotal)
                {
                    Caption = 'No. Medium Applyment Confidence';
                }
                field(ApplymentConfidenceLowTotal; ApplymentConfidenceLowTotal)
                {
                    Caption = 'No. Low Applyment Confidence';
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
                action("Bank Account Reconciliation")
                {
                    Caption = 'Bank Account Reconciliation';
                    Image = BankAccountRec;
                    Promoted = true;
                    RunObject = Page "Bank Acc. Reconciliation";
                    RunPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                    //"Statement Type" = FIELD ("Bank Statement");//SPS
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
                action("Payment Journal")
                {
                    Caption = 'Payment Journal';
                    Image = PaymentJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Journal Match";
                }
                action("Initialize Match Reconciliation Lines Fields")
                {
                    Caption = 'Initialize Match Reconciliation Lines Fields';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Init Match Reconc. Li Fields";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MatchingProgress := 0;
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


        ApplymentProgress := 0;
        BankAccReconciliationLine.SetFilter("New Bal. Account Type", '%1|%2', BankAccReconciliationLine."New Bal. Account Type"::Customer, BankAccReconciliationLine."New Bal. Account Type"::Vendor);
        CustVendLinesTotal := BankAccReconciliationLine.Count;
        BankAccReconciliationLine.SetRange(Applied, true);
        AppliedLinesTotal := BankAccReconciliationLine.Count;
        NotAppliedLinesTotal := CustVendLinesTotal - AppliedLinesTotal;
        BankAccReconciliationLine.SetRange("Applyment Confidence", BankAccReconciliationLine."Applyment Confidence"::High);
        ApplymentConfidenceHighTotal := BankAccReconciliationLine.Count;
        BankAccReconciliationLine.SetRange("Applyment Confidence", BankAccReconciliationLine."Applyment Confidence"::Medium);
        ApplymentConfidenceMediumTotal := BankAccReconciliationLine.Count;
        BankAccReconciliationLine.SetRange("Applyment Confidence", BankAccReconciliationLine."Applyment Confidence"::Low);
        ApplymentConfidenceLowTotal := BankAccReconciliationLine.Count;
        if CustVendLinesTotal <> 0 then
            ApplymentProgress := 10000 * (AppliedLinesTotal / CustVendLinesTotal);
    end;

    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        MatchBankEntriesMyTaxi: Report "Match Bank Entries MyTaxi";
        RecordsTotal: Integer;
        MatchedLinesTotal: Integer;
        NonmatchedLinesTotal: Integer;
        MatchingProgress: Decimal;
        CustVendLinesTotal: Integer;
        AppliedLinesTotal: Integer;
        NotAppliedLinesTotal: Integer;
        ApplymentConfidenceHighTotal: Integer;
        ApplymentConfidenceMediumTotal: Integer;
        ApplymentConfidenceLowTotal: Integer;
        ApplymentProgress: Decimal;
}

