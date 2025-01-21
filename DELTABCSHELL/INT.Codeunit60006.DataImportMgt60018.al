codeunit 60006 "Data Import Mgt 60018"
{
    // This codeunit contains Staging table specific functionality
    // Specific to table 60018 - Corporate G/L Acc (Staging)
    // 
    // MP 19-04-12
    // Added check for "Financial Statement Code". Changed Text Constant ERR_001 to be generic, removed ERR_002
    // 
    // TEC 12-04-13 -mdan-
    //   Maintenance of new fields
    // 
    // MP 30-04-14
    // Development taken from Core II
    // 
    // MP 31-03-16
    // Amended function gfncPostTransactions() in order to populate historic FS Codes (CB1 CR002)


    trigger OnRun()
    begin
    end;

    var
        TXT_PAGE: Label 'Page';
        DLG_001: Label '#1################## \ Progress @2@@@@@@@@@@@@@@@@@@';
        DLG_002: Label 'Target #1########################\Activity #2########\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        DLG_003: Label 'Archiving records\@1@@@@@@@@@@@@@@@@@@';
        ERR_001: Label '%1 is missing. Corporate Account No. %2';
        ERR_003: Label 'G/L account %1 defined in Corporate Account %2 does not exist in Company %3';
        MSG_001: Label 'Validating imported records';
        MSG_002: Label 'Building Batch';
        MSG_003: Label 'Sending';

    //[Scope('Internal')]
    procedure "<-- Stage 1 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncAfterInitRecord(var p_rrefRecRef: RecordRef)
    var
        lfrefFieldRef: FieldRef;
    begin
        //
        // Table specific record initialization - default values etc.
        // Called after record is initialized (99xxx fields)
        // before data is populated
        //
    end;

    //[Scope('Internal')]
    procedure gfncAfterSaveRecord(var p_rrefRecRef: RecordRef)
    var
        lfrefFieldRef: FieldRef;
        lrecCorporateGLAccStaging: Record "Corporate G/L Acc (Staging)";
        lintResult: Integer;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        //
        // Table specific record initialization - default values depending on imported values
        // Called after record is saved
        //
        //
        // If imported record does not have value in "Local Chart Of Acc (Mapped)" then populate it with No.
        //
        p_rrefRecRef.SetTable(lrecCorporateGLAccStaging);
        if lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)" = '' then begin
            lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)" := lrecCorporateGLAccStaging."No.";
            lrecCorporateGLAccStaging.Modify;
        end;

        lintResult := lmodDataImportManagementCommon.gfncResolveIncomeBalance(lrecCorporateGLAccStaging."Accounting Class");
        if lintResult <> -1 then begin
            lrecCorporateGLAccStaging."Income/Balance" := lintResult;
            lrecCorporateGLAccStaging.Modify;
        end;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 2 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncValidateImportRec(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecCorporateGLAccStaging: Record "Corporate G/L Acc (Staging)";
        lintTotal: Integer;
        lintPosition: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;
        lrecCorporateGLAccStaging.SetCurrentKey("Import Log Entry No.");
        lrecCorporateGLAccStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
            ldlgDialog.Update(1, MSG_001);
            lintTotal := lrecCorporateGLAccStaging.Count;
            lintPosition := 0;
        end;

        //
        // Checks that can be done one by one
        //

        lrecCorporateGLAccStaging.Reset;
        lrecCorporateGLAccStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecCorporateGLAccStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lintLastPct := 0;
        if lrecCorporateGLAccStaging.FindSet(false) then
            repeat
                if p_blnDialog then begin
                    lintPosition += 1;
                    if Round((lintPosition / lintTotal) * 100, 1, '<') > lintLastPct then begin
                        lintLastPct := Round((lintPosition / lintTotal) * 100, 1, '<');
                        ldlgDialog.Update(2, lintLastPct * 100);
                    end;
                end;

                //
                // Specific check here
                //
                if lrecCorporateGLAccStaging."Company No." = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                      //                                   STRSUBSTNO(ERR_001, lrecCorporateGLAccStaging."No.")); // MP 19-04-12 Replaced by below
                      StrSubstNo(ERR_001, lrecCorporateGLAccStaging.FieldCaption("Company No."), lrecCorporateGLAccStaging."No."));
                end;
                if lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)" = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                      //                                   STRSUBSTNO(ERR_002, lrecCorporateGLAccStaging."No.")); // MP 19-04-12 Replaced by below
                      StrSubstNo(ERR_001, lrecCorporateGLAccStaging.FieldCaption("Local Chart Of Acc (Mapped)"), lrecCorporateGLAccStaging."No."));
                end;

                // MP 19-04-12 >>

                if lrecCorporateGLAccStaging."Financial Statement Code" = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                      StrSubstNo(ERR_001, lrecCorporateGLAccStaging.FieldCaption("Financial Statement Code"), lrecCorporateGLAccStaging."No."));
                end;

            // MP 19-04-12 <<

            until lrecCorporateGLAccStaging.Next = 0;


        if p_blnDialog then begin
            ldlgDialog.Close;
        end;
    end;

    //[Scope('Internal')]
    procedure gfncUpdateDateRange(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lmodDataImportSafeWScall: Codeunit "Data Import Safe WS call";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldatStartDate: Date;
        ldatEndDate: Date;
    begin
        r_blnResult := true;
        // Get list of companies
        lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.", "Company No.", "Posting Date");
        lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        if lrecImportLogSubsidiaryClient.FindSet(true) then
            repeat
                lrecImportLogSubsidiaryClient."First Entry Date" := p_recImportLog."Import Date";
                lrecImportLogSubsidiaryClient."Last Entry Date" := p_recImportLog."Import Date";
                lrecImportLogSubsidiaryClient.Modify;
            until lrecImportLogSubsidiaryClient.Next = 0;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 3 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncProcessClient(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    begin
        //
        // Do Processing of data before they are sent to local database
        // (Export data from Master database etc..)
        //
        exit(true);
    end;

    //[Scope('Internal')]
    procedure gfncGetActionNoCopyData(): Integer
    begin
        //
        // Returns Action Number which represents copy data
        // as per definiton in CU 60008 Data Import Safe WS call
        //
        exit(9);
    end;

    //[Scope('Internal')]
    procedure gfncCopyClient(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        //ldotCorpGLAccountStg_Service: DotNet CorpGLAccountStg_Service;
        //ldotCorpGLAccountStg: DotNet CorpGLAccountStg;
        //ldotArray: DotNet Array;
        lintBatchSize: Integer;
        lintArrayPosition: Integer;
        lintArrayLength: Integer;
        lintRemainingRecords: Integer;
        lrecCorporateGLAccStaging: Record "Corporate G/L Acc (Staging)";
        lblnNoMoreRecords: Boolean;
        ltxtURL: Text[1024];
        ltxtErr: Text[1024];
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldlgDialog: Dialog;
        lintRecordCount: Integer;
        lintCounter: Integer;
        lintLastPct: Integer;
    begin
        //
        // Copy data to specific client using webservice
        //
        if p_blnDialog then begin
            ldlgDialog.Open(DLG_002);
            ldlgDialog.Update(1, p_recImportLogSubsidiaryClient."Company Name");
        end;
        //ldotCorpGLAccountStg_Service := ldotCorpGLAccountStg_Service.CorpGLAccountStg_Service();
        //ldotCorpGLAccountStg_Service.UseDefaultCredentials(TRUE);

        if not lmodDataImportManagementCommon.gfncBuildURL(p_recImportLogSubsidiaryClient,
                                                           TXT_PAGE,
                                                           lmodDataImportManagementCommon.gfncGetCorpGLAccStgWSName(),
                                                           ltxtURL, ltxtErr)
          then begin
            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, ltxtErr);
            exit(false);
        end;

        //ldotCorpGLAccountStg_Service.Url := ltxtURL;
        //ToDo Move to setup
        lintBatchSize := 500; // Initial batch size Should be in setup!
        lblnNoMoreRecords := false;

        lrecCorporateGLAccStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecCorporateGLAccStaging.SetRange("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
        lrecCorporateGLAccStaging.SetRange("Company No.", p_recImportLogSubsidiaryClient."Company No.");
        lintRemainingRecords := lrecCorporateGLAccStaging.Count;
        lintArrayPosition := 0;
        //ldotCorpGLAccountStg := ldotCorpGLAccountStg.CorpGLAccountStg();

        if p_blnDialog then begin
            lintRecordCount := lrecCorporateGLAccStaging.Count;
            lintCounter := 0;
        end;

        if lrecCorporateGLAccStaging.FindSet(false) then begin
            repeat
                // Build array up to the batch size
                if p_blnDialog then begin
                    ldlgDialog.Update(2, MSG_002);
                end;

                if lintRemainingRecords > lintBatchSize then
                    lintArrayLength := lintBatchSize
                else
                    lintArrayLength := lintRemainingRecords;
            //if not IsNull(ldotArray) then Clear(ldotArray);
            /*
            ldotArray := ldotArray.CreateInstance(ldotCorpGLAccountStg.GetType(), lintArrayLength);
            lintLastPct := 0;
            REPEAT
              IF p_blnDialog THEN BEGIN
                lintCounter += 1;
                IF ROUND((lintCounter/lintRecordCount)*100,1,'<') > lintLastPct THEN BEGIN
                  lintLastPct := ROUND((lintCounter/lintRecordCount)*100,1,'<');
                  ldlgDialog.UPDATE(3, lintLastPct * 100);
                END;
              END;
              IF NOT ISNULL(ldotCorpGLAccountStg) THEN CLEAR(ldotCorpGLAccountStg);
              ldotCorpGLAccountStg := ldotCorpGLAccountStg.CorpGLAccountStg; // Constructor
              // Build record
              ldotCorpGLAccountStg.No                            := lrecCorporateGLAccStaging."No.";
              ldotCorpGLAccountStg.Name                          := lrecCorporateGLAccStaging.Name;
              ldotCorpGLAccountStg.Income_Balance                := lrecCorporateGLAccStaging."Income/Balance";
              ldotCorpGLAccountStg.Income_BalanceSpecified       := TRUE;
              ldotCorpGLAccountStg.Gen_Bus_Posting_Type          := lrecCorporateGLAccStaging."Gen. Bus. Posting Type";
              ldotCorpGLAccountStg.Gen_Bus_Posting_TypeSpecified := TRUE;
              ldotCorpGLAccountStg.Accounting_Class              := lrecCorporateGLAccStaging."Accounting Class";
              ldotCorpGLAccountStg.Accounting_ClassSpecified     := TRUE;
              ldotCorpGLAccountStg.Name_ENU                      := lrecCorporateGLAccStaging."Name - ENU";
              ldotCorpGLAccountStg.Financial_Statement_Code      := lrecCorporateGLAccStaging."Financial Statement Code";
              ldotCorpGLAccountStg.Local_Chart_Of_Acc_Mapped     := lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)";
              ldotCorpGLAccountStg.Company_No                    := lrecCorporateGLAccStaging."Company No.";
              ldotCorpGLAccountStg.Client_No                     := lrecCorporateGLAccStaging."Client No.";
              ldotCorpGLAccountStg.User_ID                       := lrecCorporateGLAccStaging."User ID";
              ldotCorpGLAccountStg.Status                        := lrecCorporateGLAccStaging.Status;
              ldotCorpGLAccountStg.StatusSpecified               := TRUE;
              ldotCorpGLAccountStg.Import_Log_Entry_No           := lrecCorporateGLAccStaging."Import Log Entry No.";
              ldotCorpGLAccountStg.Import_Log_Entry_NoSpecified  := TRUE;

              ldotCorpGLAccountStg.FS_Name                       := lrecCorporateGLAccStaging."FS Name";
              ldotCorpGLAccountStg.FS_Name_English               := lrecCorporateGLAccStaging."FS Name (English)";

              // Add to array
              ldotArray.SetValue(ldotCorpGLAccountStg, lintArrayPosition);
              lintArrayPosition += 1;
              lblnNoMoreRecords := (lrecCorporateGLAccStaging.NEXT = 0);
              lintRemainingRecords -= 1;
            UNTIL ((lintArrayPosition = (lintBatchSize-1)) OR lblnNoMoreRecords);
            lintArrayPosition := 0;
            IF p_blnDialog THEN BEGIN
              ldlgDialog.UPDATE(2, MSG_003);
            END;
            // and send it
            ldotCorpGLAccountStg_Service.CreateMultiple(ldotArray); // disabled for testing
            */
            until lblnNoMoreRecords;
        end;

        if p_blnDialog then begin
            ldlgDialog.Close;
        end;

        exit(true);

    end;

    //[Scope('Internal')]
    procedure "<-- Stage 4 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncValidateLocalData(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecCorporateGLAccStaging: Record "Corporate G/L Acc (Staging)";
        lrecGLAccount: Record "G/L Account";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;

        // Delete old Error entries
        lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

        lrecCorporateGLAccStaging.SetCurrentKey("Import Log Entry No.");
        lrecCorporateGLAccStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        if lrecCorporateGLAccStaging.FindSet(false) then
            repeat
                // Specific checks here
                if not lrecGLAccount.Get(lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)") then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_003,
                                                   lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)",
                                                   lrecCorporateGLAccStaging."No.",
                                                   CompanyName));
                end;
            until lrecCorporateGLAccStaging.Next = 0;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 5 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactions(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecCorporateGLAccStaging: Record "Corporate G/L Acc (Staging)";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lrecFinancialStatementCode: Record "Financial Statement Code";
        lmdlFSCodeMgt: Codeunit "Fin. Stmt. Code Management";
        lcodOrgFSCode: Code[10];
    begin
        lrecCorporateGLAccStaging.SetCurrentKey("Import Log Entry No.");
        lrecCorporateGLAccStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if lrecCorporateGLAccStaging.FindSet(false) then
            repeat
                //
                // Create Corporate G/L account line
                //
                if not lrecCorporateGLAccount.Get(lrecCorporateGLAccStaging."No.") then lrecCorporateGLAccount.Init;
                lrecCorporateGLAccount."No." := lrecCorporateGLAccStaging."No.";
                lrecCorporateGLAccount.Name := lrecCorporateGLAccStaging.Name;
                lrecCorporateGLAccount."Income/Balance" := lrecCorporateGLAccStaging."Income/Balance";
                lrecCorporateGLAccount."Account Class" := lrecCorporateGLAccStaging."Accounting Class";
                lrecCorporateGLAccount."Name (English)" := lrecCorporateGLAccStaging."Name - ENU";
                lrecCorporateGLAccount."Local G/L Account No." := lrecCorporateGLAccStaging."Local Chart Of Acc (Mapped)";
                lcodOrgFSCode := lrecCorporateGLAccount."Financial Statement Code"; // MP 31-03-16
                lrecCorporateGLAccount."Financial Statement Code" := lrecCorporateGLAccStaging."Financial Statement Code";

                //
                // Default values
                //
                lrecCorporateGLAccount."Debit/Credit" := lrecCorporateGLAccount."Debit/Credit"::Both;
                lrecCorporateGLAccount."Account Type" := lrecCorporateGLAccount."Account Type"::Posting;
                //
                // Insert / update Corporate G/L account
                //
                if not lrecCorporateGLAccount.Insert(true) then lrecCorporateGLAccount.Modify(true);

                // FS Code
                if lrecCorporateGLAccount."Financial Statement Code" <> '' then begin
                    if not lrecFinancialStatementCode.Get(lrecCorporateGLAccount."Financial Statement Code") then begin
                        lrecFinancialStatementCode.Init;
                        lrecFinancialStatementCode.Code := lrecCorporateGLAccount."Financial Statement Code";
                        lrecFinancialStatementCode.Insert(true);
                    end;
                    if lrecCorporateGLAccStaging."FS Name" <> '' then // MP 30-04-14
                        lrecFinancialStatementCode.Description := lrecCorporateGLAccStaging."FS Name";
                    if lrecCorporateGLAccStaging."FS Name (English)" <> '' then // MP 30-04-14
                        lrecFinancialStatementCode."Description (English)" := lrecCorporateGLAccStaging."FS Name (English)";
                    lrecFinancialStatementCode.Modify(true);
                end;
                lmdlFSCodeMgt.gfcnUpdateCorpGLAccFSCodeAndHistory(lrecCorporateGLAccount, lcodOrgFSCode); // MP 31-03-16
            until lrecCorporateGLAccStaging.Next = 0;
        exit(true);
    end;

    //[Scope('Internal')]
    procedure "<-- Other -->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncArchive(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecStaging: Record "Corporate G/L Acc (Staging)";
        lrecProcessed: Record "Corporate G/L Acc (Processed)";
        ldlgDialog: Dialog;
        lintCount: Integer;
        lintCounter: Integer;
        lintLastPct: Integer;
    begin
        r_blnResult := true;
        if p_blnDialog then begin
            ldlgDialog.Open(DLG_003);
        end;
        //
        // Copy to destination table
        //
        lrecStaging.SetCurrentKey("Import Log Entry No.");
        lrecStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lintCount := lrecStaging.Count;
        lintCounter := 0;
        lintLastPct := 0;
        if lrecStaging.FindSet(false, false) then
            repeat
                lrecProcessed.Init;
                lrecProcessed.TransferFields(lrecStaging, true);
                lrecProcessed.Insert;
                if p_blnDialog then begin
                    lintCounter += 1;
                    if Round(lintCount / lintCounter * 100, 1, '<') > lintLastPct then begin
                        lintLastPct := Round(lintCount / lintCounter * 100, 1, '<');
                        ldlgDialog.Update(1, lintLastPct * 100);
                    end;
                end;
            until lrecStaging.Next = 0;

        //
        // Delete source records
        //
        lrecStaging.Reset;
        lrecStaging.SetCurrentKey("Import Log Entry No.");
        lrecStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lrecStaging.DeleteAll;

        if p_blnDialog then begin
            ldlgDialog.Close;
        end;
    end;
}

