codeunit 60010 "Data Import Mgt 60019"
{
    // This codeunit contains Staging table specific functionality
    // Specific to table 60019 - Customer staging


    trigger OnRun()
    begin
    end;

    var
        TXT_PAGE: Label 'Page';
        DLG_001: Label '#1################## \ Progress @2@@@@@@@@@@@@@@@@@@';
        DLG_002: Label 'Target #1########################\Activity #2########\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        DLG_003: Label 'Archiving records\@1@@@@@@@@@@@@@@@@@@';
        ERR_001: Label 'Company No. is missing. Account No. %1';
        ERR_002: Label 'Currency code %1 used in Customer %2 is not defined in company %3';
        ERR_003: Label 'Bill-To Customer %1 used in Customer %2 is not defined in company %3 nor in the import file';
        ERR_004: Label 'Gen. Buss Posting group %1 used in Customer %2 is not defined in company %3 nor in the import file';
        ERR_005: Label 'VAT Posting group %1 used in Customer %2 is not defined in company %3 nor in the import file';
        ERR_006: Label 'Receivables Account  is missing. Customer No. %1';
        ERR_007: Label 'Receivables Account  %1 used in Customer %2 does not exist as Corporate G/L Account  in company %3';
        ERR_008: Label 'Local G/L account %1 does not exist in company %2';
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
        lrecCustomerStaging: Record "Customer (Staging)";
        lintTotal: Integer;
        lintPosition: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;
        lrecCustomerStaging.SetCurrentKey("Import Log Entry No.");
        lrecCustomerStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
            ldlgDialog.Update(1, MSG_001);
            lintTotal := lrecCustomerStaging.Count;
            lintPosition := 0;
        end;

        //
        // Checks that can be done one by one
        //

        lrecCustomerStaging.Reset;
        lrecCustomerStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecCustomerStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lintLastPct := 0;
        if lrecCustomerStaging.FindSet(false) then
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
                if lrecCustomerStaging."Company No." = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_001, lrecCustomerStaging."No."));
                end;
                if lrecCustomerStaging."Receivables Account" = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_006, lrecCustomerStaging."No."));
                end;
            until lrecCustomerStaging.Next = 0;


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
        //
        // Do Processing of data before they are sent to local database
        // (Export data from Master database etc..)
        //
        r_blnResult := true;
        if p_recImportLogSubsidiaryClient."VAT Reporting level" =
           p_recImportLogSubsidiaryClient."VAT Reporting level"::"Create One Source File"
          then begin
            r_blnResult := gfncExportCustomer(p_recImportLog, p_recImportLogSubsidiaryClient, p_blnDialog);
        end;
    end;

    //[Scope('Internal')]
    procedure gfncExportCustomer(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lfilFile: File;
        lostFile: OutStream;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ltxtFileName: Text[1024];
        lrecCustomerStaging: Record "Customer (Staging)";
    begin
        //
        // This will export Customer file
        //
        // ToDo Implement here
        r_blnResult := lmodDataImportManagementCommon.gfncCreateServerFile(lfilFile, p_recImportLog, p_recImportLogSubsidiaryClient, 'txt');
        //ltxtFileName := lfilFile.Name;

        // MP 30-03-12 Replaced by XMLport >>

        // Header line
        //ltxtLine := 'MREF,NAME,COUNTRY,ADDRESS,PCODE,VAT Regn Number,VATRATE';
        //lfilFile.WRITE(ltxtLine);

        // MP 30-03-12 Replaced by XMLport <<

        lrecCustomerStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecCustomerStaging.SetRange("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
        lrecCustomerStaging.SetRange("Company No.", p_recImportLogSubsidiaryClient."Company No.");

        // MP 30-03-12 Replaced by XMLport >>

        //lfilFile.CreateOutStream(lostFile);
        XMLPORT.Export(XMLPORT::"Customer - OneSource", lostFile, lrecCustomerStaging);

        //IF lrecCustomerStaging.FINDSET(FALSE, FALSE) THEN REPEAT
        //  ltxtLine := lrecCustomerStaging."No." + ',' +
        //              lrecCustomerStaging.Name + ',' +
        //              lrecCustomerStaging."Country/Region Code" + ',' +
        //              lrecCustomerStaging.Address + ',' +
        //              lrecCustomerStaging."Post Code" + ',' +
        //              lrecCustomerStaging."VAT Registration No." + ',' +
        //              ',' ; // VAT Rate
        //  lfilFile.WRITE(ltxtLine);
        //UNTIL lrecCustomerStaging.NEXT = 0;

        // MP 30-03-12 Replaced by XMLport <<

        //lfilFile.Close;
        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(MSG_004, ltxtFileName));
    end;

    //[Scope('Internal')]
    procedure gfncGetActionNoCopyData(): Integer
    begin
        //
        // Returns Action Number which represents copy data
        // as per definiton in CU 60008 Data Import Safe WS call
        //
        exit(10);
    end;

    //[Scope('Internal')]
    procedure gfncCopyClient(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        //ldotCustomerStg_Service: DotNet CustomerStg_Service;
        //ldotCustomerStg: DotNet CustomerStg;
        //ldotArray: DotNet Array;
        lintBatchSize: Integer;
        lintArrayPosition: Integer;
        lintArrayLength: Integer;
        lintRemainingRecords: Integer;
        lrecCustomerStaging: Record "Customer (Staging)";
        lblnNoMoreRecords: Boolean;
        ltxtURL: Text[1024];
        ltxtErr: Text[1024];
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ldlgDialog: Dialog;
        lintRecordCount: Integer;
        lintCounter: Integer;
        lintLastPct: Integer;
    begin

        if p_recImportLogSubsidiaryClient."VAT Reporting level" = p_recImportLogSubsidiaryClient."VAT Reporting level"::"Process In NAV"
          then begin
            //
            // Copy data to specific client using webservice
            //
            if p_blnDialog then begin
                ldlgDialog.Open(DLG_002);
                ldlgDialog.Update(1, p_recImportLogSubsidiaryClient."Company Name");
            end;
            /* ldotCustomerStg_Service := ldotCustomerStg_Service.CustomerStg_Service();
             ldotCustomerStg_Service.UseDefaultCredentials(TRUE);

             IF NOT lmodDataImportManagementCommon.gfncBuildURL(p_recImportLogSubsidiaryClient,
                                                                TXT_PAGE,
                                                                lmodDataImportManagementCommon.gfncGetCustomerStgWSName(),
                                                                ltxtURL, ltxtErr)
               THEN BEGIN
                 lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0, ltxtErr);
                 EXIT(FALSE);
               END;

             ldotCustomerStg_Service.Url := ltxtURL;
             //ToDo Move to setup
             lintBatchSize := 500; // Initial batch size Should be in setup!
             lblnNoMoreRecords := FALSE;

             lrecCustomerStaging.SETCURRENTKEY("Import Log Entry No.", "Company No.");
             lrecCustomerStaging.SETRANGE("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
             lrecCustomerStaging.SETRANGE("Company No.", p_recImportLogSubsidiaryClient."Company No.");
             lintRemainingRecords := lrecCustomerStaging.COUNT;
             lintArrayPosition := 0;
             ldotCustomerStg := ldotCustomerStg.CustomerStg();

             IF p_blnDialog THEN BEGIN
               lintRecordCount := lrecCustomerStaging.COUNT;
               lintCounter := 0;
             END;

             IF lrecCustomerStaging.FINDSET(FALSE) THEN BEGIN
               REPEAT
                 // Build array up to the batch size
                 IF p_blnDialog THEN BEGIN
                   ldlgDialog.UPDATE(2, MSG_002);
                 END;

                 IF lintRemainingRecords > lintBatchSize THEN lintArrayLength := lintBatchSize
                                                         ELSE lintArrayLength := lintRemainingRecords;
                 IF NOT ISNULL(ldotArray) THEN CLEAR(ldotArray);
                 ldotArray := ldotArray.CreateInstance(ldotCustomerStg.GetType(), lintArrayLength);
                 lintLastPct := 0;
                 REPEAT
                   IF p_blnDialog THEN BEGIN
                     lintCounter += 1;
                     IF ROUND((lintCounter/lintRecordCount)*100,1,'<') > lintLastPct THEN BEGIN
                       lintLastPct := ROUND((lintCounter/lintRecordCount)*100,1,'<');
                       ldlgDialog.UPDATE(3,lintLastPct * 100);
                     END;
                   END;
                   IF NOT ISNULL(ldotCustomerStg) THEN CLEAR(ldotCustomerStg);
                   ldotCustomerStg := ldotCustomerStg.CustomerStg();
                   // Build record
                   ldotCustomerStg.No                            := lrecCustomerStaging."No.";
                   ldotCustomerStg.Name                          := lrecCustomerStaging.Name;
                   ldotCustomerStg.Address                       := lrecCustomerStaging.Address;
                   ldotCustomerStg.Address_2                     := lrecCustomerStaging."Address 2";
                   ldotCustomerStg.City                          := lrecCustomerStaging.City;
                   ldotCustomerStg.Currency_Code                 := lrecCustomerStaging."Currency Code";
                   ldotCustomerStg.Country_Region_Code           := lrecCustomerStaging."Country/Region Code";
                   ldotCustomerStg.Bill_to_Customer_No           := lrecCustomerStaging."Bill-to Customer No.";
                   ldotCustomerStg.VAT_Registration_No           := lrecCustomerStaging."VAT Registration No.";
                   ldotCustomerStg.Gen_Bus_Posting_Group         := lrecCustomerStaging."Gen. Bus. Posting Group";
                   ldotCustomerStg.Post_Code                     := lrecCustomerStaging."Post Code";
                   ldotCustomerStg.Tax_Liable                    := lrecCustomerStaging."Tax Liable";
                   ldotCustomerStg.Tax_LiableSpecified           := TRUE;
                   ldotCustomerStg.VAT_Bus_Posting_Group         := lrecCustomerStaging."VAT Bus. Posting Group";
                   ldotCustomerStg.Receivables_Account           := lrecCustomerStaging."Receivables Account";
                   ldotCustomerStg.Company_No                    := lrecCustomerStaging."Company No.";
                   ldotCustomerStg.Client_No                     := lrecCustomerStaging."Client No.";
                   ldotCustomerStg.User_ID                       := lrecCustomerStaging."User ID";
                   ldotCustomerStg.Status                        := lrecCustomerStaging.Status;
                   ldotCustomerStg.StatusSpecified               := TRUE;
                   ldotCustomerStg.Import_Log_Entry_No           := lrecCustomerStaging."Import Log Entry No.";
                   ldotCustomerStg.Import_Log_Entry_NoSpecified  := TRUE;
                   // Add to array
                   ldotArray.SetValue(ldotCustomerStg, lintArrayPosition);
                   lintArrayPosition += 1;
                   lblnNoMoreRecords := (lrecCustomerStaging.NEXT = 0);
                   lintRemainingRecords -= 1;
                 UNTIL ((lintArrayPosition = (lintBatchSize-1)) OR lblnNoMoreRecords);
                 lintArrayPosition := 0;
                 IF p_blnDialog THEN BEGIN
                   ldlgDialog.UPDATE(2, MSG_003);
                 END;
                 // and send it
                 ldotCustomerStg_Service.CreateMultiple(ldotArray); // disabled for testing
               UNTIL lblnNoMoreRecords;
             END;
             */
            if p_blnDialog then begin
                ldlgDialog.Close;
            end;
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
        lrecCustomerStaging: Record "Customer (Staging)";
        lrecCurrency: Record Currency;
        lrecCustomer: Record Customer;
        lrecCustomerStaging2: Record "Customer (Staging)";
        lrecGenBusinessPostingGroup: Record "Gen. Business Posting Group";
        lrecVATBusinessPostingGroup: Record "VAT Business Posting Group";
        lrecGLAccount: Record "G/L Account";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;

        // Delete old Error entries
        lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

        lrecCustomerStaging.SetCurrentKey("Import Log Entry No.");
        lrecCustomerStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        if lrecCustomerStaging.FindSet(false) then
            repeat
                //
                // Currency
                //
                if lrecCustomerStaging."Currency Code" <> '' then begin
                    if not lrecCurrency.Get(lrecCustomerStaging."Currency Code") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_002, lrecCustomerStaging."Currency Code",
                                                                  lrecCustomerStaging."No.", CompanyName));
                    end;
                end;
                //
                // Bill-to customer
                //
                if (lrecCustomerStaging."Bill-to Customer No." <> '') then begin
                    if (lrecCustomerStaging."Bill-to Customer No." <> lrecCustomerStaging."No.") then begin
                        // Check Bill-to in database
                        if not lrecCustomer.Get(lrecCustomerStaging."Bill-to Customer No.") then begin
                            // Check Bill-to in Staging
                            lrecCustomerStaging2.SetCurrentKey("Import Log Entry No.", "No.");
                            lrecCustomerStaging2.SetRange("No.", lrecCustomerStaging."Bill-to Customer No.");
                            lrecCustomerStaging2.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
                            if not lrecCustomerStaging2.FindFirst then begin
                                r_blnResult := false;
                                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                               StrSubstNo(ERR_003, lrecCustomerStaging."Bill-to Customer No.",
                                                                          lrecCustomerStaging."No.", CompanyName));
                            end;
                        end;
                    end;
                end;
                // Gen. Bussiness Posting group
                if lrecCustomerStaging."Gen. Bus. Posting Group" <> '' then begin
                    if not lrecGenBusinessPostingGroup.Get(lrecCustomerStaging."Gen. Bus. Posting Group") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_004, lrecCustomerStaging."Gen. Bus. Posting Group",
                                                                  lrecCustomerStaging."No.", CompanyName));
                    end;
                end;
                // VAT posting group
                if lrecCustomerStaging."VAT Bus. Posting Group" <> '' then begin
                    if not lrecVATBusinessPostingGroup.Get(lrecCustomerStaging."VAT Bus. Posting Group") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_005, lrecCustomerStaging."VAT Bus. Posting Group",
                                                                  lrecCustomerStaging."No.", CompanyName));
                    end;
                end;
                // Corporate G/L account
                if not lrecCorporateGLAccount.Get(lrecCustomerStaging."Receivables Account") then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_007, lrecCustomerStaging."Receivables Account",
                                                              lrecCustomerStaging."No.", CompanyName));
                end else begin
                    // Receivables account
                    if not lrecGLAccount.Get(lrecCorporateGLAccount."Local G/L Account No.") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_008, lrecCorporateGLAccount."Local G/L Account No.",
                                                                  CompanyName));
                    end;
                end;
            until lrecCustomerStaging.Next = 0;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 5 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactions(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecCustomerStaging: Record "Customer (Staging)";
        lrecCustomer: Record Customer;
        lrecCustomerPostingGroup: Record "Customer Posting Group";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
    begin
        lrecCustomerStaging.SetCurrentKey("Import Log Entry No.");
        lrecCustomerStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if lrecCustomerStaging.FindSet(false) then
            repeat
                //
                // Create Customer record
                //
                if not lrecCustomer.Get(lrecCustomerStaging."No.") then lrecCustomer.Init;
                lrecCustomer."No." := lrecCustomerStaging."No.";
                lrecCustomer.Validate(Name, lrecCustomerStaging.Name);
                lrecCustomer.Address := lrecCustomerStaging.Address;
                lrecCustomer."Address 2" := lrecCustomerStaging."Address 2";
                lrecCustomer.City := lrecCustomerStaging.City;
                if lrecCustomerStaging."Currency Code" <> '' then
                    lrecCustomer.Validate("Currency Code", lrecCustomerStaging."Currency Code");
                lrecCustomer."Country/Region Code" := lrecCustomerStaging."Country/Region Code";
                lrecCustomer."Bill-to Customer No." := lrecCustomerStaging."Bill-to Customer No.";
                lrecCustomer."VAT Registration No." := lrecCustomerStaging."VAT Registration No.";
                if lrecCustomerStaging."Gen. Bus. Posting Group" <> '' then
                    lrecCustomer.Validate("Gen. Bus. Posting Group", lrecCustomerStaging."Gen. Bus. Posting Group");
                lrecCustomer."Post Code" := lrecCustomerStaging."Post Code";
                lrecCustomer."Tax Liable" := lrecCustomerStaging."Tax Liable";
                if lrecCustomerStaging."VAT Bus. Posting Group" <> '' then
                    lrecCustomer.Validate("VAT Bus. Posting Group", lrecCustomerStaging."VAT Bus. Posting Group");
                //
                // Default/generated  values
                //
                lrecCorporateGLAccount.Get(lrecCustomerStaging."Receivables Account");
                lrecCustomerPostingGroup.SetRange("Receivables Account", lrecCorporateGLAccount."Local G/L Account No.");
                if not lrecCustomerPostingGroup.FindFirst then begin
                    // Create a new one
                    lrecCustomerPostingGroup.Init;
                    lrecCustomerPostingGroup.Code := lrecCustomerStaging."Receivables Account";
                    lrecCustomerPostingGroup.Validate("Receivables Account", lrecCorporateGLAccount."Local G/L Account No.");
                    lrecCustomerPostingGroup.Insert(true);
                end;
                lrecCustomer.Validate("Customer Posting Group", lrecCustomerPostingGroup.Code);
                //
                // Insert / update Customer account
                //
                if not lrecCustomer.Insert(true) then lrecCustomer.Modify(true);

            until lrecCustomerStaging.Next = 0;
        exit(true);
    end;

    //[Scope('Internal')]
    procedure "<-- Other -->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncArchive(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecStaging: Record "Customer (Staging)";
        lrecProcessed: Record "Customer (Processed)";
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

