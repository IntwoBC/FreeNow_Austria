codeunit 60009 "Data Import Mgt 60012"
{
    // This codeunit contains Staging table specific functionality
    // 
    // Specific to table 60012 "Gen. Journal Line (Staging)"
    // 
    // MP 23-05-12
    // Fixed issue in function gfncValidateLocalData, the routine returned the following error on all lines:
    // Rounding rules set for currency "" cause that amount x is rounded to 0
    // 
    // TEC 12-11-12 -mdan-
    //   New field's "Description (English)" maintenance
    // 
    // MP 09-07-13
    // Fixed issue where dates are transferred incorrectly, being one day off (Case 13850)
    // 
    // MP 19-11-13
    // Amended to allow importing local G/L Accounts, depending on Company Type (CR 30)
    // 
    // MP 30-04-14
    // Development taken from Core II
    // Fixed issue with Balance check, not taking into consideration line with "Bal. Account No." specified
    // 
    // MP 07-05-14
    // Fixed issue with routine not checking if Journal Batch Name already exists
    // Defaults "Tax Adjmt Reason" to P&L
    // 
    // MP 05-06-14
    // Amended functions gfncPostTransactionsPost and gfncPostTransactionsSimulate so they work with Bottom-up
    // 
    // MP 20-11-14
    // Upgraded to NAV 2013 R2


    trigger OnRun()
    begin
    end;

    var
        TXT_PAGE: Label 'Page';
        DLG_001: Label '#1################## \ Progress @2@@@@@@@@@@@@@@@@@@';
        DLG_002: Label 'Target #1########################\Activity #2########\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        DLG_003: Label 'Archiving records\@1@@@@@@@@@@@@@@@@@@';
        ERR_001: Label 'Document No. is missing in Staging Table: %1, entry No. %2';
        ERR_002: Label 'Total balance for company %1, date %2  currency "%3" is %4.';
        ERR_003: Label 'WS call error: %1';
        ERR_004: Label 'User %1 is not allowed post in date range %2 .. %3. Local company %4';
        ERR_005: Label 'Total balance must be 0. Current balance is %1  in company "%2".';
        ERR_006: Label 'Total balance must be 0. Current balance is %1. No of records %2  in company "%3".';
        ERR_007: Label 'Client Entry No. is missing in Staging Table: %1, entry No. %2';
        ERR_008: Label 'Client Entry No. %1 is already used in posted G/L Entry No. %2';
        ERR_009: Label 'Currency Factor  is missing in Staging Table: %1, entry No. %2';
        ERR_010: Label 'Rounding rules set for currency "%1" cause that amount %2 is rounded to %3';
        ERR_011: Label 'Export not yet implemented';
        ERR_012: Label 'Journal Line Error %1';
        ERR_013: Label 'Lines already exists in %1 %2';
        MSG_001: Label 'Validating imported records';
        MSG_002: Label 'Building Batch';
        MSG_003: Label 'Sending';
        MSG_004: Label 'Data exported to server located file %1';

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
    begin
        //
        // Table specific record initialization - default values depending on imported values
        // Called after record is saved
        //
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 2 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncValidateImportRec(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
        lrecGenJournalLine: Record "Gen. Journal Line";
        lrecCurrency: Record Currency;
        ldecRoundedAmount: Decimal;
        ldecBalance: Decimal;
        lintTotal: Integer;
        lintPosition: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
        ldatMinPostingDate: Date;
        ldatMaxPostingDate: Date;
        ldatCheckedDate: Date;
        lcodCheckedCompany: Code[20];
        lcodCheckedCurrency: Code[10];
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;
        lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.");
        lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        ldecBalance := 0;
        ldatMinPostingDate := 21001231D;
        ldatMaxPostingDate := 0D;
        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
            ldlgDialog.Update(1, MSG_001);
            lintTotal := lrecGenJournalLineStaging.Count;
            lintPosition := 0;
        end;

        //
        // Checks that can be done one by one
        //

        ldatCheckedDate := 0D;
        ldecBalance := 0;
        lcodCheckedCompany := '';
        lcodCheckedCurrency := '';
        lrecGenJournalLineStaging.Reset;
        lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.", "Company No.", "Posting Date", "Currency Code");
        lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lintLastPct := 0;
        if lrecGenJournalLineStaging.FindSet(false) then
            repeat
                if p_blnDialog then begin
                    lintPosition += 1;
                    if Round((lintPosition / lintTotal) * 100, 1, '<') > lintLastPct then begin
                        lintLastPct := Round((lintPosition / lintTotal) * 100, 1, '<');
                        ldlgDialog.Update(2, lintLastPct * 100);
                    end;
                end;

                //
                // Balance check, document No check
                //
                if p_recImportLog."Interface Type" in [p_recImportLog."Interface Type"::"Trial Balance",
                                                       p_recImportLog."Interface Type"::"GL Transactions",
                                                       p_recImportLog."Interface Type"::APTransactions,
                                                       p_recImportLog."Interface Type"::"AR Transactions"] then begin
                    if (lcodCheckedCompany <> lrecGenJournalLineStaging."Company No.") or
                       (lcodCheckedCurrency <> lrecGenJournalLineStaging."Currency Code") or
                       // Can add doc no balance check here
                       (ldatCheckedDate <> lrecGenJournalLineStaging."Posting Date") then begin
                        if ldecBalance <> 0 then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_002, lcodCheckedCompany, ldatCheckedDate, lcodCheckedCurrency, ldecBalance));
                        end;
                        // MP 30-04-14 >>
                        if lrecGenJournalLineStaging."Bal. Account No." <> '' then
                            ldecBalance := 0
                        else
                            // MP 30-04-14 <<
                            ldecBalance := lrecGenJournalLineStaging.Amount;
                        ldatCheckedDate := lrecGenJournalLineStaging."Posting Date";
                        lcodCheckedCompany := lrecGenJournalLineStaging."Company No.";
                        lcodCheckedCurrency := lrecGenJournalLineStaging."Currency Code";
                    end else begin
                        if lrecGenJournalLineStaging."Bal. Account No." = '' then // MP 30-04-14
                            ldecBalance += lrecGenJournalLineStaging.Amount;
                    end;

                    // Document No. Check
                    if lrecGenJournalLineStaging."Document No." = '' then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                           StrSubstNo(ERR_001, lrecGenJournalLineStaging.TableCaption, lrecGenJournalLineStaging."Entry No."));
                    end;

                    // Client entry No. check
                    if p_recImportLog."Interface Type" <> p_recImportLog."Interface Type"::"Trial Balance" then begin
                        if lrecGenJournalLineStaging."Client Entry No." = 0 then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                               StrSubstNo(ERR_007, lrecGenJournalLineStaging.TableCaption, lrecGenJournalLineStaging."Entry No."));
                        end;
                    end;
                    // Currency factor check
                    if lrecGenJournalLineStaging."Currency Code" <> '' then begin
                        if lrecGenJournalLineStaging."Currency Factor" <= 0 then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                               StrSubstNo(ERR_009, lrecGenJournalLineStaging.TableCaption, lrecGenJournalLineStaging."Entry No."));
                        end;
                    end;
                    // MinMax posting date
                    if lrecGenJournalLineStaging."Posting Date" > ldatMaxPostingDate then
                        ldatMaxPostingDate := lrecGenJournalLineStaging."Posting Date";
                    if lrecGenJournalLineStaging."Posting Date" < ldatMinPostingDate then
                        ldatMinPostingDate := lrecGenJournalLineStaging."Posting Date";
                    // Rounding check
                    // Get rounding precission
                    if lrecGenJournalLineStaging."Currency Code" <> '' then begin
                        if not lrecCurrency.Get(lrecGenJournalLineStaging."Currency Code") then
                            lrecCurrency."Amount Rounding Precision" := 0;
                    end else begin
                        Clear(lrecCurrency);
                        lrecCurrency.InitRoundingPrecision;
                    end;
                    if lrecCurrency."Amount Rounding Precision" > 0 then begin
                        ldecRoundedAmount := Round(lrecGenJournalLineStaging.Amount, lrecCurrency."Amount Rounding Precision");
                        if ldecRoundedAmount <> lrecGenJournalLineStaging.Amount then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                               StrSubstNo(ERR_010, lrecGenJournalLineStaging."Currency Code",
                                               lrecGenJournalLineStaging.Amount,
                                               ldecRoundedAmount));
                        end;
                    end;
                end;
            until lrecGenJournalLineStaging.Next = 0;

        // Last combination check
        if ldecBalance <> 0 then begin
            r_blnResult := false;
            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                               StrSubstNo(ERR_002, lcodCheckedCompany, ldatCheckedDate, lcodCheckedCurrency, ldecBalance));
        end;

        if p_blnDialog then begin
            ldlgDialog.Close;
        end;
    end;

    //[Scope('Internal')]
    procedure gfncCheckPostDateRange(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
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
        lmodDataImportSafeWScall.gfncSetAction(50);
        lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
        lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.", "Company No.", "Posting Date");
        lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        if lrecImportLogSubsidiaryClient.FindSet(false) then
            repeat
                // For each company find start date and end date
                ldatStartDate := 0D;
                ldatEndDate := 0D;
                lrecGenJournalLineStaging.SetRange("Company No.", lrecImportLogSubsidiaryClient."Company No.");
                if lrecGenJournalLineStaging.FindFirst then ldatStartDate := lrecGenJournalLineStaging."Posting Date";
                if lrecGenJournalLineStaging.FindLast then ldatEndDate := lrecGenJournalLineStaging."Posting Date";
                lmodDataImportSafeWScall.gfncSetStartEndDate(ldatStartDate, ldatEndDate);
                lmodDataImportSafeWScall.gfncSetSubsImportLog(lrecImportLogSubsidiaryClient);
                Commit;
                if lmodDataImportSafeWScall.Run() then begin
                    r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
                end else begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_003, GetLastErrorText));
                end;
            until lrecImportLogSubsidiaryClient.Next = 0;
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
                // For each company find start date and end date
                ldatStartDate := 0D;
                ldatEndDate := 0D;
                lrecGenJournalLineStaging.SetRange("Company No.", lrecImportLogSubsidiaryClient."Company No.");
                if lrecGenJournalLineStaging.FindFirst then ldatStartDate := lrecGenJournalLineStaging."Posting Date";
                if lrecGenJournalLineStaging.FindLast then ldatEndDate := lrecGenJournalLineStaging."Posting Date";
                lrecImportLogSubsidiaryClient."First Entry Date" := ldatStartDate;
                lrecImportLogSubsidiaryClient."Last Entry Date" := ldatEndDate;
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
        r_blnResult := true;
        if p_recImportLogSubsidiaryClient."VAT Reporting level" =
           p_recImportLogSubsidiaryClient."VAT Reporting level"::"Create One Source File" then begin
            case p_recImportLog."Interface Type" of
                //p_recImportLog."Interface Type"::"GL Transactions" :
                //  r_blnResult := gfncExportGL(p_recImportLog, p_recImportLogSubsidiaryClient, p_blnDialog);
                p_recImportLog."Interface Type"::APTransactions:
                    r_blnResult := gfncExportAP(p_recImportLog, p_recImportLogSubsidiaryClient, p_blnDialog);
                p_recImportLog."Interface Type"::"AR Transactions":
                    r_blnResult := gfncExportAR(p_recImportLog, p_recImportLogSubsidiaryClient, p_blnDialog);
            end;
        end;
    end;

    //[Scope('Internal')]
    procedure gfncExportGL(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        //
        // This will export G/L file
        //
        // Not used ?

        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, ERR_011);
        r_blnResult := true; // Just warn that something is missing
    end;

    //[Scope('Internal')]
    procedure gfncExportAP(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecGenJnlLineStaging: Record "Gen. Journal Line (Staging)";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        lfilFile: File;
        lostFile: OutStream;
        ltxtFileName: Text[1024];
        ltxtLine: Text[1024];
    begin
        //
        // This will export the AP file
        //

        r_blnResult := lmodDataImportManagementCommon.gfncCreateServerFile(lfilFile, p_recImportLog, p_recImportLogSubsidiaryClient, 'txt');
        //ltxtFileName := lfilFile.Name;

        // MP 02-04-12 Replaced by XMLport >>

        // Header line
        //ltxtLine := 'MREF,NAME & ADDRESS,CUSTOMER VAT /COMMUNITY REGISTRATION NUMBER,INVREF,INVDATE,DATE OF SUPPLY,' +
        //            'PAYMENT DUE DATE,VAT %,NET,VAT,GROSS,CURRENCY,EXCHANGE RATE,TAX POINT,Type of Transaction,' +
        //            'SPECIFIC REGIME APPLICABILITY,DESC,TAXCODE,POSTDATE,RECTDATE,RECTAMOUNT,RECTIMEHOD,TREF,GL,' +
        //            'SPECIAL INSTRUCTIONS,BAD DEBT WRITTEN OFF,COUNTRY OF DESTINATION,COUNTRY OF ORIGIN,COUNTRY OF DISPATCH,' +
        //            'SIMPLIFIED TRIANGUL (A-B-C),HS CODE (8 digits),INVOICED AMOUNT,STATISTICAL VALUE,QUANTITY,' +
        //            'SUPLEMENTRAY UNITS,AMOUNT INVOICED PER SUPPLY OF COMMODITY CODE,NET WEIGHT,NATURE OF TRANSACTIONS,' +
        //            'TRANSACTION CODE,MEANS OF TRANSPORT,PROVINCE CODE,PORT/PLACE OF DISPATCH,CODE OF STATISTICAL CONDITION,' +
        //            'INCOTERMS/DELIVERY TERMS,REGION,DATE EXCHANGE RATE,ANNOUNCEMENT 38 DECLARATION (Y/N/NA)';
        //lfilFile.WRITE(ltxtLine);

        lrecGenJnlLineStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecGenJnlLineStaging.SetRange("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
        lrecGenJnlLineStaging.SetRange("Company No.", p_recImportLogSubsidiaryClient."Company No.");

        //lfilFile.CreateOutStream(lostFile);
        XMLPORT.Export(XMLPORT::"AP Transactions - OneSource", lostFile, lrecGenJnlLineStaging);

        // MP 02-04-12 <<

        //lfilFile.Close;
        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(MSG_004, ltxtFileName));

        r_blnResult := true;
    end;

    //[Scope('Internal')]
    procedure gfncExportAR(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecGenJnlLineStaging: Record "Gen. Journal Line (Staging)";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        lfilFile: File;
        lostFile: OutStream;
        ltxtFileName: Text[1024];
    begin
        //
        // This will export the AR file
        //

        // MP 02-04-12 >>

        r_blnResult := lmodDataImportManagementCommon.gfncCreateServerFile(lfilFile, p_recImportLog, p_recImportLogSubsidiaryClient, 'txt');
        //ltxtFileName := lfilFile.Name;

        lrecGenJnlLineStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecGenJnlLineStaging.SetRange("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
        lrecGenJnlLineStaging.SetRange("Company No.", p_recImportLogSubsidiaryClient."Company No.");

        //lfilFile.CreateOutStream(lostFile);
        XMLPORT.Export(XMLPORT::"AR Transactions - OneSource", lostFile, lrecGenJnlLineStaging);

        //lfilFile.Close;
        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(MSG_004, ltxtFileName));

        // MP 02-04-12 <<
    end;

    //[Scope('Internal')]
    procedure gfncGetActionNoCopyData(): Integer
    begin
        //
        // Returns Action Number which represents copy data
        // as per definiton in CU 60008 Data Import Safe WS call
        //
        exit(1);
    end;

    //[Scope('Internal')]
    procedure gfncCopyClient(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        /* ldotGenJnlLineStg: DotNet GenJnlLineStg;
         ldotGenJnlLineStg_Service: DotNet GenJnlLineStg_Service;
         ldotArray: DotNet Array;
         ldotDateTime: DotNet DateTime;*/
        lintBatchSize: Integer;
        lintArrayPosition: Integer;
        lintArrayLength: Integer;
        lintRemainingRecords: Integer;
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lblnNoMoreRecords: Boolean;
        ltxtURL: Text[1024];
        ltxtErr: Text[1024];
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldlgDialog: Dialog;
        lintRecordCount: Integer;
        lintCounter: Integer;
        lintLastPct: Integer;
    begin
        r_blnResult := true;

        //
        // identify cases when we need to copy
        //
        if (p_recImportLogSubsidiaryClient."Interface Type" = p_recImportLogSubsidiaryClient."Interface Type"::"Trial Balance") or
           (p_recImportLogSubsidiaryClient."Interface Type" = p_recImportLogSubsidiaryClient."Interface Type"::"GL Transactions") or
           (p_recImportLogSubsidiaryClient."VAT Reporting level" = p_recImportLogSubsidiaryClient."VAT Reporting level"::"Process In NAV")
           then begin

            //
            // Copy data to specific client using webservice
            //
            /*
            IF p_blnDialog THEN BEGIN
              ldlgDialog.OPEN(DLG_002);
              ldlgDialog.UPDATE(1, p_recImportLogSubsidiaryClient."Company Name");
            END;
            ldotGenJnlLineStg_Service := ldotGenJnlLineStg_Service.GenJnlLineStg_Service(); // Constructor
            ldotGenJnlLineStg_Service.UseDefaultCredentials(TRUE); // will work only within the same domain

            IF NOT lmodDataImportManagementCommon.gfncBuildURL(p_recImportLogSubsidiaryClient,
                                                               TXT_PAGE,
                                                               lmodDataImportManagementCommon.gfncGetGenJnlStagPageWSName(),
                                                               ltxtURL, ltxtErr)
              THEN BEGIN
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0, ltxtErr);
                EXIT(FALSE);
              END;
            ldotGenJnlLineStg_Service.Url := ltxtURL;
            //ToDo Move to setup
            lintBatchSize := 500; // Initial batch size Should be in setup!
            lblnNoMoreRecords := FALSE;

            lrecGenJournalLineStaging.SETCURRENTKEY("Import Log Entry No.", "Company No.");
            lrecGenJournalLineStaging.SETRANGE("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
            lrecGenJournalLineStaging.SETRANGE("Company No.", p_recImportLogSubsidiaryClient."Company No.");
            lintRemainingRecords := lrecGenJournalLineStaging.COUNT;
            lintArrayPosition := 0;
            ldotGenJnlLineStg := ldotGenJnlLineStg.GenJnlLineStg();

            IF p_blnDialog THEN BEGIN
              lintRecordCount := lrecGenJournalLineStaging.COUNT;
              lintCounter := 0;
            END;

            IF lrecGenJournalLineStaging.FINDSET(FALSE) THEN BEGIN
              REPEAT
                // Build array up to the batch size
                IF p_blnDialog THEN BEGIN
                  ldlgDialog.UPDATE(2, MSG_002);
                END;

                IF lintRemainingRecords > lintBatchSize THEN lintArrayLength := lintBatchSize
                                                        ELSE lintArrayLength := lintRemainingRecords;
                IF NOT ISNULL(ldotArray) THEN CLEAR(ldotArray);
                ldotArray := ldotArray.CreateInstance(ldotGenJnlLineStg.GetType(), lintArrayLength);
                lintLastPct := 0;
                REPEAT
                  IF p_blnDialog THEN BEGIN
                    lintCounter += 1;
                    IF ROUND((lintCounter/lintRecordCount)*100,1,'<') > lintLastPct THEN BEGIN
                      lintLastPct :=  ROUND((lintCounter/lintRecordCount)*100,1,'<');
                      ldlgDialog.UPDATE(3, lintLastPct * 100);
                    END;
                  END;
                  IF NOT ISNULL(ldotGenJnlLineStg) THEN CLEAR(ldotGenJnlLineStg);
                  ldotGenJnlLineStg:= ldotGenJnlLineStg.GenJnlLineStg(); // Constructor
                  // Build record
                  ldotGenJnlLineStg.Account_Type                 := lrecGenJournalLineStaging."Account Type";
                  ldotGenJnlLineStg.Account_TypeSpecified        := TRUE;
                  ldotGenJnlLineStg.Account_No                   := lrecGenJournalLineStaging."Account No.";
                  // MP 09-07-13 >>
                  //ldotGenJnlLineStg.Posting_Date                 := CREATEDATETIME(lrecGenJournalLineStaging."Posting Date",0T);
                  //ldotGenJnlLineStg.Posting_DateSpecified        := TRUE;
                  IF lrecGenJournalLineStaging."Posting Date" <> 0D THEN BEGIN
                    //ldotGenJnlLineStg.Posting_Date               := ldotDateTime.DateTime(
                    ldotDateTime                                 := ldotDateTime.DateTime( // MP 20-11-14 Replaces above line
                                                                        DATE2DMY(lrecGenJournalLineStaging."Posting Date",3),
                                                                        DATE2DMY(lrecGenJournalLineStaging."Posting Date",2),
                                                                        DATE2DMY(lrecGenJournalLineStaging."Posting Date",1));
                    ldotGenJnlLineStg.Posting_Date               := ldotDateTime.Date; // MP 20-11-14
                    ldotGenJnlLineStg.Posting_DateSpecified      := TRUE;
                  END;
                  // MP 09-07-13 <<
                  ldotGenJnlLineStg.Document_Type                := lrecGenJournalLineStaging."Document Type";
                  ldotGenJnlLineStg.Document_TypeSpecified       := TRUE;
                  ldotGenJnlLineStg.Document_No                  := lrecGenJournalLineStaging."Document No.";
                  ldotGenJnlLineStg.Description                  := lrecGenJournalLineStaging.Description;
                  ldotGenJnlLineStg.VAT_Percent                  := lrecGenJournalLineStaging."VAT %";
                  ldotGenJnlLineStg.VAT_PercentSpecified         := TRUE;
                  ldotGenJnlLineStg.Bal_Account_No               := lrecGenJournalLineStaging."Bal. Account No.";
                  ldotGenJnlLineStg.Currency_Code                := lrecGenJournalLineStaging."Currency Code";
                  ldotGenJnlLineStg.Amount                       := lrecGenJournalLineStaging.Amount;
                  ldotGenJnlLineStg.AmountSpecified              := TRUE;
                  ldotGenJnlLineStg.Currency_Factor              := lrecGenJournalLineStaging."Currency Factor";
                  ldotGenJnlLineStg.Currency_FactorSpecified     := TRUE;
                  // MP 09-07-13 >>
                  //ldotGenJnlLineStg.Document_Date                := CREATEDATETIME(lrecGenJournalLineStaging."Document Date", 0T);
                  //ldotGenJnlLineStg.Document_DateSpecified       := TRUE;
                  IF lrecGenJournalLineStaging."Document Date" <> 0D THEN BEGIN
                    //ldotGenJnlLineStg.Document_Date              := ldotDateTime.DateTime(
                    ldotDateTime                                   := ldotDateTime.DateTime(// MP 20-11-14 Replaces above line
                                                                        DATE2DMY(lrecGenJournalLineStaging."Document Date",3),
                                                                        DATE2DMY(lrecGenJournalLineStaging."Document Date",2),
                                                                        DATE2DMY(lrecGenJournalLineStaging."Document Date",1));
                    ldotGenJnlLineStg.Document_Date              := ldotDateTime.Date; // MP 20-11-14
                    ldotGenJnlLineStg.Document_DateSpecified     := TRUE;
                  END;
                  // MP 09-07-13 <<
                  ldotGenJnlLineStg.External_Document_No         := lrecGenJournalLineStaging."External Document No.";
                  ldotGenJnlLineStg.VAT_Code                     := lrecGenJournalLineStaging."VAT Code";
                  ldotGenJnlLineStg.Interface_Type               := lrecGenJournalLineStaging."Interface Type";
                  ldotGenJnlLineStg.Interface_TypeSpecified      := TRUE;
                  ldotGenJnlLineStg.Debit_Credit_Indicator       := lrecGenJournalLineStaging."Debit/Credit Indicator";
                  ldotGenJnlLineStg.Additional_Curr_Amnt         := lrecGenJournalLineStaging."Additional Curr Amnt";
                  ldotGenJnlLineStg.Additional_Curr_AmntSpecified := TRUE;
                  ldotGenJnlLineStg.Company_No                   := lrecGenJournalLineStaging."Company No.";
                  ldotGenJnlLineStg.Client_No                    := lrecGenJournalLineStaging."Client No.";
                  ldotGenJnlLineStg.User_ID                      := lrecGenJournalLineStaging."User ID";
                  ldotGenJnlLineStg.Status                       := lrecGenJournalLineStaging.Status;
                  ldotGenJnlLineStg.StatusSpecified              := TRUE;
                  ldotGenJnlLineStg.Import_Log_Entry_No          := lrecGenJournalLineStaging."Import Log Entry No.";
                  ldotGenJnlLineStg.Import_Log_Entry_NoSpecified := TRUE;
                  ldotGenJnlLineStg.GAAP_Adjmt_Reason            := lrecGenJournalLineStaging."GAAP Adjmt Reason";
                  ldotGenJnlLineStg.GAAP_Adjmt_ReasonSpecified   := TRUE;
                  ldotGenJnlLineStg.Adjustment_Role              := lrecGenJournalLineStaging."Adjustment Role";
                  ldotGenJnlLineStg.Adjustment_RoleSpecified     := TRUE;
                  ldotGenJnlLineStg.Tax_Adjmt_Reason             := lrecGenJournalLineStaging."Tax Adjmt Reason";
                  ldotGenJnlLineStg.Tax_Adjmt_ReasonSpecified    := TRUE;
                  ldotGenJnlLineStg.Equity_Corr_Code             := lrecGenJournalLineStaging."Equity Corr Code";
                  ldotGenJnlLineStg.Shortcut_Dim_1_Code          := lrecGenJournalLineStaging."Shortcut Dim 1 Code";
                  ldotGenJnlLineStg.Client_Entry_No              := lrecGenJournalLineStaging."Client Entry No.";
                  ldotGenJnlLineStg.Client_Entry_NoSpecified     := TRUE;
                  //TEC 12-11-12 -mdan-
                  ldotGenJnlLineStg.Description_English          := lrecGenJournalLineStaging."Description (English)";


                  // Add to array
                  ldotArray.SetValue(ldotGenJnlLineStg, lintArrayPosition);
                  lintArrayPosition += 1;
                  lblnNoMoreRecords := (lrecGenJournalLineStaging.NEXT = 0);
                  lintRemainingRecords -= 1;
                UNTIL ((lintArrayPosition = (lintBatchSize-1)) OR lblnNoMoreRecords);
                lintArrayPosition := 0;
                IF p_blnDialog THEN BEGIN
                  ldlgDialog.UPDATE(2, MSG_003);
                END;
                // and send it
                ldotGenJnlLineStg_Service.CreateMultiple(ldotArray);
              UNTIL lblnNoMoreRecords;
            END;

            IF p_blnDialog THEN BEGIN
              ldlgDialog.CLOSE;
            END;*/
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
        ldatStartDate: Date;
        ldatEndDate: Date;
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lrecTmpGenJournalLine: Record "Gen. Journal Line" temporary;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        lmodDataImportSafeProcess: Codeunit "Data Import Safe Process";
        ldecTotalBalance: Decimal;
        lrecTmpUsedAccounts: Record "Used Accounts" temporary;
        lrecGLEntry: Record "G/L Entry";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
    begin
        //
        // Stage 4 local validation
        //
        r_blnResult := true;

        // Only for Trial Balance and GL Entries
        if (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance") or
           (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"GL Transactions") then begin
            // Delete old Error entries
            lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);
            // Get Min/Max date
            ldatStartDate := 21001231D;
            ldatEndDate := 0D;
            ldecTotalBalance := 0;
            lrecGLEntry.SetCurrentKey("Client Entry No.");
            lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.");
            lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecGenJournalLineStaging.FindSet(false) then
                repeat
                    // Find start end date
                    if lrecGenJournalLineStaging."Posting Date" < ldatStartDate then
                        ldatStartDate := lrecGenJournalLineStaging."Posting Date";
                    if lrecGenJournalLineStaging."Posting Date" > ldatEndDate then
                        ldatEndDate := lrecGenJournalLineStaging."Posting Date";
                    // Balance
                    if lrecGenJournalLineStaging."Bal. Account No." = '' then // MP 30-04-14
                        ldecTotalBalance += lrecGenJournalLineStaging.Amount;
                    //
                    // Make list of unique account numbers G/L, Cust, Vendor
                    //
                    lrecTmpUsedAccounts.Type := lrecGenJournalLineStaging."Account Type";
                    lrecTmpUsedAccounts.No := lrecGenJournalLineStaging."Account No.";
                    if lrecTmpUsedAccounts.Type = lrecTmpUsedAccounts.Type::"G/L Account" then
                        // MP 19-11-13 >>
                        if lfcnIsBottomUp then
                            lrecTmpUsedAccounts.Corporate := false
                        else
                            // MP 19-11-13 <<
                            lrecTmpUsedAccounts.Corporate := true;
                    if not lrecTmpUsedAccounts.Insert then;
                    // Check VAT groups ?

                    // Check client entry No
                    if lrecGenJournalLineStaging."Client Entry No." <> 0 then begin
                        lrecGLEntry.SetRange("Client Entry No.", lrecGenJournalLineStaging."Client Entry No.");
                        if lrecGLEntry.FindFirst then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                           StrSubstNo(ERR_008, lrecGenJournalLineStaging."Client Entry No.",
                                                                               lrecGLEntry."Entry No."));
                        end;
                    end;
                    //
                    // Is there difference between Amount and Gen Journal line amount
                    // due to NAV rounding rules
                    //

                    //
                    // Create Tmp journal line
                    //
                    // TEC 20-04-12 -mdan- >> moved to function gfncCreateJournalLine
                    //lrecTmpGenJournalLine.INIT;
                    //lrecTmpGenJournalLine.VALIDATE("Posting Date", lrecGenJournalLineStaging."Posting Date");
                    //lrecTmpGenJournalLine.VALIDATE("Account Type", lrecGenJournalLineStaging."Account Type");
                    //IF lrecGenJournalLineStaging."Account Type" = lrecGenJournalLineStaging."Account Type"::"G/L Account" THEN BEGIN
                    //  lrecCorporateGLAccount.GET(lrecGenJournalLineStaging."Account No.");
                    //  lrecTmpGenJournalLine.VALIDATE("Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                    //  lrecTmpGenJournalLine.VALIDATE("Corporate G/L Account No.", lrecGenJournalLineStaging."Account No.");
                    //END ELSE BEGIN
                    //  lrecTmpGenJournalLine.VALIDATE("Account No.", lrecGenJournalLineStaging."Account No.");
                    //END;
                    //IF lrecGenJournalLineStaging."Currency Code" <> '' THEN BEGIN
                    //  lrecTmpGenJournalLine.VALIDATE("Currency Code", lrecGenJournalLineStaging."Currency Code");
                    //  lrecTmpGenJournalLine.VALIDATE("Currency Factor", lrecGenJournalLineStaging."Currency Factor");
                    //END;
                    //lrecTmpGenJournalLine.VALIDATE(Amount, lrecGenJournalLineStaging.Amount);
                    // TEC 20-04-12 -mdan- << moved to function gfncCreateJournalLine

                    // TEC 20-04-12 -mdan- >> Safe call
                    lmodDataImportSafeProcess.gfncSetGenJnlLine(lrecTmpGenJournalLine);
                    lmodDataImportSafeProcess.gfncSetGenJnlLineStaging(lrecGenJournalLineStaging);
                    lmodDataImportSafeProcess.gfncSetAction(1);
                    Commit;
                    if not lmodDataImportSafeProcess.Run() then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                                       StrSubstNo(ERR_012, GetLastErrorText));
                    end else begin
                        // TEC 20-04-12 -mdan- << Safe call
                        // And compare amounts - only if line was created
                        lmodDataImportSafeProcess.gfncGetGenJnlLine(lrecTmpGenJournalLine); // MP 23-05-12 Added line
                        if lrecGenJournalLineStaging.Amount <> lrecTmpGenJournalLine.Amount then begin
                            r_blnResult := false;
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, lrecGenJournalLineStaging."Entry No.",
                                                           StrSubstNo(ERR_010, lrecGenJournalLineStaging."Currency Code",
                                                           lrecGenJournalLineStaging.Amount,
                                                           lrecTmpGenJournalLine.Amount));
                        end;
                    end;
                until lrecGenJournalLineStaging.Next = 0;

            //
            // Check accounts
            //
            if lrecTmpUsedAccounts.FindSet(false) then
                repeat
                    r_blnResult := r_blnResult and lmodDataImportManagementCommon.gfncCheckAccount(p_recImportLog, lrecTmpUsedAccounts.Type,
                                                                                                   lrecTmpUsedAccounts.No,
                                                                                                   lrecTmpUsedAccounts.Corporate);
                until lrecTmpUsedAccounts.Next = 0;

            // Check total balance

            if ldecTotalBalance <> 0 then begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_005, Format(ldecTotalBalance), CompanyName));
            end;

            // Check user's posting range
            if not lmodDataImportManagementCommon.gfncUserPostingRangeValid(ldatStartDate, ldatEndDate, UserId) then begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_004, UserId, ldatStartDate, ldatEndDate,
                                               CompanyName));
            end;
        end;
    end;

    //[Scope('Internal')]
    procedure gfncCreateJournalLine(var p_recGenJournalLine: Record "Gen. Journal Line"; p_recGenJournalLineStaging: Record "Gen. Journal Line (Staging)") r_blnResult: Boolean
    var
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        //
        // Create journal line
        //
        // Intention is to call this from separate codeunit to prevent crash on VALIDATE
        //
        p_recGenJournalLine.Init;
        p_recGenJournalLine.Validate("Posting Date", p_recGenJournalLineStaging."Posting Date");
        p_recGenJournalLine.Validate("Account Type", p_recGenJournalLineStaging."Account Type");
        if p_recGenJournalLineStaging."Account Type" = p_recGenJournalLineStaging."Account Type"::"G/L Account" then begin
            // MP 19-11-13 >>
            if lfcnIsBottomUp then begin
                lrecGLAcc.Get(p_recGenJournalLineStaging."Account No.");
                p_recGenJournalLine.Validate("Account No.", p_recGenJournalLineStaging."Account No.");
                p_recGenJournalLine.Validate("Corporate G/L Account No.", lrecGLAcc."Corporate G/L Account No.");
            end else begin
                // MP 19-11-13 <<
                lrecCorporateGLAccount.Get(p_recGenJournalLineStaging."Account No.");
                p_recGenJournalLine.Validate("Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                p_recGenJournalLine.Validate("Corporate G/L Account No.", p_recGenJournalLineStaging."Account No.");
            end; // MP 19-11-13
        end else begin
            p_recGenJournalLine.Validate("Account No.", p_recGenJournalLineStaging."Account No.");
        end;
        if p_recGenJournalLineStaging."Currency Code" <> '' then begin
            p_recGenJournalLine.Validate("Currency Code", p_recGenJournalLineStaging."Currency Code");
            p_recGenJournalLine.Validate("Currency Factor", p_recGenJournalLineStaging."Currency Factor");
        end;
        p_recGenJournalLine.Validate(Amount, p_recGenJournalLineStaging.Amount);
        // MP 20-11-14 >>
        if p_recGenJournalLine.Amount = 0 then
            p_recGenJournalLine.Validate("Allow Zero-Amount Posting", true);
        // MP 20-11-14 <<
        r_blnResult := true;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 5 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactions(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecParentClient: Record "Parent Client";
    begin
        case p_recImportLog."Posting Method" of
            p_recImportLog."Posting Method"::Post:
                exit(gfncPostTransactionsPost(p_recImportLog, p_blnDialog));
            p_recImportLog."Posting Method"::Simulate:
                exit(gfncPostTransactionsSimulate(p_recImportLog, p_blnDialog));
        end;
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactionsPost(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lrecGenJournalLine: Record "Gen. Journal Line";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lrecSourceCodeSetup: Record "Source Code Setup";
        lrecParentClient: Record "Parent Client";
        lrecGLAcc: Record "G/L Account";
        lmodGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        lmodReverseGLEntries: Codeunit "Reverse G/L Entries";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldecAmount: Decimal;
        lintNoRecords: Integer;
    begin
        // Only for Trial Balance and GL Entries
        if (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance") or
           (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"GL Transactions") then begin

            //
            // G/L Detail level (replacing TB to TB)
            //
            if (p_recImportLog."G/L Detail level" = p_recImportLog."G/L Detail level"::"Trial Balance") and
               (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance") then begin
                lmodReverseGLEntries.gfcnReverse();
            end;

            // Delete old Error entries
            lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

            ldecAmount := 0;
            lintNoRecords := 0;
            lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.");
            lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecGenJournalLineStaging.FindSet(false) then
                repeat
                    //
                    // Create journal line
                    //
                    lrecGenJournalLine.Init;
                    lrecGenJournalLine.Validate("Posting Date", lrecGenJournalLineStaging."Posting Date");
                    //lrecGenJournalLine.VALIDATE("Document Type", lrecGenJournalLineStaging."Document Type");
                    lrecGenJournalLine.Validate("Document Type", lrecGenJournalLineStaging."Document Type"::" ");
                    lrecGenJournalLine.Validate("Document No.", lrecGenJournalLineStaging."Document No.");
                    lrecGenJournalLine.Validate("Account Type", lrecGenJournalLineStaging."Account Type");
                    if lrecGenJournalLineStaging."Account Type" = lrecGenJournalLineStaging."Account Type"::"G/L Account" then begin
                        // MP 19-11-13 >>
                        if lfcnIsBottomUp then begin
                            lrecGLAcc.Get(lrecGenJournalLineStaging."Account No.");
                            //lrecGenJournalLine.VALIDATE("Account No.",lrecGenJournalLineStaging."Account No."); // MP 05-06-14 Moved down
                            lrecGenJournalLine.Validate("Corporate G/L Account No.", lrecGLAcc."Corporate G/L Account No.");
                            lrecGenJournalLine.Validate("Account No.", lrecGenJournalLineStaging."Account No."); // MP 05-06-14 Moved from above
                                                                                                                 // MP 30-04-14 >>
                            if lrecGenJournalLineStaging."Bal. Account No." <> '' then begin
                                lrecGLAcc.Get(lrecGenJournalLineStaging."Bal. Account No.");
                                //lrecGenJournalLine.VALIDATE("Bal. Account No.",lrecGenJournalLineStaging."Bal. Account No."); // MP 05-06-14 Moved down
                                lrecGenJournalLine.Validate("Bal. Corporate G/L Account No.", lrecGLAcc."Corporate G/L Account No.");
                                lrecGenJournalLine.Validate("Bal. Account No.", lrecGenJournalLineStaging."Bal. Account No."); // MP 05-06-14 Moved
                            end;
                            // MP 30-04-14 <<
                        end else begin
                            // MP 19-11-13 <<
                            lrecCorporateGLAccount.Get(lrecGenJournalLineStaging."Account No.");
                            lrecGenJournalLine.Validate("Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                            lrecGenJournalLine.Validate("Corporate G/L Account No.", lrecGenJournalLineStaging."Account No.");
                            // MP 30-04-14 >>
                            if lrecGenJournalLineStaging."Bal. Account No." <> '' then begin
                                lrecCorporateGLAccount.Get(lrecGenJournalLineStaging."Bal. Account No.");
                                lrecGenJournalLine.Validate("Bal. Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                                lrecGenJournalLine.Validate("Bal. Corporate G/L Account No.", lrecGenJournalLineStaging."Bal. Account No.");
                            end;
                            // MP 30-04-14 <<
                        end; // MP 19-11-13
                    end else begin
                        lrecGenJournalLine.Validate("Account No.", lrecGenJournalLineStaging."Account No.");
                        // MP 30-04-14 >>
                        if lrecGenJournalLineStaging."Bal. Account No." <> '' then
                            lrecGenJournalLine.Validate("Bal. Account No.", lrecGenJournalLineStaging."Bal. Account No.");
                        // MP 30-04-14 <<
                    end;
                    lrecGenJournalLine.Validate(Description, lrecGenJournalLineStaging.Description);
                    // Handle foreign currency
                    if lrecGenJournalLineStaging."Currency Code" <> '' then begin
                        lrecGenJournalLine.Validate("Currency Code", lrecGenJournalLineStaging."Currency Code");
                        lrecGenJournalLine.Validate("Currency Factor", lrecGenJournalLineStaging."Currency Factor");
                    end;
                    lrecGenJournalLine.Validate(Amount, lrecGenJournalLineStaging.Amount);
                    // MP 20-11-14 >>
                    if lrecGenJournalLine.Amount = 0 then
                        lrecGenJournalLine.Validate("Allow Zero-Amount Posting", true);
                    // MP 20-11-14 <<
                    lrecSourceCodeSetup.Get;
                    lrecGenJournalLine."Journal Batch Name" := lrecSourceCodeSetup."Import Tool";
                    lrecGenJournalLine."Source Code" := lrecSourceCodeSetup."Import Tool";
                    //lrecGenJournalLine."Journal Batch Name" := 'IMPTOOL';
                    //lrecGenJournalLine."Source Code" := 'IMPTOOL';
                    // MP 07-05-14 >>
                    //lrecGenJournalLine."GAAP Adjustment Reason" := lrecGenJournalLineStaging."GAAP Adjmt Reason";
                    lrecGenJournalLine.Validate("GAAP Adjustment Reason", lrecGenJournalLineStaging."GAAP Adjmt Reason");
                    lrecGenJournalLine."Adjustment Role" := lrecGenJournalLineStaging."Adjustment Role";
                    if lrecGenJournalLineStaging."Tax Adjmt Reason" = lrecGenJournalLineStaging."Tax Adjmt Reason"::" " then begin
                        if lrecGenJournalLineStaging."Shortcut Dim 1 Code" <> '' then
                            lrecGenJournalLine."Tax Adjustment Reason" := lrecGenJournalLine."Tax Adjustment Reason"::"P&L";
                    end else
                        // MP 07-05-14 <<
                        lrecGenJournalLine."Tax Adjustment Reason" := lrecGenJournalLineStaging."Tax Adjmt Reason";
                    lrecGenJournalLine."Equity Correction Code" := lrecGenJournalLineStaging."Equity Corr Code";
                    lrecGenJournalLine."Client Entry No." := lrecGenJournalLineStaging."Client Entry No.";
                    lrecGenJournalLine."Shortcut Dimension 1 Code" := lrecGenJournalLineStaging."Shortcut Dim 1 Code";
                    // MP 20-11-14 >>
                    if lrecGenJournalLine."Shortcut Dimension 1 Code" <> '' then
                        lrecGenJournalLine.Validate("Shortcut Dimension 1 Code");
                    // MP 20-11-14 <<
                    lrecGenJournalLine."Description (English)" := lrecGenJournalLineStaging."Description (English)";
                    // Handle VAT - assuming that only relevant lines will have VAT % populated
                    if lrecGenJournalLineStaging."VAT %" <> 0 then begin
                        // Store VAT%, VAT amount to temp table
                        // Later "post" these entries - to create VAT
                        //**
                    end;
                    // Handle AP, AR transaction - depending on EY setup G/L entries will not be posted
                    if p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::APTransactions then
                        lrecGenJournalLine."Interface Type" := lrecGenJournalLine."Interface Type"::"AP Transactions";
                    if p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"AR Transactions" then
                        lrecGenJournalLine."Interface Type" := lrecGenJournalLine."Interface Type"::"AR Transactions";
                    //lrecParentClient.GET(p_recImportLog."Parent Client No.");
                    //lrecGenJournalLine."Posting Scenario" := lrecParentClient."Posting Scenario";
                    //lrecGenJournalLine."A/R Trans Posting Scenario" := lrecParentClient."A/R Trans Posting Scenario";
                    //lrecGenJournalLine."A/P Trans Posting Scenario" := lrecParentClient."A/P Trans Posting Scenario";
                    lrecGenJournalLine."A/R Trans Posting Scenario" := p_recImportLog."A/R Trans Posting Scenario";
                    lrecGenJournalLine."A/P Trans Posting Scenario" := p_recImportLog."A/P Trans Posting Scenario";

                    if lrecGenJournalLine."Bal. Account No." = '' then // 30-04-14
                        ldecAmount += lrecGenJournalLine.Amount;
                    lintNoRecords += 1;
                    //
                    //post journal line
                    //
                    lmodGenJnlPostLine.Run(lrecGenJournalLine);
                until lrecGenJournalLineStaging.Next = 0;
            if ldecAmount <> 0 then begin
                Error(ERR_005, ldecAmount, lintNoRecords, CompanyName);
            end;
        end;
        exit(true);
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactionsSimulate(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecTmpGenJournalLine: Record "Gen. Journal Line" temporary;
        lrecGenJournalLineStaging: Record "Gen. Journal Line (Staging)";
        lrecGenJournalLine: Record "Gen. Journal Line";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lrecSourceCodeSetup: Record "Source Code Setup";
        lrecParentClient: Record "Parent Client";
        lrecGLAcc: Record "G/L Account";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldecAmount: Decimal;
        lintNoRecords: Integer;
        lcodJournalBatchName: Code[10];
        ltxtText: Text[1024];
    begin
        // Only for Trial Balance and GL Entries
        if (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance") or
           (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"GL Transactions") then begin

            //Clear global temp record, used to store default values for various Journal types
            // Normal, TAX, GAAP
            lrecTmpGenJournalLine.DeleteAll;

            // Delete old Error entries
            lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

            // Build Journal batch name for example "AR00000123" or "AP00001234" or "TR00000032" "GL00000001"
            ltxtText := '00000000' + Format(p_recImportLog."Entry No.");
            ltxtText := CopyStr(ltxtText, StrLen(ltxtText) - 7);
            lcodJournalBatchName := CopyStr(Format(p_recImportLog."Interface Type"), 1, 2) + ltxtText;

            ldecAmount := 0;
            lintNoRecords := 0;
            lrecGenJournalLineStaging.SetCurrentKey("Import Log Entry No.");
            lrecGenJournalLineStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecGenJournalLineStaging.FindSet(false) then
                repeat
                    //
                    // Create journal line
                    //
                    lfncInitGenJournalLine(lrecTmpGenJournalLine,       // each record represents batch type created
                                          lrecGenJournalLine,           // Line to be initialized
                                          p_recImportLog,               // Used to determine TB to TB
                                          lcodJournalBatchName,         // Batch name (used if new batch has to be created
                                          lrecGenJournalLineStaging."Shortcut Dim 1 Code");  // determines type of Batch
                    lrecGenJournalLine.Insert;
                    lrecGenJournalLine.Validate("Posting Date", lrecGenJournalLineStaging."Posting Date");
                    lrecGenJournalLine.Validate("Document Type", lrecGenJournalLineStaging."Document Type"::" ");
                    lrecGenJournalLine.Validate("Document No.", lrecGenJournalLineStaging."Document No.");
                    lrecGenJournalLine.Validate("Account Type", lrecGenJournalLineStaging."Account Type");
                    if lrecGenJournalLineStaging."Account Type" = lrecGenJournalLineStaging."Account Type"::"G/L Account" then begin
                        // MP 05-06-14 >>
                        if lfcnIsBottomUp then begin
                            lrecGLAcc.Get(lrecGenJournalLineStaging."Account No.");
                            lrecGenJournalLine.Validate("Corporate G/L Account No.", lrecGLAcc."Corporate G/L Account No.");
                            lrecGenJournalLine.Validate("Account No.", lrecGenJournalLineStaging."Account No.");
                            if lrecGenJournalLineStaging."Bal. Account No." <> '' then begin
                                lrecGLAcc.Get(lrecGenJournalLineStaging."Bal. Account No.");
                                lrecGenJournalLine.Validate("Bal. Corporate G/L Account No.", lrecGLAcc."Corporate G/L Account No.");
                                lrecGenJournalLine.Validate("Bal. Account No.", lrecGenJournalLineStaging."Bal. Account No.");
                            end;
                        end else begin
                            // MP 05-06-14 <<
                            lrecCorporateGLAccount.Get(lrecGenJournalLineStaging."Account No.");
                            lrecGenJournalLine.Validate("Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                            lrecGenJournalLine.Validate("Corporate G/L Account No.", lrecGenJournalLineStaging."Account No.");

                            // MP 05-06-14 >>
                            if lrecGenJournalLineStaging."Bal. Account No." <> '' then begin
                                lrecCorporateGLAccount.Get(lrecGenJournalLineStaging."Bal. Account No.");
                                lrecGenJournalLine.Validate("Bal. Account No.", lrecCorporateGLAccount."Local G/L Account No.");
                                lrecGenJournalLine.Validate("Bal. Corporate G/L Account No.", lrecGenJournalLineStaging."Bal. Account No.");
                            end;
                        end;
                        // MP 05-06-14 <<
                    end else begin
                        lrecGenJournalLine.Validate("Account No.", lrecGenJournalLineStaging."Account No.");
                    end;
                    lrecGenJournalLine.Validate(Description, lrecGenJournalLineStaging.Description);
                    // Handle foreign currency
                    if lrecGenJournalLineStaging."Currency Code" <> '' then begin
                        lrecGenJournalLine.Validate("Currency Code", lrecGenJournalLineStaging."Currency Code");
                        lrecGenJournalLine.Validate("Currency Factor", lrecGenJournalLineStaging."Currency Factor");
                    end;
                    lrecGenJournalLine.Validate(Amount, lrecGenJournalLineStaging.Amount);
                    // MP 20-11-14 >>
                    if lrecGenJournalLine.Amount = 0 then
                        lrecGenJournalLine.Validate("Allow Zero-Amount Posting", true);
                    // MP 20-11-14 <<
                    lrecSourceCodeSetup.Get;
                    lrecGenJournalLine."Source Code" := lrecSourceCodeSetup."Import Tool";
                    lrecGenJournalLine."GAAP Adjustment Reason" := lrecGenJournalLineStaging."GAAP Adjmt Reason";
                    lrecGenJournalLine."Adjustment Role" := lrecGenJournalLineStaging."Adjustment Role";
                    lrecGenJournalLine."Tax Adjustment Reason" := lrecGenJournalLineStaging."Tax Adjmt Reason";
                    lrecGenJournalLine."Equity Correction Code" := lrecGenJournalLineStaging."Equity Corr Code";
                    lrecGenJournalLine."Client Entry No." := lrecGenJournalLineStaging."Client Entry No.";
                    lrecGenJournalLine."Shortcut Dimension 1 Code" := lrecGenJournalLineStaging."Shortcut Dim 1 Code";
                    // MP 20-11-14 >>
                    if lrecGenJournalLine."Shortcut Dimension 1 Code" <> '' then
                        lrecGenJournalLine.Validate("Shortcut Dimension 1 Code");
                    // MP 20-11-14 <<
                    lrecGenJournalLine."Description (English)" := lrecGenJournalLineStaging."Description (English)";
                    // Handle AP, AR transaction - depending on EY setup G/L entries will not be posted
                    if p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::APTransactions then
                        lrecGenJournalLine."Interface Type" := lrecGenJournalLine."Interface Type"::"AP Transactions";
                    if p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"AR Transactions" then
                        lrecGenJournalLine."Interface Type" := lrecGenJournalLine."Interface Type"::"AR Transactions";
                    lrecGenJournalLine."A/R Trans Posting Scenario" := p_recImportLog."A/R Trans Posting Scenario";
                    lrecGenJournalLine."A/P Trans Posting Scenario" := p_recImportLog."A/P Trans Posting Scenario";

                    if lrecGenJournalLine."Bal. Account No." = '' then // MP 30-04-14
                        ldecAmount += lrecGenJournalLine.Amount;
                    lintNoRecords += 1;
                    //
                    //modify journal line
                    //
                    lrecGenJournalLine.Modify;
                until lrecGenJournalLineStaging.Next = 0;

            if ldecAmount <> 0 then begin
                Error(ERR_005, ldecAmount, lintNoRecords, CompanyName);
            end;
        end;

        exit(true);
    end;

    //[Scope('Internal')]
    procedure "<-- Other -->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncArchive(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecStaging: Record "Gen. Journal Line (Staging)";
        lrecProcessed: Record "Gen. Journal Line (Processed)";
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

    local procedure lfncInitGenJournalLine(var p_recTmpGenJournalLine: Record "Gen. Journal Line"; var p_recGenJournalLine: Record "Gen. Journal Line"; var p_recImportLog: Record "Import Log"; p_codBatchName: Code[20]; p_codAdjustmentCode: Code[20])
    var
        lrecGenJournalTemplate: Record "Gen. Journal Template";
        lrecGenJournalBatch: Record "Gen. Journal Batch";
        lrecGenJnlLine: Record "Gen. Journal Line";
    begin

        // Check if p_recTmpGenJournalLine contains record with p_codAdjustmentCode
        p_recTmpGenJournalLine.SetRange("Shortcut Dimension 1 Code", p_codAdjustmentCode);
        if not p_recTmpGenJournalLine.FindFirst then begin
            // If not, create new batch and add create new record in p_recTmpGenJournalLine
            if p_codAdjustmentCode = '' then begin
                // Blank value - get General Journal template
                lrecGenJournalTemplate.SetRange(Type, lrecGenJournalTemplate.Type::General);
                lrecGenJournalTemplate.SetRange(Recurring, false);
            end else begin
                // contains value - get template with same value in Shortcut dimension 1
                lrecGenJournalTemplate.SetRange("Shortcut Dimension 1 Code", p_codAdjustmentCode);
            end;
            lrecGenJournalTemplate.FindFirst; // This must exist, otherwise let it crash

            // MP 07-05-14 Check if batch name already exists>>
            if lrecGenJournalBatch.Get(lrecGenJournalTemplate.Name, p_codBatchName) then begin
                lrecGenJournalBatch."Reason Code" := lrecGenJournalTemplate."Reason Code";
                lrecGenJournalBatch."Template Type" := lrecGenJournalTemplate.Type;
                lrecGenJournalBatch."Reverse TB to TB" :=
                   (p_recImportLog."G/L Detail level" = p_recImportLog."G/L Detail level"::"Trial Balance") and
                   (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance");
                lrecGenJournalBatch.Recurring := false;
                lrecGenJournalBatch.Modify;

                // Check for existence of lines, allow an "empty" first line
                lrecGenJnlLine.SetRange("Journal Template Name", lrecGenJournalBatch."Journal Template Name");
                lrecGenJnlLine.SetRange("Journal Batch Name", lrecGenJournalBatch.Name);
                if lrecGenJnlLine.FindFirst then begin
                    if lrecGenJnlLine.Amount = 0 then
                        lrecGenJnlLine.Delete(true);
                    if lrecGenJnlLine.Count > 0 then
                        Error(ERR_013, lrecGenJournalBatch.TableCaption, lrecGenJournalBatch.Name);
                end;
            end else begin
                // MP 07-05-14 <<

                // Create new batch
                lrecGenJournalBatch.Init;
                lrecGenJournalBatch."Journal Template Name" := lrecGenJournalTemplate.Name;
                lrecGenJournalBatch."Reason Code" := lrecGenJournalTemplate."Reason Code";
                lrecGenJournalBatch."Template Type" := lrecGenJournalTemplate.Type;
                lrecGenJournalBatch.Name := p_codBatchName;
                lrecGenJournalBatch."Reverse TB to TB" :=
                   (p_recImportLog."G/L Detail level" = p_recImportLog."G/L Detail level"::"Trial Balance") and
                   (p_recImportLog."Interface Type" = p_recImportLog."Interface Type"::"Trial Balance");
                lrecGenJournalBatch.Recurring := false;

                lrecGenJournalBatch.Insert;
            end; // MP 07-05-14

            // Create new temp line
            p_recTmpGenJournalLine.Reset;
            p_recTmpGenJournalLine.Init;
            p_recTmpGenJournalLine."Journal Template Name" := lrecGenJournalBatch."Journal Template Name";
            p_recTmpGenJournalLine."Journal Batch Name" := lrecGenJournalBatch.Name;
            p_recTmpGenJournalLine."Shortcut Dimension 1 Code" := p_codAdjustmentCode;
            p_recTmpGenJournalLine."Line No." := 10000;
            p_recTmpGenJournalLine."Client Entry No." := p_recTmpGenJournalLine."Line No.";
            p_recTmpGenJournalLine.Insert;
        end;

        // use p_recTmpGenJournalLine to init p_recGenJournalLine
        p_recGenJournalLine.Init;
        p_recGenJournalLine."Journal Template Name" := p_recTmpGenJournalLine."Journal Template Name";
        p_recGenJournalLine."Journal Batch Name" := p_recTmpGenJournalLine."Journal Batch Name";
        p_recGenJournalLine."Line No." := p_recTmpGenJournalLine."Client Entry No.";

        // Increment Line No for next record
        p_recTmpGenJournalLine."Client Entry No." += 10000;
        p_recTmpGenJournalLine.Modify;
    end;

    local procedure lfcnIsBottomUp(): Boolean
    var
        lrecEYCoreSetup: Record "EY Core Setup";
    begin
        // MP 19-11-13

        lrecEYCoreSetup.Get;
        exit(lrecEYCoreSetup."Company Type" = lrecEYCoreSetup."Company Type"::"Bottom-up");
    end;
}

