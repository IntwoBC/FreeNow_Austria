codeunit 61002 "T:Gen. Journal Line"
{

    trigger OnRun()
    begin
    end;

    var
        grecLastGenJnlLine: Record "Gen. Journal Line";

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterModifyEvent', '', false, false)]
    local procedure levtOnAfterModify(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
    begin
        with Rec do begin
            if "Shortcut Dimension 1 Code" = '' then
                lfcnPopulateShortcutDim1(Rec);

            if ("Ready to Post" <> xRec."Ready to Post") and ("Document No." <> '') then begin
                lrecGenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                lrecGenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                lrecGenJnlLine.SetFilter("Line No.", '<>%1', "Line No.");
                lrecGenJnlLine.SetRange("Document No.", "Document No.");
                if not lrecGenJnlLine.IsEmpty then
                    lrecGenJnlLine.ModifyAll("Ready to Post", "Ready to Post");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure levtOnAfterValidateAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        lrecGenJnlBatch: Record "Gen. Journal Batch";
        lrecGLAcc: Record "G/L Account";
        lblnReplaceInfo: Boolean;
    begin
        with Rec do begin
            if "Account Type" = "Account Type"::"G/L Account" then begin
                lblnReplaceInfo := "Bal. Account No." = '';
                if not lblnReplaceInfo then begin
                    lrecGenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
                    lblnReplaceInfo := lrecGenJnlBatch."Bal. Account No." <> '';
                end;
                if lblnReplaceInfo and ("Account No." <> '') then begin
                    lrecGLAcc.Get("Account No.");
                    "Description (English)" := lrecGLAcc."Name (English)";
                end;

                if CurrFieldNo = FieldNo("Account No.") then
                    "Corporate G/L Account No." := lfcnGetCorpAccNo("Account No.");

                Validate("GAAP Adjustment Reason");
            end;
            lfcnPopulateShortcutDim1(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure levtOnAfterValidatePostingDate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        lrecGenJnlBatch: Record "Gen. Journal Batch";
        lmdlNoSeriesMgt: Codeunit "No. Series"; //NoSeriesManagement;//#69855: Extension incompatibility
    begin
        //with Rec do begin//#69855: Extension incompatibility
        if (Rec."Line No." in [0, 10000]) and
          (CurrFieldNo = Rec.FieldNo("Posting Date"))
        then begin
            lrecGenJnlBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
            if lrecGenJnlBatch."No. Series" <> '' then begin
                Clear(lmdlNoSeriesMgt);
                //"Document No." := lmdlNoSeriesMgt.TryGetNextNo(lrecGenJnlBatch."No. Series", "Posting Date");//#69855: Extension incompatibility
                Rec."Document No." := lmdlNoSeriesMgt.GetNextNo(lrecGenJnlBatch."No. Series", Rec."Posting Date");
            end;
        end;
        //end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Bal. Account No.', false, false)]
    local procedure levtOnAfterValidateBalAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        with Rec do begin
            if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then begin
                if CurrFieldNo = FieldNo("Bal. Account No.") then
                    "Bal. Corporate G/L Account No." := lfcnGetCorpAccNo("Bal. Account No.");
            end;
            lfcnPopulateShortcutDim1(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'Corporate G/L Account No.', false, false)]
    local procedure levtOnBeforeValidateCorporateGLAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        with Rec do begin
            if not lfcnIsBottomUp then begin
                if "Corporate G/L Account No." <> '' then begin
                    lrecCorpGLAcc.Get("Corporate G/L Account No.");
                    lrecCorpGLAcc.TestField("Local G/L Account No.");

                    Validate("Account Type", "Account Type"::"G/L Account");
                    Validate("Account No.", lrecCorpGLAcc."Local G/L Account No.");
                end
            end else
                if "Corporate G/L Account No." <> '' then begin
                    Validate("Account Type", "Account Type"::"G/L Account");

                    lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");
                    lrecGLAcc.SetRange("Corporate G/L Account No.", "Corporate G/L Account No.");
                    if lrecGLAcc.Count = 1 then begin
                        lrecGLAcc.FindFirst;
                        Validate("Account No.", lrecGLAcc."No.");
                    end else
                        Validate("Account No.", '');
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'Bal. Corporate G/L Account No.', false, false)]
    local procedure levtOnBeforeValidateBalCorporateGLAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        with Rec do begin
            if not lfcnIsBottomUp then begin
                if "Bal. Corporate G/L Account No." <> '' then begin
                    lrecCorpGLAcc.Get("Bal. Corporate G/L Account No.");
                    lrecCorpGLAcc.TestField("Local G/L Account No.");

                    Validate("Bal. Account Type", "Bal. Account Type"::"G/L Account");
                    Validate("Bal. Account No.", lrecCorpGLAcc."Local G/L Account No.");
                end
            end else
                if "Bal. Corporate G/L Account No." <> '' then begin
                    Validate("Bal. Account Type", "Bal. Account Type"::"G/L Account");

                    lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");
                    lrecGLAcc.SetRange("Corporate G/L Account No.", "Bal. Corporate G/L Account No.");
                    if lrecGLAcc.Count = 1 then begin
                        lrecGLAcc.FindFirst;
                        Validate("Bal. Account No.", lrecGLAcc."No.");
                    end else
                        Validate("Bal. Account No.", '');
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'GAAP Adjustment Reason', false, false)]
    local procedure levtOnBeforeValidateGAAPAdjustmentReason(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    var
        lrecGLAcc: Record "G/L Account";
    begin
        with Rec do begin
            if ("GAAP Adjustment Reason" = "GAAP Adjustment Reason"::Reclassification) and
              ("Account Type" = "Account Type"::"G/L Account") and ("Account No." <> '')
            then begin
                lrecGLAcc.Get("Account No.");
                Validate(Reversible, lrecGLAcc."Income/Balance" = lrecGLAcc."Income/Balance"::"Balance Sheet");
            end else
                Validate(Reversible, false);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnBeforeValidateEvent', 'Reversible', false, false)]
    local procedure levtOnBeforeValidateReversible(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        with Rec do
            if Reversible <> xRec.Reversible then
                gfncUpdateReversible(Rec);
    end;
    /*
        [EventSubscriber(ObjectType::Table, 81, 'gpubOnSetUpNewLine', '', false, false)]
        local procedure levtOnSetUpNewLine(var Sender: Record "Gen. Journal Line"; LastGenJnlLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean; GenJnlLine: Record "Gen. Journal Line"; GenJnlTemplate: Record "Gen. Journal Template")
        begin
            if GenJnlLine.FindFirst then
                if not (BottomLine and
                  (Balance - LastGenJnlLine."Balance (LCY)" = 0) and
                  not LastGenJnlLine.EmptyLine)
                then begin
                    Sender."GAAP Adjustment Reason" := LastGenJnlLine."GAAP Adjustment Reason";
                    Sender."Adjustment Role" := LastGenJnlLine."Adjustment Role";
                    Sender."Tax Adjustment Reason" := LastGenJnlLine."Tax Adjustment Reason";
                    Sender."Equity Correction Code" := LastGenJnlLine."Equity Correction Code";
                end;
    */
    /* if GenJnlTemplate.Type in [GenJnlTemplate.Type::"GAAP Adjustments", GenJnlTemplate.Type::"Tax Adjustments",
       GenJnlTemplate.Type::"Group Adjustments"]
     then begin
         if Sender."Tax Adjustment Reason" = Sender."Tax Adjustment Reason"::" " then
             Sender."Tax Adjustment Reason" := Sender."Tax Adjustment Reason"::"P&L";
         if Sender."Adjustment Role" = Sender."Adjustment Role"::" " then
             Sender."Adjustment Role" := Sender."Adjustment Role"::EY;
     end;
     */
    //end;
    //[Scope('Internal')]
    procedure gfcnLookupCorporateGLAccountNo(var precGenJournalLine: Record "Gen. Journal Line")
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        with precGenJournalLine do begin
            TestField("Account Type", "Account Type"::"G/L Account");

            lrecCorpGLAcc."No." := "Corporate G/L Account No.";

            if not lfcnIsBottomUp then
                if "Account No." <> '' then begin
                    lrecCorpGLAcc.SetCurrentKey("Local G/L Account No.");
                    lrecCorpGLAcc.SetRange("Local G/L Account No.", "Account No.");
                end;

            if PAGE.RunModal(0, lrecCorpGLAcc) = ACTION::LookupOK then
                Validate("Corporate G/L Account No.", lrecCorpGLAcc."No.");
        end;
    end;

    //[Scope('Internal')]
    procedure gfcnLookupBalCorporateGLAccountNo(var precGenJournalLine: Record "Gen. Journal Line")
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        with precGenJournalLine do begin
            TestField("Bal. Account Type", "Bal. Account Type"::"G/L Account");

            lrecCorpGLAcc."No." := "Bal. Corporate G/L Account No.";

            if not lfcnIsBottomUp then
                if "Bal. Account No." <> '' then begin
                    lrecCorpGLAcc.SetCurrentKey("Local G/L Account No.");
                    lrecCorpGLAcc.SetRange("Local G/L Account No.", "Bal. Account No.");
                end;

            if PAGE.RunModal(0, lrecCorpGLAcc) = ACTION::LookupOK then
                Validate("Bal. Corporate G/L Account No.", lrecCorpGLAcc."No.");
        end;
    end;

    local procedure lfcnGetCorpAccNo(var pcodAccNo: Code[20]): Code[20]
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        if pcodAccNo = '' then
            exit;

        lrecGLAcc.Get(pcodAccNo);
        // MP 18-01-12

        // MP 19-11-13 >>
        if lfcnIsBottomUp then
            exit(lrecGLAcc."Corporate G/L Account No.");
        // MP 19-11-13 <<

        lrecCorpGLAcc.SetCurrentKey("Local G/L Account No.");
        lrecCorpGLAcc.SetRange("Local G/L Account No.", pcodAccNo);
        if lrecCorpGLAcc.Count = 1 then begin
            lrecCorpGLAcc.FindFirst;
            exit(lrecCorpGLAcc."No.");
        end
        // MP 19-02-14 >>
        else
            exit('');
        // MP 19-02-14 <<
    end;

    //[Scope('Internal')]
    procedure gfcnMarkCorpAccLines(var precGenJournalLine: Record "Gen. Journal Line"; pcodCorpAccNo: Code[20])
    begin
        with precGenJournalLine do begin
            // MP 18-01-12

            // First mark all entries for "Corporate G/L Account No."
            SetRange("Corporate G/L Account No.", pcodCorpAccNo);
            if FindSet then
                repeat
                    Mark(true);
                until Next = 0;

            // Then mark all entries for "Bal. Corporate G/L Account No."
            SetRange("Corporate G/L Account No.");
            SetRange("Bal. Corporate G/L Account No.", pcodCorpAccNo);
            if FindSet then
                repeat
                    Mark(true);
                until Next = 0;

            SetRange("Bal. Corporate G/L Account No.");

            MarkedOnly(true);
        end;
    end;

    local procedure lfcnPopulateShortcutDim1(var precGenJournalLine: Record "Gen. Journal Line")
    var
        lrecGenJnlTemplate: Record "Gen. Journal Template";
    begin
        with precGenJournalLine do begin
            // MP 18-01-12

            if lrecGenJnlTemplate.Get("Journal Template Name") then
                if (lrecGenJnlTemplate."Shortcut Dimension 1 Code" <> '') and
                  ("Shortcut Dimension 1 Code" <> lrecGenJnlTemplate."Shortcut Dimension 1 Code")
                then
                    Validate("Shortcut Dimension 1 Code", lrecGenJnlTemplate."Shortcut Dimension 1 Code");
        end;
    end;

    //[Scope('Internal')]
    procedure gfncUpdateReversible(var precGenJournalLine: Record "Gen. Journal Line")
    var
        lrecGenJournalLine: Record "Gen. Journal Line";
    begin
        with precGenJournalLine do begin
            TestField("Posting Date");
            TestField("Document No.");
            lrecGenJournalLine.SetRange("Journal Template Name", "Journal Template Name");
            lrecGenJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
            lrecGenJournalLine.SetFilter("Line No.", '<>%1', "Line No.");
            lrecGenJournalLine.SetRange("Posting Date", "Posting Date");
            lrecGenJournalLine.SetRange("Document No.", "Document No.");
            if lrecGenJournalLine.FindSet then
                repeat
                    lrecGenJournalLine.Reversible := Reversible;
                    lrecGenJournalLine.Modify;
                until lrecGenJournalLine.Next = 0;
        end;
    end;

    local procedure lfcnIsBottomUp(): Boolean
    var
        lrecEYCoreSetup: Record "EY Core Setup";
    begin
        // MP 19-11-13

        lrecEYCoreSetup.Get;
        exit(lrecEYCoreSetup."Company Type" = lrecEYCoreSetup."Company Type"::"Bottom-up");
    end;

    //[Scope('Internal')]
    procedure gfcnMarkLocalAccLines(var precGenJournalLine: Record "Gen. Journal Line"; ptxtLocalAccNoFilter: Text[1024])
    begin
        with precGenJournalLine do begin
            // MP 19-11-13
            // First mark all entries for "Account No."
            SetRange("Account Type", "Account Type"::"G/L Account");
            SetFilter("Account No.", ptxtLocalAccNoFilter);
            if FindSet then
                repeat
                    Mark(true);
                until Next = 0;

            // Then mark all entries for "Bal. Account No."
            SetRange("Account Type");
            SetRange("Bal. Account Type", "Bal. Account Type"::"G/L Account");
            SetRange("Account No.");
            SetFilter("Bal. Account No.", ptxtLocalAccNoFilter);
            if FindSet then
                repeat
                    Mark(true);
                until Next = 0;

            SetRange("Bal. Account Type");
            SetRange("Bal. Account No.");

            MarkedOnly(true);
        end;
    end;

    //[Scope('Internal')]
    procedure gfcnLookupAccNo(var precGenJournalLine: Record "Gen. Journal Line"; poptAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; pcodAccNo: Code[20]; pcodCorpGLAccNo: Code[20]; pintCurrFieldNo: Integer)
    var
        lrecGLAcc: Record "G/L Account";
        lrecCust: Record Customer;
        lrecVend: Record Vendor;
        lrecBankAcc: Record "Bank Account";
        lrecFixedAsset: Record "Fixed Asset";
        lrecICPartner: Record "IC Partner";
        lcodAccNo: Code[20];
    begin
        case poptAccType of
            poptAccType::"G/L Account":
                begin
                    if lfcnIsBottomUp and (pcodCorpGLAccNo <> '') then begin
                        lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");
                        lrecGLAcc.SetRange("Corporate G/L Account No.", pcodCorpGLAccNo);
                    end;

                    lrecGLAcc."No." := pcodAccNo;
                    if PAGE.RunModal(0, lrecGLAcc) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecGLAcc."No.";
                end;

            poptAccType::Customer:
                begin
                    lrecCust."No." := pcodAccNo;
                    if PAGE.RunModal(0, lrecCust) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecCust."No."
                end;

            poptAccType::Vendor:
                begin
                    lrecVend."No." := pcodAccNo;
                    if PAGE.RunModal(0, lrecVend) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecVend."No."
                end;

            poptAccType::"Bank Account":
                begin
                    lrecBankAcc."No." := pcodAccNo;
                    if PAGE.RunModal(0, lrecBankAcc) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecBankAcc."No."
                end;

            poptAccType::"Fixed Asset":
                begin
                    lrecFixedAsset."No." := pcodAccNo;
                    if PAGE.RunModal(0, lrecFixedAsset) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecFixedAsset."No."
                end;

            poptAccType::"IC Partner":
                begin
                    lrecICPartner.Code := pcodAccNo;
                    if PAGE.RunModal(0, lrecICPartner) <> ACTION::LookupOK then
                        exit;
                    lcodAccNo := lrecICPartner.Code
                end;

        end;

        with precGenJournalLine do
            case pintCurrFieldNo of
                FieldNo("Account No."):
                    Validate("Account No.", lcodAccNo);

                FieldNo("Bal. Account No."):
                    Validate("Bal. Account No.", lcodAccNo);
            end;
    end;

    //[Scope('Internal')]
    procedure gfcnGetCorpAccounts(var precGenJnlLine: Record "Gen. Journal Line"; var ptxtCorpAccName: Text[50]; var ptxtBalCorpAccName: Text[50])
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        with precGenJnlLine do begin
            if "Corporate G/L Account No." <> grecLastGenJnlLine."Corporate G/L Account No." then begin
                ptxtCorpAccName := '';
                if "Corporate G/L Account No." <> '' then
                    if lrecCorpGLAcc.Get("Corporate G/L Account No.") then
                        ptxtCorpAccName := lrecCorpGLAcc.Name;
            end;

            if "Bal. Corporate G/L Account No." <> grecLastGenJnlLine."Bal. Corporate G/L Account No." then begin
                ptxtBalCorpAccName := '';
                if "Bal. Corporate G/L Account No." <> '' then
                    if lrecCorpGLAcc.Get("Bal. Corporate G/L Account No.") then
                        ptxtBalCorpAccName := lrecCorpGLAcc.Name;
            end;

            grecLastGenJnlLine := precGenJnlLine;
        end;
    end;
}

