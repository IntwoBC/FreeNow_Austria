codeunit 60036 "Adjustments Management"
{

    trigger OnRun()
    begin
    end;

    var
        GLE: Record "G/L Entry";

    //[Scope('Internal')]
    procedure gfcnShowEntries(var precGLEntry: Record "G/L Entry"; pblnIncludeUnpostedEntries: Boolean; pblnCorporate: Boolean)
    var
        ltmpAdjmtEntryBuffer: Record "Adjustment Entry Buffer" temporary;
    begin
        if not pblnIncludeUnpostedEntries then
            PAGE.Run(PAGE::"General Ledger Entries", precGLEntry)
        else begin
            gfcnGetEntries(ltmpAdjmtEntryBuffer, precGLEntry, pblnCorporate, false);
            PAGE.Run(PAGE::"Adjustment Entries", ltmpAdjmtEntryBuffer);
        end;
    end;

    //[Scope('Internal')]
    procedure gfcnGetEntries(var ptmpAdjmtEntryBuffer: Record "Adjustment Entry Buffer" temporary; var precGLEntry: Record "G/L Entry"; pblnCorporate: Boolean; pblnExcludeReclassReversal: Boolean)
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
        lrecCorpAccPeriod: Record "Corporate Accounting Period";
        lintEntryNo: Integer;
    begin
        ptmpAdjmtEntryBuffer.Reset;
        ptmpAdjmtEntryBuffer.DeleteAll;

        with precGLEntry do begin
            if FindSet then
                repeat
                    if not (pblnExcludeReclassReversal and ("GAAP Adjustment Reason" = "GAAP Adjustment Reason"::Reclassification) and
                      (("Reversal Entry No." <> 0) or lrecCorpAccPeriod.Get("Posting Date")))
                    then begin
                        lintEntryNo += 1;
                        ptmpAdjmtEntryBuffer.TransferFields(precGLEntry);
                        ptmpAdjmtEntryBuffer."G/L Entry No." := "Entry No.";
                        ptmpAdjmtEntryBuffer."Entry No." := lintEntryNo;
                        ptmpAdjmtEntryBuffer.Insert;
                    end;
                until Next = 0;
        end;

        with lrecGenJnlLine do begin
            precGLEntry.CopyFilter("Posting Date", "Posting Date");
            precGLEntry.CopyFilter("Document No.", "Document No.");
            precGLEntry.CopyFilter("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
            precGLEntry.CopyFilter("Global Dimension 2 Code", "Shortcut Dimension 2 Code");
            precGLEntry.CopyFilter("Business Unit Code", "Business Unit Code");
            precGLEntry.CopyFilter("GAAP Adjustment Reason", "GAAP Adjustment Reason");
            precGLEntry.CopyFilter("Equity Correction Code", "Equity Correction Code");

            // First get all entries for Local/Corporate G/L Account No.
            SetRange("Account Type", "Account Type"::"G/L Account");
            if pblnCorporate then
                precGLEntry.CopyFilter(precGLEntry."Corporate G/L Account No.", "Corporate G/L Account No.")
            else
                precGLEntry.CopyFilter(precGLEntry."G/L Account No.", "Account No.");

            if FindSet then
                repeat
                    if not (pblnExcludeReclassReversal and ("GAAP Adjustment Reason" = "GAAP Adjustment Reason"::Reclassification) and
                      lrecCorpAccPeriod.Get("Posting Date"))
                    then
                        lfcnInsertUnpostedEntry(lintEntryNo, ptmpAdjmtEntryBuffer, lrecGenJnlLine, false);
                until Next = 0;

            // Then get all entries for Bal. Local/Corporate G/L Account No.
            SetRange("Account Type");
            if pblnCorporate then
                SetRange("Corporate G/L Account No.")
            else
                SetRange("Account No.");

            SetRange("Bal. Account Type", "Bal. Account Type"::"G/L Account");
            if pblnCorporate then
                precGLEntry.CopyFilter(precGLEntry."Corporate G/L Account No.", "Bal. Corporate G/L Account No.")
            else
                precGLEntry.CopyFilter(precGLEntry."G/L Account No.", "Bal. Account No.");

            if FindSet then
                repeat
                    if not (pblnExcludeReclassReversal and ("GAAP Adjustment Reason" = "GAAP Adjustment Reason"::Reclassification) and
                      lrecCorpAccPeriod.Get("Posting Date"))
                    then
                        lfcnInsertUnpostedEntry(lintEntryNo, ptmpAdjmtEntryBuffer, lrecGenJnlLine, true);
                until Next = 0;
        end;
    end;

    local procedure lfcnInsertUnpostedEntry(var pintEntryNo: Integer; var ptmpAdjmtEntryBuffer: Record "Adjustment Entry Buffer" temporary; var precGenJnlLine: Record "Gen. Journal Line"; pblnBalAcc: Boolean)
    begin
        with ptmpAdjmtEntryBuffer do begin
            if pblnBalAcc and (precGenJnlLine."Bal. Account No." = '') then
                exit;

            Init;
            pintEntryNo += 1;
            "Entry No." := pintEntryNo;

            if pblnBalAcc then begin
                "G/L Account No." := precGenJnlLine."Bal. Account No.";
                "Corporate G/L Account No." := precGenJnlLine."Bal. Corporate G/L Account No.";
            end else begin
                "G/L Account No." := precGenJnlLine."Account No.";
                "Corporate G/L Account No." := precGenJnlLine."Corporate G/L Account No.";
            end;

            "Posting Date" := precGenJnlLine."Posting Date";
            "Document No." := precGenJnlLine."Document No.";
            Description := precGenJnlLine.Description;
            if pblnBalAcc then
                Amount := -precGenJnlLine.Amount
            else
                Amount := precGenJnlLine.Amount;

            "Global Dimension 1 Code" := precGenJnlLine."Shortcut Dimension 1 Code";

            "GAAP Adjustment Reason" := precGenJnlLine."GAAP Adjustment Reason";
            "Adjustment Role" := precGenJnlLine."Adjustment Role";
            "Equity Correction Code" := precGenJnlLine."Equity Correction Code";
            Reversible := precGenJnlLine.Reversible;
            "G/L Entry No." := 0;
            Insert;
        end;
    end;
}

