codeunit 60011 "Data Import Mgt 60020"
{
    // This codeunit contains Staging table specific functionality
    // Specific to table 60020 - Vendor staging


    trigger OnRun()
    begin
    end;

    var
        TXT_PAGE: Label 'Page';
        DLG_001: Label '#1################## \ Progress @2@@@@@@@@@@@@@@@@@@';
        DLG_002: Label 'Target #1########################\Activity #2########\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        DLG_003: Label 'Archiving records\@1@@@@@@@@@@@@@@@@@@';
        ERR_001: Label 'Company No. is missing. Account No. %1';
        ERR_002: Label 'Currency code %1 used in Vendor %2 is not defined in company %3';
        ERR_003: Label 'Pay-to Vendor %1 used in Vendor %2 is not defined in company %3 nor in the import file';
        ERR_004: Label 'Gen. Buss Posting group %1 used in Vendor %2 is not defined in company %3 nor in the import file';
        ERR_005: Label 'VAT Posting group %1 used in Vendor %2 is not defined in company %3 nor in the import file';
        ERR_006: Label 'Payables Account  is missing. Vendor No. %1';
        ERR_007: Label 'Payables Account  %1 used in Vendor %2 does not exist as Corporate G/L Account  in company %3';
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
        lrecVendorStaging: Record "Vendor (Staging)";
        lintTotal: Integer;
        lintPosition: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;
        lrecVendorStaging.SetCurrentKey("Import Log Entry No.");
        lrecVendorStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
            ldlgDialog.Update(1, MSG_001);
            lintTotal := lrecVendorStaging.Count;
            lintPosition := 0;
        end;

        //
        // Checks that can be done one by one
        //

        lrecVendorStaging.Reset;
        lrecVendorStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecVendorStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        lintLastPct := 0;
        if lrecVendorStaging.FindSet(false) then
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
                if lrecVendorStaging."Company No." = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_001, lrecVendorStaging."No."));
                end;
                if lrecVendorStaging."Payables Account" = '' then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_006, lrecVendorStaging."No."));
                end;
            until lrecVendorStaging.Next = 0;


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
        r_blnResult := true;
        if p_recImportLogSubsidiaryClient."VAT Reporting level" =
           p_recImportLogSubsidiaryClient."VAT Reporting level"::"Create One Source File"
          then begin
            r_blnResult := gfncExportVendor(p_recImportLog, p_recImportLogSubsidiaryClient, p_blnDialog);
        end;
    end;

    //[Scope('Internal')]
    procedure gfncExportVendor(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lfilFile: File;
        lostFile: OutStream;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        ltxtFileName: Text[1024];
        ltxtLine: Text[1024];
        lrecVendorStaging: Record "Vendor (Staging)";
    begin
        //
        // This will export Vendor file
        //
        // ToDo Implement here
        r_blnResult := lmodDataImportManagementCommon.gfncCreateServerFile(lfilFile, p_recImportLog, p_recImportLogSubsidiaryClient, 'txt');
        //ltxtFileName := lfilFile.Name;

        // MP 30-03-12 Replaced by XMLport >>

        // Header line
        //ltxtLine := 'MREF,NAME,COUNTRY,ADDRESS,PCODE,VAT Regn Number,VATRATE';
        //lfilFile.WRITE(ltxtLine);

        // MP 30-03-12 Replaced by XMLport <<

        lrecVendorStaging.SetCurrentKey("Import Log Entry No.", "Company No.");
        lrecVendorStaging.SetRange("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
        lrecVendorStaging.SetRange("Company No.", p_recImportLogSubsidiaryClient."Company No.");

        // MP 30-03-12 Replaced by XMLport >>

        //lfilFile.CreateOutStream(lostFile);
        XMLPORT.Export(XMLPORT::"Vendor - OneSource", lostFile, lrecVendorStaging);

        //IF lrecVendorStaging.FINDSET(FALSE, FALSE) THEN REPEAT
        //  ltxtLine := lrecVendorStaging."No." + ',' +
        //              lrecVendorStaging.Name + ',' +
        //              lrecVendorStaging."Country/Region Code" + ',' +
        //              lrecVendorStaging.Address + ',' +
        //              lrecVendorStaging."Post Code" + ',' +
        //              lrecVendorStaging."VAT Registration No." + ',' +
        //              ',' ; // VAT Rate
        //  lfilFile.WRITE(ltxtLine);
        //UNTIL lrecVendorStaging.NEXT = 0;

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
        exit(11);
    end;

    //[Scope('Internal')]
    procedure gfncCopyClient(var p_recImportLog: Record "Import Log"; var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        // ldotVendorStg_Service: DotNet VendorStg_Service;
        // ldotVendorStg: DotNet VendorStg;
        // ldotArray: DotNet Array;
        lintBatchSize: Integer;
        lintArrayPosition: Integer;
        lintArrayLength: Integer;
        lintRemainingRecords: Integer;
        lrecVendorStaging: Record "Vendor (Staging)";
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
            /*ldotVendorStg_Service := ldotVendorStg_Service.VendorStg_Service();
            ldotVendorStg_Service.UseDefaultCredentials(TRUE);

            IF NOT lmodDataImportManagementCommon.gfncBuildURL(p_recImportLogSubsidiaryClient,
                                                               TXT_PAGE,
                                                               lmodDataImportManagementCommon.gfncGetVendorStgWSName(),
                                                               ltxtURL, ltxtErr)
              THEN BEGIN
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0, ltxtErr);
                EXIT(FALSE);
              END;

            ldotVendorStg_Service.Url := ltxtURL;
            //ToDo Move to setup
            lintBatchSize := 500; // Initial batch size Should be in setup!
            lblnNoMoreRecords := FALSE;

            lrecVendorStaging.SETCURRENTKEY("Import Log Entry No.", "Company No.");
            lrecVendorStaging.SETRANGE("Import Log Entry No.", p_recImportLogSubsidiaryClient."Import Log Entry No.");
            lrecVendorStaging.SETRANGE("Company No.", p_recImportLogSubsidiaryClient."Company No.");
            lintRemainingRecords := lrecVendorStaging.COUNT;
            lintArrayPosition := 0;
            ldotVendorStg := ldotVendorStg.VendorStg();

            IF p_blnDialog THEN BEGIN
              lintRecordCount := lrecVendorStaging.COUNT;
              lintCounter := 0;
            END;

            IF lrecVendorStaging.FINDSET(FALSE) THEN BEGIN
              REPEAT
                // Build array up to the batch size
                IF p_blnDialog THEN BEGIN
                  ldlgDialog.UPDATE(2, MSG_002);
                END;

                IF lintRemainingRecords > lintBatchSize THEN lintArrayLength := lintBatchSize
                                                        ELSE lintArrayLength := lintRemainingRecords;
                IF NOT ISNULL(ldotArray) THEN CLEAR(ldotArray);
                ldotArray := ldotArray.CreateInstance(ldotVendorStg.GetType(), lintArrayLength);
                lintLastPct := 0;
                REPEAT
                  IF p_blnDialog THEN BEGIN
                    lintCounter += 1;
                    IF ROUND((lintCounter/lintRecordCount)*100,1,'<') > lintLastPct THEN BEGIN
                      lintLastPct :=  ROUND((lintCounter/lintRecordCount)*100,1,'<');
                      ldlgDialog.UPDATE(3, lintLastPct * 100);
                    END;
                  END;
                  IF NOT ISNULL(ldotVendorStg) THEN CLEAR(ldotVendorStg);
                  ldotVendorStg := ldotVendorStg.VendorStg();
                  // Build record
                  ldotVendorStg.No                            := lrecVendorStaging."No.";
                  ldotVendorStg.Name                          := lrecVendorStaging.Name;
                  ldotVendorStg.Address                       := lrecVendorStaging.Address;
                  ldotVendorStg.Address_2                     := lrecVendorStaging."Address 2";
                  ldotVendorStg.City                          := lrecVendorStaging.City;
                  ldotVendorStg.Currency_Code                 := lrecVendorStaging."Currency Code";
                  ldotVendorStg.Country_Region_Code           := lrecVendorStaging."Country/Region Code";
                  ldotVendorStg.Pay_to_Vendor_No              := lrecVendorStaging."Pay-to Vendor No.";
                  ldotVendorStg.VAT_Registration_No           := lrecVendorStaging."VAT Registration No.";
                  ldotVendorStg.Gen_Bus_Posting_Group         := lrecVendorStaging."Gen. Bus. Posting Group";
                  ldotVendorStg.Post_Code                     := lrecVendorStaging."Post Code";
                  ldotVendorStg.Tax_Liable                    := lrecVendorStaging."Tax Liable";
                  ldotVendorStg.Tax_LiableSpecified           := TRUE;
                  ldotVendorStg.VAT_Bus_Posting_Group         := lrecVendorStaging."VAT Bus. Posting Group";
                  ldotVendorStg.Payables_Account              := lrecVendorStaging."Payables Account";
                  ldotVendorStg.Company_No                    := lrecVendorStaging."Company No.";
                  ldotVendorStg.Client_No                     := lrecVendorStaging."Client No.";
                  ldotVendorStg.User_ID                       := lrecVendorStaging."User ID";
                  ldotVendorStg.Status                        := lrecVendorStaging.Status;
                  ldotVendorStg.StatusSpecified               := TRUE;
                  ldotVendorStg.Import_Log_Entry_No           := lrecVendorStaging."Import Log Entry No.";
                  ldotVendorStg.Import_Log_Entry_NoSpecified  := TRUE;
                  // Add to array
                  ldotArray.SetValue(ldotVendorStg, lintArrayPosition);
                  lintArrayPosition += 1;
                  lblnNoMoreRecords := (lrecVendorStaging.NEXT = 0);
                  lintRemainingRecords -= 1;
                UNTIL ((lintArrayPosition = (lintBatchSize-1)) OR lblnNoMoreRecords);
                lintArrayPosition := 0;
                IF p_blnDialog THEN BEGIN
                  ldlgDialog.UPDATE(2, MSG_003);
                END;
                // and send it
                ldotVendorStg_Service.CreateMultiple(ldotArray); // disabled for testing
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
        lrecVendorStaging: Record "Vendor (Staging)";
        lrecCurrency: Record Currency;
        lrecVendor: Record Vendor;
        lrecVendorStaging2: Record "Vendor (Staging)";
        lrecGenBusinessPostingGroup: Record "Gen. Business Posting Group";
        lrecVATBusinessPostingGroup: Record "VAT Business Posting Group";
        lrecGLAccount: Record "G/L Account";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        r_blnResult := true;

        // Delete old Error entries
        lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

        lrecVendorStaging.SetCurrentKey("Import Log Entry No.");
        lrecVendorStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
        if lrecVendorStaging.FindSet(false) then
            repeat
                //
                // Currency
                //
                if lrecVendorStaging."Currency Code" <> '' then begin
                    if not lrecCurrency.Get(lrecVendorStaging."Currency Code") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_002, lrecVendorStaging."Currency Code",
                                                                  lrecVendorStaging."No.", CompanyName));
                    end;
                end;
                //
                // Bill-to Vendor
                //
                if (lrecVendorStaging."Pay-to Vendor No." <> '') then begin
                    if lrecVendorStaging."Pay-to Vendor No." <> lrecVendorStaging."No." then begin
                        // Check Pay-to in database
                        if not lrecVendor.Get(lrecVendorStaging."Pay-to Vendor No.") then begin
                            // Check Pay-to in Staging
                            lrecVendorStaging2.SetCurrentKey("Import Log Entry No.", "No.");
                            lrecVendorStaging2.SetRange("No.", lrecVendorStaging."Pay-to Vendor No.");
                            lrecVendorStaging2.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
                            if not lrecVendorStaging2.FindFirst then begin
                                r_blnResult := false;
                                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                               StrSubstNo(ERR_003, lrecVendorStaging."Pay-to Vendor No.",
                                                                          lrecVendorStaging."No.", CompanyName));
                            end;
                        end;
                    end;
                end;
                // Gen. Bussiness Posting group
                if lrecVendorStaging."Gen. Bus. Posting Group" <> '' then begin
                    if not lrecGenBusinessPostingGroup.Get(lrecVendorStaging."Gen. Bus. Posting Group") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_004, lrecVendorStaging."Gen. Bus. Posting Group",
                                                                  lrecVendorStaging."No.", CompanyName));
                    end;
                end;
                // VAT posting group
                if lrecVendorStaging."VAT Bus. Posting Group" <> '' then begin
                    if not lrecVATBusinessPostingGroup.Get(lrecVendorStaging."VAT Bus. Posting Group") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_005, lrecVendorStaging."VAT Bus. Posting Group",
                                                                  lrecVendorStaging."No.", CompanyName));
                    end;
                end;
                // Corporate G/L account
                if not lrecCorporateGLAccount.Get(lrecVendorStaging."Payables Account") then begin
                    r_blnResult := false;
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                   StrSubstNo(ERR_007, lrecVendorStaging."Payables Account",
                                                              lrecVendorStaging."No.", CompanyName));
                end else begin
                    // Receivables account
                    if not lrecGLAccount.Get(lrecCorporateGLAccount."Local G/L Account No.") then begin
                        r_blnResult := false;
                        lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                       StrSubstNo(ERR_008, lrecCorporateGLAccount."Local G/L Account No.",
                                                                  CompanyName));
                    end;
                end;
            until lrecVendorStaging.Next = 0;
    end;

    //[Scope('Internal')]
    procedure "<-- Stage 5 related ->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncPostTransactions(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecVendorStaging: Record "Vendor (Staging)";
        lrecVendor: Record Vendor;
        lrecVendorPostingGroup: Record "Vendor Posting Group";
        lrecCorporateGLAccount: Record "Corporate G/L Account";
    begin
        lrecVendorStaging.SetCurrentKey("Import Log Entry No.");
        lrecVendorStaging.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

        if lrecVendorStaging.FindSet(false) then
            repeat
                //
                // Create Vendor record
                //

                if not lrecVendor.Get(lrecVendorStaging."No.") then lrecVendor.Init;
                lrecVendor."No." := lrecVendorStaging."No.";
                lrecVendor.Validate(Name, lrecVendorStaging.Name);
                lrecVendor.Address := lrecVendorStaging.Address;
                lrecVendor."Address 2" := lrecVendorStaging."Address 2";
                lrecVendor.City := lrecVendorStaging.City;
                if lrecVendorStaging."Currency Code" <> '' then
                    lrecVendor.Validate("Currency Code", lrecVendorStaging."Currency Code");
                lrecVendor."Country/Region Code" := lrecVendorStaging."Country/Region Code";
                lrecVendor."Pay-to Vendor No." := lrecVendorStaging."Pay-to Vendor No.";
                lrecVendor."VAT Registration No." := lrecVendorStaging."VAT Registration No.";
                if lrecVendorStaging."Gen. Bus. Posting Group" <> '' then
                    lrecVendor.Validate("Gen. Bus. Posting Group", lrecVendorStaging."Gen. Bus. Posting Group");
                lrecVendor."Post Code" := lrecVendorStaging."Post Code";
                lrecVendor."Tax Liable" := lrecVendorStaging."Tax Liable";
                if lrecVendorStaging."VAT Bus. Posting Group" <> '' then
                    lrecVendor.Validate("VAT Bus. Posting Group", lrecVendorStaging."VAT Bus. Posting Group");

                //
                // Default/generated  values
                //
                lrecCorporateGLAccount.Get(lrecVendorStaging."Payables Account");
                lrecVendorPostingGroup.SetRange("Payables Account", lrecCorporateGLAccount."Local G/L Account No.");
                if not lrecVendorPostingGroup.FindFirst then begin
                    // Create a new one
                    lrecVendorPostingGroup.Init;
                    lrecVendorPostingGroup.Code := lrecVendorStaging."Payables Account";
                    lrecVendorPostingGroup.Validate("Payables Account", lrecCorporateGLAccount."Local G/L Account No.");
                    lrecVendorPostingGroup.Insert(true);
                end;
                lrecVendor.Validate("Vendor Posting Group", lrecVendorPostingGroup.Code);
                //
                // Insert / update Vendor account
                //
                if not lrecVendor.Insert(true) then lrecVendor.Modify(true);

            until lrecVendorStaging.Next = 0;
        exit(true);
    end;

    //[Scope('Internal')]
    procedure "<-- Other -->"()
    begin
    end;

    //[Scope('Internal')]
    procedure gfncArchive(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lrecStaging: Record "Vendor (Staging)";
        lrecProcessed: Record "Vendor (Processed)";
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

