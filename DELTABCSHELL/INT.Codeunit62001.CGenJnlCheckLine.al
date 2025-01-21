codeunit 62001 "C:Gen. Jnl.-Check Line"
{

    trigger OnRun()
    begin
    end;

    var
        grecGenJnlTemplate: Record "Gen. Journal Template";
        gmdlCompanyTypeMgt: Codeunit "Company Type Management";

    [EventSubscriber(ObjectType::Codeunit, 11, 'OnAfterCheckGenJnlLine', '', false, false)]
    local procedure levtOnAfterCheckGenJnlLine(var GenJournalLine: Record "Gen. Journal Line")
    var
        lrecCorpAccountingPeriod: Record "Corporate Accounting Period";
    begin
        with GenJournalLine do begin
            if "Posting Date" <> NormalDate("Posting Date") then
                if "Corporate G/L Account No." <> '' then begin
                    lrecCorpAccountingPeriod.Get(NormalDate("Posting Date") + 1);
                    lrecCorpAccountingPeriod.TestField("New Fiscal Year", true);
                    lrecCorpAccountingPeriod.TestField("Date Locked", true);
                end;

            if grecGenJnlTemplate.Name <> "Journal Template Name" then
                grecGenJnlTemplate.Get("Journal Template Name");

            /*if grecGenJnlTemplate.Type in [grecGenJnlTemplate.Type::"GAAP Adjustments", grecGenJnlTemplate.Type::"Tax Adjustments",
              grecGenJnlTemplate.Type::"GAAP Adjustments", grecGenJnlTemplate.Type::"Group Adjustments"]
            then begin
                grecGenJnlTemplate.TestField("Shortcut Dimension 1 Code");

                if ("Account Type" = "Account Type"::"G/L Account") and ("Account No." <> '')
                  and gmdlCompanyTypeMgt.gfcnCorpAccInUse
                then
                    TestField("Corporate G/L Account No.");

                if ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") and ("Bal. Account No." <> '')
                  and gmdlCompanyTypeMgt.gfcnCorpAccInUse
                then
                    TestField("Bal. Corporate G/L Account No.");

                TestField("GAAP Adjustment Reason");
                if grecGenJnlTemplate.Type = grecGenJnlTemplate.Type::"Tax Adjustments" then
                    TestField("Tax Adjustment Reason");
                TestField("Adjustment Role");

                if "GAAP Adjustment Reason" <> "GAAP Adjustment Reason"::Reclassification then
                    TestField("Equity Correction Code");
            end;
*/
            if grecGenJnlTemplate."Shortcut Dimension 1 Code" <> '' then
                TestField("Shortcut Dimension 1 Code", grecGenJnlTemplate."Shortcut Dimension 1 Code");
        end;
    end;
}

