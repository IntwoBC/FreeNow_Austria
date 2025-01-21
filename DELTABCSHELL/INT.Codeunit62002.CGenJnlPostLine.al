codeunit 62002 "C:Gen. Jnl.-Post Line"
{
    Permissions = TableData "G/L Entry" = rm;
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        grecSourceCodeSetup: Record "Source Code Setup";
        grecGenJnlTemplate: Record "Gen. Journal Template";
        gmdlCompanyTypeMgt: Codeunit "Company Type Management";
        gintInsertedEntryNo: Integer;
        Text013: Label 'Please check that %3, %4, %5 and %6 are correct for each line.';
        txt60000: Label 'Error in %1 %2.\\%3 %4 and %5 must have the same %6 when %7 is specified as %8.';
        txt60001: Label '%1 %2 is out of balance by %7.\\';

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure levtOnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line")
    var
        lrecGenJournalLine: Record "Gen. Journal Line";
        lmdlReverseGLEntries: Codeunit "Reverse G/L Entries";
        ldatLastDate: Date;
        lintLastDocType: Integer;
        lcodLastDocNo: Code[20];
    begin
        Clear(grecSourceCodeSetup); // Codeunit is SingleInstance, this event is the first entry point, so clear variables
        Clear(gintInsertedEntryNo);

        if GenJournalLine."Journal Template Name" = '' then
            exit;

        // Perform checks on balances
        grecGenJnlTemplate.Get(GenJournalLine."Journal Template Name");
        /*if grecGenJnlTemplate.Type in [grecGenJnlTemplate.Type::"GAAP Adjustments", grecGenJnlTemplate.Type::"Group Adjustments", grecGenJnlTemplate.Type::"Tax Adjustments"] then
            with lrecGenJournalLine do begin
                Copy(GenJournalLine);
                SetRange("Journal Template Name", "Journal Template Name");
                SetRange("Journal Batch Name", "Journal Batch Name");
                if FindSet then
                    repeat
                        if ("Posting Date" <> ldatLastDate) or
                            grecGenJnlTemplate."Force Doc. Balance" and
                            (("Document Type" <> lintLastDocType) or ("Document No." <> lcodLastDocNo))
                        then begin
                            if "Bal. Account No." = '' then
                                lfcnCheckGAAPBalance(lrecGenJournalLine);
                            lfcnCheckReclassification(lrecGenJournalLine);
                        end;

                        ldatLastDate := "Posting Date";
                        lintLastDocType := "Document Type";
                        if not EmptyLine then
                            lcodLastDocNo := "Document No.";
                    until Next = 0;
            end;*///SPS
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    local procedure levtOnBeforeInsertGLEntryBuffer(var TempGLEntryBuf: Record "G/L Entry" temporary; var GenJournalLine: Record "Gen. Journal Line")
    var
        lrecGenJournalLineOrg: Record "Gen. Journal Line";
        lrecGLEntryToReverse: Record "G/L Entry";
        lrecGLEntryRecLink: Record "G/L Entry Document Link";
    begin
        with TempGLEntryBuf do begin
            if "Reversed Entry No." <> 0 then begin // Standard NAV Reverse entry
                lrecGLEntryToReverse.Get("Reversed Entry No.");

                "Description (English)" := lrecGLEntryToReverse."Description (English)";
                "Equity Correction Code" := lrecGLEntryToReverse."Equity Correction Code";
                "Client Entry No." := lrecGLEntryToReverse."Client Entry No.";

                "GAAP Adjustment Reason" := lrecGLEntryToReverse."GAAP Adjustment Reason";
                "Adjustment Role" := lrecGLEntryToReverse."Adjustment Role";
                "Tax Adjustment Reason" := lrecGLEntryToReverse."Tax Adjustment Reason";
                Reversible := lrecGLEntryToReverse.Reversible;

                "Corporate G/L Account No." := lrecGLEntryToReverse."Corporate G/L Account No.";
                "Bal. Corporate G/L Account No." := lrecGLEntryToReverse."Bal. Corporate G/L Account No.";
            end else begin
                "Description (English)" := GenJournalLine."Description (English)";
                "Equity Correction Code" := GenJournalLine."Equity Correction Code";
                "Client Entry No." := GenJournalLine."Client Entry No.";

                "GAAP Adjustment Reason" := GenJournalLine."GAAP Adjustment Reason";
                "Adjustment Role" := GenJournalLine."Adjustment Role";
                "Tax Adjustment Reason" := GenJournalLine."Tax Adjustment Reason";
                Reversible := GenJournalLine.Reversible;

                // Populate Corp. Account Nos.
                if GenJournalLine."Journal Template Name" <> '' then
                    if lrecGenJournalLineOrg.Get(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Line No.") then begin
                        if (lrecGenJournalLineOrg."Account Type" = lrecGenJournalLineOrg."Account Type"::"G/L Account") and ("G/L Account No." = lrecGenJournalLineOrg."Account No.") then
                            "Corporate G/L Account No." := lrecGenJournalLineOrg."Corporate G/L Account No.";

                        if (lrecGenJournalLineOrg."Bal. Account Type" = lrecGenJournalLineOrg."Bal. Account Type"::"G/L Account") and (lrecGenJournalLineOrg."Bal. Account No." <> '') then
                            if "G/L Account No." = lrecGenJournalLineOrg."Bal. Account No." then
                                "Corporate G/L Account No." := lrecGenJournalLineOrg."Bal. Corporate G/L Account No.";

                        if "G/L Account No." = lrecGenJournalLineOrg."Account No." then
                            "Bal. Corporate G/L Account No." := lrecGenJournalLineOrg."Bal. Corporate G/L Account No."
                        else
                            if "G/L Account No." = lrecGenJournalLineOrg."Bal. Account No." then
                                "Bal. Corporate G/L Account No." := lrecGenJournalLineOrg."Corporate G/L Account No."
                    end;
            end;

            if grecSourceCodeSetup."TB Reversal" = '' then
                grecSourceCodeSetup.Get;

            // Populate Corp. Account No. for cases where not reverse and normal journal posting etry
            if ("Corporate G/L Account No." = '') and (GenJournalLine."Corporate G/L Account No." <> '') then
                "Corporate G/L Account No." := GenJournalLine."Corporate G/L Account No.";

            if ("Bal. Corporate G/L Account No." = '') and (GenJournalLine."Bal. Corporate G/L Account No." <> '') then
                "Bal. Corporate G/L Account No." := GenJournalLine."Bal. Corporate G/L Account No.";

            if not (("Source Code" <> '') and ("Source Code" in [grecSourceCodeSetup."Close Income Statement", grecSourceCodeSetup.Reversal,
              grecSourceCodeSetup."TB Reversal", grecSourceCodeSetup."GAAP/Tax Reversal"]))
            then begin
                if "System-Created Entry" or ("Corporate G/L Account No." = '') then
                    "Corporate G/L Account No." := lfcnGetCorpAccNo("G/L Account No.");

                if ("System-Created Entry" or ("Bal. Corporate G/L Account No." = '')) and
                  ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") and ("Bal. Account No." <> '')
                then
                    "Bal. Corporate G/L Account No." := lfcnGetCorpAccNo("Bal. Account No.");
            end;

            gintInsertedEntryNo := "Entry No.";

            // Update reversal source entry
            if GenJournalLine."Entry No. to Reverse" <> 0 then begin
                lrecGLEntryToReverse.Get(GenJournalLine."Entry No. to Reverse");
                lrecGLEntryToReverse.TestField("Reversed at", 0D);
                lrecGLEntryToReverse."Reversed at" := "Posting Date";
                lrecGLEntryToReverse."Reversal Entry No." := gintInsertedEntryNo;
                lrecGLEntryToReverse.Modify;
            end;

            // Copy Record Links
            if GenJournalLine.HasLinks then begin
                //lrecGLEntry.GET(GLEntryNo); ??????
                lrecGLEntryRecLink."Transaction No." := "Transaction No.";
                lrecGLEntryRecLink."Document No." := "Document No.";

                if not lrecGLEntryRecLink.Find then
                    lrecGLEntryRecLink.Insert;

                lrecGLEntryRecLink.CopyLinks(GenJournalLine);

                GenJournalLine.DeleteLinks;
            end;
        end;
    end;

    local procedure lfcnGetCorpAccNo(pcodGLAccNo: Code[20]): Code[20]
    var
        lrecGLAcc: Record "G/L Account";
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        if gmdlCompanyTypeMgt.gfcnCorpAccInUse then
            if gmdlCompanyTypeMgt.gfcnIsBottomUp then begin
                lrecGLAcc.Get(pcodGLAccNo);
                lrecGLAcc.TestField("Corporate G/L Account No.");
                exit(lrecGLAcc."Corporate G/L Account No.");
            end else begin
                lrecCorpGLAcc.SetCurrentKey("Local G/L Account No.");
                lrecCorpGLAcc.SetRange("Local G/L Account No.", pcodGLAccNo);
                lrecCorpGLAcc.FindFirst;
                exit(lrecCorpGLAcc."No.");
            end;
    end;

    //[Scope('Internal')]
    procedure gfncGetLastInsertedEntryNo(): Integer
    begin
        exit(gintInsertedEntryNo);
    end;

    local procedure lfcnCheckGAAPBalance(var precGenJnlLine: Record "Gen. Journal Line")
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
    begin
        // MP 07-03-12

        with lrecGenJnlLine do begin
            SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Bal. Account No.",
              "GAAP Adjustment Reason", "Adjustment Role", "Tax Adjustment Reason", "Equity Correction Code");

            SetRange("Journal Template Name", precGenJnlLine."Journal Template Name");
            SetRange("Journal Batch Name", precGenJnlLine."Journal Batch Name");
            SetRange("Posting Date", precGenJnlLine."Posting Date");
            SetRange("Document No.", precGenJnlLine."Document No.");
            SetRange("Bal. Account No.", '');

            FindFirst;
            repeat
                SetRange("GAAP Adjustment Reason", "GAAP Adjustment Reason");
                SetRange("Adjustment Role", "Adjustment Role");
                SetRange("Tax Adjustment Reason", "Tax Adjustment Reason");
                SetRange("Equity Correction Code", "Equity Correction Code");
                CalcSums("Amount (LCY)");
                if "Amount (LCY)" <> 0 then
                    Error(
                      txt60001 +
                      Text013,
                      FieldCaption("Document No."), "Document No.",
                      FieldCaption("GAAP Adjustment Reason"), FieldCaption("Adjustment Role"),
                      FieldCaption("Equity Correction Code"), FieldCaption("Tax Adjustment Reason"),
                      "Amount (LCY)");

                FindLast;
                SetRange("GAAP Adjustment Reason");
                SetRange("Adjustment Role");
                SetRange("Tax Adjustment Reason");
                SetRange("Equity Correction Code");
            until Next = 0;
        end;
    end;

    local procedure lfcnCheckReclassification(var precGenJnlLine: Record "Gen. Journal Line")
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
        lrecCorpGLAcc: array[2] of Record "Corporate G/L Account";
    begin
        // MP 07-03-12

        with lrecGenJnlLine do begin
            SetRange("Journal Template Name", precGenJnlLine."Journal Template Name");
            SetRange("Journal Batch Name", precGenJnlLine."Journal Batch Name");
            SetRange("Document No.", precGenJnlLine."Document No.");
            SetRange("GAAP Adjustment Reason", "GAAP Adjustment Reason"::Reclassification);

            if FindSet then
                repeat
                    if ("Account Type" = "Account Type"::"G/L Account") or
                      ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")
                    then begin
                        if ("Account Type" = "Account Type"::"G/L Account") and ("Corporate G/L Account No." <> '') then begin
                            if lrecCorpGLAcc[1]."No." = '' then
                                lrecCorpGLAcc[1].Get("Corporate G/L Account No.")
                            else
                                lrecCorpGLAcc[2].Get("Corporate G/L Account No.");
                        end;

                        if ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") and ("Bal. Corporate G/L Account No." <> '') then begin
                            if lrecCorpGLAcc[1]."No." = '' then
                                lrecCorpGLAcc[1].Get("Bal. Corporate G/L Account No.")
                            else
                                lrecCorpGLAcc[2].Get("Bal. Corporate G/L Account No.");
                        end;

                        if (lrecCorpGLAcc[1]."No." <> '') and (lrecCorpGLAcc[2]."No." <> '') then
                            if lrecCorpGLAcc[1]."Account Class" <> lrecCorpGLAcc[2]."Account Class" then
                                Error(txt60000, FieldCaption("Document No."), "Document No.",
                                  lrecCorpGLAcc[1].TableCaption, lrecCorpGLAcc[1]."No.", lrecCorpGLAcc[2]."No.",
                                  lrecCorpGLAcc[1].FieldCaption("Account Class"),
                                  FieldCaption("GAAP Adjustment Reason"), "GAAP Adjustment Reason");
                    end;
                until Next = 0;
        end;
    end;
}

