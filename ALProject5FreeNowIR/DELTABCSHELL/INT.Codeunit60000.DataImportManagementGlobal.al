codeunit 60000 "Data Import Management Global"
{
    // MP 30-04-14
    // Development taken from Core II
    // 
    // MP 17-11-14
    // Upgraded to NAV 2013 R2
    // 
    // MP 25-May-16
    // Upgraded to NAV 2016: deleted obsolete functions gfncImportXLS and gfncImportXLSLine, changed from using Automation to .NET components


    trigger OnRun()
    begin
    end;

    var
        DLG_001: Label 'Import progress\@1@@@@@@@@@@@@@@@@@@';
        DLG_002: Label 'Uploading file to server: #1#############';
        DLG_003: Label '#1################## \ Progress @2@@@@@@@@@@@@@@@@@@';
        DLG_004: Label 'Are you sure you want to delete entries related to import log %1 from table "%2" and move them to the "Processed table"?';
        DLG_005: Label 'Do you want to process Import log No. %1?';
        DLG_006: Label 'Please select Posting Method';
        ERR_001: Label 'Automated processing of Import Log %1 failed at %2. Check details above.';
        ERR_002: Label 'File %1 is empty';
        ERR_003: Label 'Incorrect value "%1" Line:%2 Column:%3 Expected type is %4';
        ERR_004: Label 'Unsupported file type: %1';
        ERR_005: Label 'Unsupported field Type %1, Field %2';
        ERR_006: Label 'Incorrect decimal value "%1" Line:%2 Column:%3';
        ERR_007: Label 'Incorrect date format "%1" Line:%2 Column:%3';
        ERR_008: Label 'Text "%1..." is too long.\Max length is %2\Line:%3 Column:%4';
        ERR_009: Label 'Unsupported Table No. %1';
        ERR_010: Label 'Cannot open file %1';
        ERR_011: Label 'File %1 does not exist';
        ERR_012: Label 'Missing definition for subsidiary company %1';
        ERR_013: Label 'Stage 2 failed. Entries in staging table related to Import log %1 were deleted';
        ERR_014: Label 'Local database %1 does not exist';
        ERR_015: Label 'Automated process cannot start from Stage "%1", Status "%2"';
        ERR_016: Label '%1 WS call error.';
        ERR_017: Label 'Remote validation of Journal %1 in company %2 failed.';
        ERR_018: Label 'Remote posting of Journal %1 in company %2 failed.';
        ERR_019: Label 'Cannot delete temporary file';
        ERR_020: Label 'Stage %1 failed. Entries in remote staging table related to Import log %2 were deleted';
        ERR_021: Label 'Rollback of remote data failed. Stage %1, Import log %2 ';
        ERR_022: Label 'Cannot create server located file %1';
        ERR_023: Label 'Cannot upload into stream file %1. %2';
        ERR_024: Label 'Cannot determine version of Excel : "%1"';
        ERR_025: Label 'Incorrect version of Excel. Current version is "%1". Required version is 12 or higher ';
        ERR_026: Label 'Cannot create file %1. Missing write rights to the directory?';
        ERR_027: Label 'Cannot delete file %1.';
        ERR_028: Label 'Cannot upload file %1 on the server. %2';
        MSG_001: Label 'Import file for G/L Account';
        MSG_002: Label 'Import file for Corporate Account';
        MSG_003: Label 'Import file for Trial Balance';
        MSG_004: Label 'Import file for G/L Entry';
        MSG_005: Label 'Import file for Customer';
        MSG_006: Label 'Import file for Vendor';
        MSG_007: Label 'Import file for AR';
        MSG_008: Label 'Import file for AP';
        MSG_010: Label 'File %1 was imported successfully.\Import log %2 was created.';
        MSG_011: Label 'Import of file %1 failed.\Please check import log %2 for more information.';
        MSG_012: Label 'Preparation ...';
        MSG_013: Label 'Uploading ...';
        MSG_014: Label 'Saving ...';
        MSG_015: Label 'Building list of Companies';
        MSG_016: Label 'Automated processing of Import Log No. %1 started at %2';
        MSG_017: Label 'Automated processing of Import Log No. %1 successfully finished at %2';
        MSG_018: Label 'Processing was successfull';
        MSG_019: Label 'Processing failed. Please check Error log for details';
        MSG_020: Label 'Achiving was successfull';
        MSG_021: Label 'Archiving failed';
        MSG_022: Label 'Import file for SSB Imports';
        MNU_001: Label 'Post,Simulate';

    ////[Scope('Internal')]
    procedure "<-- Automated Run -->"()
    var
        lintInfoType: Integer;
    begin
    end;

    ////[Scope('Internal')]
    procedure gfncSSBImports(p_recParentClient: Record "Parent Client"; p_blnDialog: Boolean; p_txtFileName: Text[1024]; p_blnShowIndividualResults: Boolean) r_blnResult: Boolean
    var
        lintOption: Integer;
        lrecImportLog: array[4] of Record "Import Log";
        lintIndex: Integer;
        lintInfoType: Integer;
        lintDownCount: Integer;
        ltxtClientFileName: Text[1024];
    begin
        r_blnResult := gfncSSBImports1(p_recParentClient, p_blnDialog, p_txtFileName, p_blnShowIndividualResults);

        if not p_blnShowIndividualResults then begin
            //Do not show individual results, but one result at the end
            if r_blnResult then
                Message(MSG_018)
            else
                Message(MSG_019);
        end;
    end;

    ////[Scope('Internal')]
    procedure gfncSSBImports1(p_recParentClient: Record "Parent Client"; p_blnDialog: Boolean; p_txtFileName: Text[1024]; p_blnShowIndividualResults: Boolean) r_blnResult: Boolean
    var
        lintOption: Integer;
        lrecImportLog: array[4] of Record "Import Log";
        lintIndex: Integer;
        lintInfoType: Integer;
        lintDownCount: Integer;
        ltxtClientFileName: Text[1024];
    //lmdlFileMgt: Codeunit "File Management";
    begin
        //lintOption := STRMENU(MNU_001,1,DLG_006);
        lintOption := p_recParentClient."Posting Method" + 1;

        if lintOption > 0 then begin
            if p_txtFileName <> '' then
                ltxtClientFileName := p_txtFileName;
            //                         ELSE ltxtClientFileName := lmodCommonDialogManagement.OpenFile(MSG_022,'',2,'',0);
            //else
            //ltxtClientFileName := lmdlFileMgt.OpenFileDialog(MSG_022, '', ''); // MP 17-11-14 Replaces above

            if ltxtClientFileName <> '' then begin
                // Import files
                for lintIndex := 1 to 4 do begin
                    case lintIndex of
                        1:
                            lintInfoType := 1; // Local COA
                        2:
                            lintInfoType := 2; // Corp COA
                        3:
                            lintInfoType := 3; // Trial Balance
                        4:
                            lintInfoType := 4; // Local Adjustments
                    end;
                    /*if not gfncRunStage1(p_recParentClient, lintInfoType, p_blnDialog, lrecImportLog[lintIndex], ltxtClientFileName) then begin
                        if lintIndex > 1 then begin
                            // Delete previous imports here. The crashed one is deleted by by the RunStage1 process
                            for lintDownCount := lintIndex downto 1 do begin
                                lrecImportLog[lintDownCount].Delete(true); // this will delete all related info
                            end;
                        end;
                        exit(false);
                    end;*/
                    lrecImportLog[lintIndex]."Posting Method" := lintOption - 1;
                    lrecImportLog[lintIndex].Modify;
                end;

                // Process files
                //for lintIndex := 1 to 4 do begin
                //  if not gfncPostImportRun(lrecImportLog[lintIndex], p_blnDialog, p_blnShowIndividualResults) then exit(false);
                //end;

                exit(true);
            end else begin
                exit(false);
            end;
        end;
    end;

    ////[Scope('Internal')]
    procedure gfncEndToEndProcess(p_recParentClient: Record "Parent Client"; p_intInfoType: Integer; p_blnDialog: Boolean; p_txtClientFileName: Text[1024]) r_blnResult: Boolean
    var
        lrecImportLog: Record "Import Log";
        lintOption: Integer;
    begin
        case p_intInfoType of
            3, 4, 7, 8:
                lintOption := p_recParentClient."Posting Method" + 1;
            //4,7,8 : lintOption := STRMENU(MNU_001,1,DLG_006);
            else
                lintOption := 1;
        end;

        //IF p_intInfoType IN [3,4,7,8] THEN lintOption := STRMENU(MNU_001,1,DLG_006)
        //                              ELSE lintOption := 1;

        if lintOption > 0 then begin
            r_blnResult := gfncRunStage1(p_recParentClient, p_intInfoType, p_blnDialog, lrecImportLog, p_txtClientFileName);
            lrecImportLog."Posting Method" := lintOption - 1;
            lrecImportLog.Modify;

            if r_blnResult then r_blnResult := gfncPostImportRun(lrecImportLog, p_blnDialog, false);

            if r_blnResult then
                Message(MSG_018)
            else
                Message(MSG_019);
        end;
    end;

    ////[Scope('Internal')]
    procedure gfncPostImportRunConfirm(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        if Confirm(DLG_005, false, p_recImportLog."Entry No.") then begin
            //lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);
            gfncPostImportRun(p_recImportLog, p_blnDialog, true);
        end;
    end;

    ////[Scope('Internal')]
    procedure gfncPostImportRun(var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean; p_blnShowResult: Boolean) r_blnResult: Boolean
    var
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        lintStageNo: Integer;
    begin
        //lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
        //                                                  StrSubstNo(MSG_016, p_recImportLog."Entry No.",
        //                                                  Format(CurrentDateTime)));
        r_blnResult := true;
        case p_recImportLog.Stage of
            p_recImportLog.Stage::"File Import":
                lintStageNo := 2;
            p_recImportLog.Stage::"Post Import Validation":
                lintStageNo := 3;
            p_recImportLog.Stage::"Data Transfer":
                lintStageNo := 4;
            p_recImportLog.Stage::"Data Validation":
                lintStageNo := 5;
            p_recImportLog.Stage::"Record Creation/Update/Posting":
                lintStageNo := 6;
        end;

        // Last attempt failed - try again
        if (p_recImportLog.Status = p_recImportLog.Status::Error) or
           (p_recImportLog.Status = p_recImportLog.Status::"In Progress") then
            lintStageNo -= 1;

        /*if (lintStageNo <= 1) then begin
            r_blnResult := false;
            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                              StrSubstNo(ERR_015, Format(p_recImportLog.Stage),
                                                              Format(p_recImportLog.Status)));
        end;*/
        //r_blnResult := (lintStageNo > 1);
        /*while (lintStageNo <= 6) and r_blnResult do begin
            case lintStageNo of
                2:
                    r_blnResult := gfncRunStage2(p_recImportLog, p_blnDialog, false);
                3:
                    r_blnResult := gfncRunStage3(p_recImportLog, p_blnDialog, false);
                4:
                    r_blnResult := gfncRunStage4(p_recImportLog, p_blnDialog, false);
                5:
                    r_blnResult := gfncRunStage5(p_recImportLog, p_blnDialog, false);
                6:
                    r_blnResult := gfncRunStage6(p_recImportLog, false); // Do not ask user for confirmation
            end;
            lintStageNo += 1;
        end;*/
        /*
                if r_blnResult then begin
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                      StrSubstNo(MSG_017, p_recImportLog."Entry No.",
                                                                      Format(CurrentDateTime)));
                end else begin
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                      StrSubstNo(ERR_001, p_recImportLog."Entry No.",
                                                                      Format(CurrentDateTime)));
                end;

                if p_blnShowResult then begin
                    if r_blnResult then
                        Message(MSG_018)
                    else
                        Message(MSG_019);
                end;*/
    end;

    ////[Scope('Internal')]
    procedure "<-- Stage 1 related -->"()
    begin
    end;

    ////[Scope('Internal')]
    procedure gfncRunStage1(p_recParentClient: Record "Parent Client"; p_intInfoType: Integer; p_blnDialog: Boolean; var p_recImportLog: Record "Import Log"; p_txtFileName: Text[1024]) r_blnResult: Boolean
    var
        lrecImportTemplateHeader: Record "Import Template Header";
        //lmod3TierAutomationMgt: Codeunit "File Management";
        lintDefaultFileType: Integer;
        ltxtWindowTitle: Text[1024];
        ltxtConvertedClientFileName: Text[1024];
        ltxtClientFileName: Text[1024];
        ltxtServerFileName: Text[1024];
        ltxtPath: Text[1024];
        lfilFile: File;
        lblnClient: Boolean;
    begin
        r_blnResult := true;

        //
        // Find Import Template Header
        //

        case p_intInfoType of
            1:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."G/L Account Template Code");
                    ltxtWindowTitle := MSG_001;
                end;
            2:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."Corporate GL Acc. Templ. Code");
                    ltxtWindowTitle := MSG_002;
                end;
            3:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."Trial Balance Template Code");
                    ltxtWindowTitle := MSG_003;
                end;
            4:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."G/L Entry Template Code");
                    ltxtWindowTitle := MSG_004;
                end;
            5:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."Customer Template Code");
                    ltxtWindowTitle := MSG_005;
                end;
            6:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."Vendor Template Code");
                    ltxtWindowTitle := MSG_006;
                end;
            7:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."AR Template Code");
                    ltxtWindowTitle := MSG_007;
                end;
            8:
                begin
                    lrecImportTemplateHeader.Get(p_recParentClient."AP Template Code");
                    ltxtWindowTitle := MSG_008;
                end;
        end;

        case lrecImportTemplateHeader."File Format" of
            lrecImportTemplateHeader."File Format"::"Variable Delimited":
                begin
                    lintDefaultFileType := 1; // Text
                end;
            lrecImportTemplateHeader."File Format"::Excel:
                begin
                    lintDefaultFileType := 2; // Excel
                end;
        //lrecImportTemplateHeader."File Format"::Excel2007 : BEGIN
        //  lintDefaultFileType := 2; // Excel
        //END;
        end;

        if p_txtFileName <> '' then
            ltxtClientFileName := p_txtFileName;
        //ELSE ltxtClientFileName := lmodCommonDialogManagement.OpenFile(ltxtWindowTitle,'',lintDefaultFileType,'',0);
        /*else
            ltxtClientFileName := lmod3TierAutomationMgt.OpenFileDialog(ltxtWindowTitle, '', ''); // MP 17-11-14 Replaces above


        if ltxtClientFileName <> '' then begin
            //
            // Create new Import Log entry
            //
            gfncInitImportLog(p_recParentClient, lrecImportTemplateHeader, ltxtClientFileName, p_recImportLog);
            p_recImportLog.Stage := p_recImportLog.Stage::"File Import";
            p_recImportLog.Status := p_recImportLog.Status::"In Progress";
            p_recImportLog.Modify;
            //
            // Commit here so we have record of an attempt
            //
            Commit;

            // Convert xls to xlsx if necessary
            ltxtConvertedClientFileName := '';
            if lrecImportTemplateHeader."File Format" = lrecImportTemplateHeader."File Format"::Excel then begin
                if lfncGetFileExtension(ltxtClientFileName) = 'xls' then begin
                    if lfncConvertXLStoXLSX(p_recImportLog, ltxtClientFileName, ltxtConvertedClientFileName, p_blnDialog) then begin
                        ltxtClientFileName := ltxtConvertedClientFileName;
                    end else begin
                        // error
                        r_blnResult := false;
                        exit; //Message should be already in log from the lfncConvertXLStoXLSX(..)
                    end;
                end;
            end;
            //
            // lblnClient = true  - run on client
            // lblnClient = false - run on service tier
            //
            //lblnClient := NOT (ISSERVICETIER AND (lintDefaultFileType = 1)); // Run XLS locally
            lblnClient := not (IsServiceTier);
            if not lblnClient then begin
                // copy file to the server
                if not lfncServerUpload(p_recImportLog, ltxtClientFileName, ltxtServerFileName, p_blnDialog) then begin
                    // server upload failed
                    r_blnResult := false;
                end;
            end else begin
                ltxtServerFileName := ltxtClientFileName;
            end;

            if r_blnResult and (ltxtClientFileName <> '') then begin
                r_blnResult := gfncImportFile(p_recParentClient, lrecImportTemplateHeader, ltxtClientFileName,
                                    ltxtServerFileName, p_recImportLog, p_blnDialog, lblnClient);
            end;

            if not lblnClient then begin
                if not Erase(ltxtServerFileName) then;
            end;
            if ltxtConvertedClientFileName <> '' then begin
                if not Erase(ltxtConvertedClientFileName) then; // ERROR(ERR_019);
            end;
            //
            // Update Status
            //
            p_recImportLog.Stage := p_recImportLog.Stage::"File Import";
            if r_blnResult then
                p_recImportLog.Status := p_recImportLog.Status::Imported
            else
                p_recImportLog.Status := p_recImportLog.Status::Error;
            p_recImportLog.Modify;

            //IF r_blnResult THEN
            //  MESSAGE(MSG_010, ltxtClientFileName, p_recImportLog."Entry No.")
            //ELSE
            //  MESSAGE(MSG_011, ltxtClientFileName, p_recImportLog."Entry No.");
            // Show message only if dialog and failed
            if p_blnDialog and not r_blnResult then
                Message(MSG_011, ltxtClientFileName, p_recImportLog."Entry No.");
        end;*/
    end;

    // //[Scope('Internal')]
    procedure gfncImportFile(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; p_txtClientFileName: Text[1024]; p_txtServerFileName: Text[1024]; var p_recImportLog: Record "Import Log"; p_blnDialog: Boolean; p_blnLocal: Boolean) r_blnResult: Boolean
    var
        lfilInputFile: File;
        lrrefRecRef: RecordRef;
        lblnUseTempRecords: Boolean;
    begin
        //
        // Top level function
        //
        lblnUseTempRecords := false;
        //
        // Create new Import Log entry
        //
        //gfncInitImportLog(p_recParentClient, p_recImportTemplateHeader, p_txtClientFileName, p_recImportLog);
        //p_recImportLog.Stage := p_recImportLog.Stage::"File Import";
        //p_recImportLog.Status := p_recImportLog.Status::"In Progress";
        //p_recImportLog.MODIFY;
        //
        // Commit here so we have record of an attempt
        //
        //COMMIT;
        //
        // Pre-processing Checks
        //
        //r_blnResult := gfncPreImport(p_recImportTemplateHeader, p_txtServerFileName, p_recImportLog, p_blnLocal);
        //
        // Create new table recref
        //
        lrrefRecRef.Open(p_recImportTemplateHeader."Table ID", lblnUseTempRecords);
        //
        // Process Input
        //
        //if r_blnResult then // Only if previous stage was success
        //    r_blnResult := gfncImport(p_recParentClient, p_recImportTemplateHeader, p_txtServerFileName,
        //                            p_recImportLog, lrrefRecRef, p_blnDialog, p_blnLocal);
        //
        // Save to table (If used temp and success)
        //
        //if r_blnResult and lblnUseTempRecords then
        //  gfncSaveRecords(lrrefRecRef);
        //
        // Delete from table (if failed and used permanent)
        //
        //if not (r_blnResult or lblnUseTempRecords) then
        //  gfncCleanUp(p_recImportLog, lrrefRecRef);
        //
        // Update Import log
        //
        if r_blnResult then
            p_recImportLog.Status := p_recImportLog.Status::Imported
        else
            p_recImportLog.Status := p_recImportLog.Status::Error;

        p_recImportLog.Stage := p_recImportLog.Stage::"File Import";
        p_recImportLog.Modify;
    end;

    ////[Scope('Internal')]
    procedure gfncInitImportLog(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; p_txtClientFileName: Text[1024]; var p_recImportLog: Record "Import Log")
    var
        lrecSubsidiaryClient: Record "Subsidiary Client";
        lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
        lrecImportLog: Record "Import Log";
        lintEntryNo: BigInteger;
    begin
        lrecImportLog.Reset;
        if lrecImportLog.FindLast then
            lintEntryNo := lrecImportLog."Entry No." + 1
        else
            lintEntryNo := 1;
        p_recImportLog.Init;
        //p_recImportLog."Entry No." := 0; // Auto increment
        p_recImportLog."Entry No." := lintEntryNo;
        p_recImportLog."Parent Client No." := p_recParentClient."No.";
        p_recImportLog."User ID" := UserId;
        p_recImportLog."Import Date" := Today;
        p_recImportLog."Import Time" := Time;
        p_recImportLog."File Name" := p_txtClientFileName;
        p_recImportLog.Status := p_recImportLog.Status::Error;
        p_recImportLog."Table ID" := p_recImportTemplateHeader."Table ID";
        p_recImportLog."Interface Type" := p_recImportTemplateHeader."Interface Type";
        p_recImportLog.Insert(true);
    end;

    //[Scope('Internal')]
    procedure gfncPreImport(p_recImportTemplateHeader: Record "Import Template Header"; p_txtFileName: Text[1024]; var p_recImportLog: Record "Import Log"; p_blnClient: Boolean): Boolean
    var
        //lmdlFileManagement: Codeunit "File Management";
        lfilFile: File;
        lchrDummy: Char;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        //
        // Check if file exists and we can read it
        //
        /*
        if not IsServiceTier then begin
            // Classic client, local test
            lfilFile.WriteMode(false);
            lfilFile.TextMode(false);
            if not lfilFile.Open(p_txtFileName) then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_010, p_txtFileName));
                exit(false);
            end;
            if lfilFile.Read(lchrDummy) = 0 then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_002, p_txtFileName));
                exit(false);
            end;
            lfilFile.Close;
        end else begin
            if p_blnClient then begin
                // RTC, file local - use test on client

                // MP 25-May-16 Redone to not use Automation Servers >>
                //IF ISCLEAR(lautFileSystemObject) THEN
                //  CREATE(lautFileSystemObject, TRUE, TRUE); // instantiate locally
                //  IF NOT lautFileSystemObject.FileExists(p_txtFileName) THEN BEGIN
                if not lmdlFileManagement.ClientFileExists(p_txtFileName) then begin
                    // MP 25-May-16 <<
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_011, p_txtFileName));
                    exit(false);
                end;
            end else begin
                //RTC, file on server - use lfilfile
                lfilFile.WriteMode(false);
                lfilFile.TextMode(false);
                if not lfilFile.Open(p_txtFileName) then begin
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_010, p_txtFileName));
                    exit(false);
                end;
                if lfilFile.Read(lchrDummy) = 0 then begin
                    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_002, p_txtFileName));
                    exit(false);
                end;
                lfilFile.Close;
            end;
        end;

        // ToDo
        // Check mapping so it does not contain fields with unsupported data types
        // flow fields, flow filter fields
        // Create separate function so it can be called from mapping form.
        //

        exit(true);
        */
    end;

    ////[Scope('Internal')]
    procedure gfncImport(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; p_txtFileName: Text[1024]; var p_recImportLog: Record "Import Log"; var p_rrefRecRef: RecordRef; p_blnDialog: Boolean; p_blnLocal: Boolean) r_blnResult: Boolean
    var
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin
        /*case p_recImportTemplateHeader."File Format" of
            p_recImportTemplateHeader."File Format"::"Variable Delimited":
                begin
                    r_blnResult := gfncImportCSV(p_recParentClient, p_recImportTemplateHeader,
                                                 p_txtFileName, p_recImportLog,
                                                 p_rrefRecRef, p_blnDialog);
                end;
            p_recImportTemplateHeader."File Format"::Excel:
                begin
                    //r_blnResult := gfncImportXLS(p_recParentClient, p_recImportTemplateHeader,
                    r_blnResult := gfncImportXLSX(p_recParentClient, p_recImportTemplateHeader,
                                                 p_txtFileName, p_recImportLog,
                                                 p_rrefRecRef, p_blnDialog, p_blnLocal);
                end;
            //  p_recImportTemplateHeader."File Format"::Excel2007: BEGIN
            //   r_blnResult := gfncImportXLSX(p_recParentClient, p_recImportTemplateHeader,
            //                                 p_txtFileName, p_recImportLog,
            //                                 p_rrefRecRef, p_blnDialog, p_blnLocal);
            //  END;
            else begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                StrSubstNo(ERR_004, Format(p_recImportTemplateHeader."File Format")));
            end;*/
    end;

    ////[Scope('Internal')]
    procedure gfncImportCSV(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; var p_txtFileName: Text[1024]; var p_recImportLog: Record "Import Log"; var p_rrefRecRef: RecordRef; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        lfilFile: File;
        ltxtLine: Text[1024];
        lintBytesRead: Integer;
        lintLineNo: Integer;
        lintSkipLines: Integer;
        lintFileLength: Integer;
        lintTotalRead: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
    begin
        //lfilFile.WriteMode(false);
        //lfilFile.TextMode(true);
        //lfilFile.Open(p_txtFileName);
        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
            //lintFileLength := lfilFile.Len;
            lintTotalRead := 0;
        end;
        //lintBytesRead := lfilFile.Read(ltxtLine);
        lintLineNo := 1;
        r_blnResult := true;
        lintSkipLines := p_recImportTemplateHeader."Skip Header Lines";
        if lintSkipLines < 0 then lintSkipLines := 0;

        while lintSkipLines > 0 do begin // Skip header lines
            //lintBytesRead := lfilFile.Read(ltxtLine);
            lintSkipLines -= 1;
            lintLineNo += 1;
        end;
        lintLastPct := 0;
        while lintBytesRead > 0 do begin  // Loop trough all lines
            if p_blnDialog then begin
                lintTotalRead += lintBytesRead;
                if Round((lintTotalRead / lintFileLength) * 100, 1, '<') > lintLastPct then begin
                    lintLastPct := Round((lintTotalRead / lintFileLength) * 100, 1, '<');
                    ldlgDialog.Update(1, lintLastPct * 100);
                end;
            end;
            /*r_blnResult := r_blnResult and gfncImportCSVLine(p_recParentClient, p_recImportTemplateHeader, ltxtLine,
                                                           p_recImportLog, lintLineNo, p_rrefRecRef,
                                                           lfncGetLastColumnName(p_recImportTemplateHeader));
            lintBytesRead := lfilFile.Read(ltxtLine);*/
            lintLineNo += 1;
        end;

        if p_blnDialog then begin
            ldlgDialog.Close;
        end;
    end;

    ////[Scope('Internal')]
    procedure gfncImportXLSX(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; var p_txtFileName: Text[1024]; var p_recImportLog: Record "Import Log"; var p_rrefRecRef: RecordRef; p_blnDialog: Boolean; p_blnLocal: Boolean) r_blnResult: Boolean
    var
        //ldotXLSXWrapper: DotNet XLSXWrapperSAX;
        lintWorksheetNo: Integer;
        lcodColumnName: Code[10];
        lvarVariant: Variant;
        lfrefFieldRef: FieldRef;
        lintRows: Integer;
        lintColumns: Integer;
        lintCurrentRow: Integer;
        ltxtValue: Text[1024];
        ltxtRange: Text[30];
        lrecImportTemplateLine: Record "Import Template Line";
        lintLineNox: Integer;
        lintSkipLines: Integer;
        lintLastPct: Integer;
        ldlgDialog: Dialog;
        lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
        lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
        lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
        lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
        lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
    begin
        r_blnResult := true;

        if p_blnDialog then begin
            ldlgDialog.Open(DLG_001);
        end;

        lintWorksheetNo := p_recImportTemplateHeader."XLS Worksheet No.";
        lintSkipLines := p_recImportTemplateHeader."Skip Header Lines";

        //ldotXLSXWrapper := ldotXLSXWrapper.XLSXWrapperSAX(p_txtFileName, lintWorksheetNo); // this can take some time
        //lintRows := ldotXLSXWrapper.RowCount;
        /*
        lintCurrentRow := 0;
        IF ldotXLSXWrapper.GetFirstRow THEN REPEAT
          lintCurrentRow +=1;
          IF lintCurrentRow > lintSkipLines THEN BEGIN
            lfncInitRecord(p_rrefRecRef, lintCurrentRow, p_recParentClient."No.",
                           p_recImportLog."Entry No.", p_recImportTemplateHeader."Interface Type");
            p_rrefRecRef.INSERT(TRUE);
            lintLastPct := 0;
            IF ldotXLSXWrapper.GetFirstCell() THEN REPEAT
              IF p_blnDialog THEN BEGIN
                IF ROUND((lintCurrentRow/lintRows)*100,1,'<') > lintLastPct THEN BEGIN
                  lintLastPct := ROUND((lintCurrentRow/lintRows)*100,1,'<');
                  ldlgDialog.UPDATE(1, lintLastPct * 100);
                END;
              END;
              // process cell here
              lcodColumnName := ldotXLSXWrapper.CellReference;
              // Remove numerical part
              lcodColumnName := DELCHR(lcodColumnName, '<=>','0123456789');
              IF lrecImportTemplateLine.GET(p_recImportTemplateHeader.Code, lcodColumnName) THEN BEGIN
                lfrefFieldRef := p_rrefRecRef.FIELD(lrecImportTemplateLine."Field ID");
                lvarVariant := ldotXLSXWrapper.CellValue;
        
                r_blnResult := r_blnResult AND lfncConvertVariantValue(lvarVariant, p_recImportTemplateHeader,lrecImportTemplateLine,
                                                                lfrefFieldRef, lintCurrentRow, p_recImportLog);
              END;
            UNTIL ldotXLSXWrapper.GetNextCell = FALSE;
            p_rrefRecRef.MODIFY(TRUE);
        
            //
            // Specific post import processing
            //
            CASE p_rrefRecRef.NUMBER OF
              60009 : lmodDataImportMgt_60009.gfncAfterSaveRecord(p_rrefRecRef);
              60012 : lmodDataImportMgt_60012.gfncAfterSaveRecord(p_rrefRecRef);
              60018 : lmodDataImportMgt_60018.gfncAfterSaveRecord(p_rrefRecRef);
              60019 : lmodDataImportMgt_60019.gfncAfterSaveRecord(p_rrefRecRef);
              60020 : lmodDataImportMgt_60020.gfncAfterSaveRecord(p_rrefRecRef);
            END;
          END;
        UNTIL (ldotXLSXWrapper.GetNextRow() = FALSE);
        
        ldotXLSXWrapper.Close();
        */
        if p_blnDialog then begin
            ldlgDialog.Close;
        end;

        //Clear(ldotXLSXWrapper);

    end;

    ////[Scope('Internal')]
    procedure gfncImportCSVLine(var p_recParentClient: Record "Parent Client"; var p_recImportTemplateHeader: Record "Import Template Header"; var p_txtLine: Text[1024]; var p_recImportLog: Record "Import Log"; p_intLineNo: Integer; var p_rrefRecRef: RecordRef; p_codLastUsedColumnName: Code[20]) r_blnResult: Boolean
    var
        lcodColumnName: Code[2];
        lcodLastUsedColumnName: Code[2];
        lblnLast: Boolean;
        ltxtToken: Text[1024];
        lrecImportTemplateLine: Record "Import Template Line";
        lfrefFieldRef: FieldRef;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
        lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
        lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
        lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
        lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
    begin
        /*if lmodDataImportManagementCommon.gfncTextToASCII(p_recImportTemplateHeader."Field Delimiter") <>
                                                          p_recImportTemplateHeader."Field Delimiter ASCII" then begin
            p_recImportTemplateHeader."Field Delimiter ASCII" :=
                                       lmodDataImportManagementCommon.gfncTextToASCII(p_recImportTemplateHeader."Field Delimiter");
            p_recImportTemplateHeader.Modify;
        end;*/

        if p_codLastUsedColumnName = '' then p_codLastUsedColumnName := 'ZZ';
        //p_codLastUsedColumnName := lflncNormColName(p_codLastUsedColumnName);
        lcodColumnName := 'A';
        r_blnResult := true;
        lfncInitRecord(p_rrefRecRef, p_intLineNo, p_recParentClient."No.",
                       p_recImportLog."Entry No.", p_recImportTemplateHeader."Interface Type");
        p_rrefRecRef.Insert(true);
        if p_txtLine <> '' then
            //repeat
            //ltxtToken := lmodDataImportManagementCommon.gfncGetNextToken(p_txtLine, p_recImportTemplateHeader."Field Delimiter"[1],
            //ltxtToken := lmodDataImportManagementCommon.gfncGetNextToken(p_txtLine, p_recImportTemplateHeader."Field Delimiter ASCII",
            //                              p_recImportTemplateHeader."Text Qualifier"[1], lblnLast);
            /*if lrecImportTemplateLine.Get(p_recImportTemplateHeader.Code, lcodColumnName) then begin
                lfrefFieldRef := p_rrefRecRef.Field(lrecImportTemplateLine."Field ID");
                r_blnResult := r_blnResult and lfncConvertTextValue(ltxtToken, p_recImportTemplateHeader, lrecImportTemplateLine,
                                                                lfrefFieldRef, p_intLineNo, p_recImportLog);
            end;
            lcodColumnName := lfncIncrColName(lcodColumnName);
        until lblnLast or (lflncNormColName(lcodColumnName) > p_codLastUsedColumnName);*/
                p_rrefRecRef.Modify(true);
        //
        // Specific post import processing
        //
        /*
        case p_rrefRecRef.Number of
            60009:
                lmodDataImportMgt_60009.gfncAfterSaveRecord(p_rrefRecRef);
            60012:
                lmodDataImportMgt_60012.gfncAfterSaveRecord(p_rrefRecRef);
            60018:
                lmodDataImportMgt_60018.gfncAfterSaveRecord(p_rrefRecRef);
            60019:
                lmodDataImportMgt_60019.gfncAfterSaveRecord(p_rrefRecRef);
            60020:
                lmodDataImportMgt_60020.gfncAfterSaveRecord(p_rrefRecRef);
        end;*/
    end;

    //[Scope('Internal')]
    procedure gfncSaveRecords(var p_rrefRecRef: RecordRef)
    var
        lrrRecRef: RecordRef;
        lfrFieldRef: FieldRef;
        lfrTmpFieldRef: FieldRef;
        lbintBigInt: BigInteger;
        lintFieldIndex: Integer;
    begin
        if p_rrefRecRef.IsTemporary then begin
            lrrRecRef.Open(p_rrefRecRef.Number);
            if p_rrefRecRef.Find('-') then
                repeat
                    lrrRecRef.Init;
                    lintFieldIndex := 1;
                    while lintFieldIndex <= p_rrefRecRef.FieldCount do begin
                        lfrTmpFieldRef := p_rrefRecRef.FieldIndex(lintFieldIndex);
                        lfrFieldRef := lrrRecRef.FieldIndex(lintFieldIndex);
                        lfrFieldRef.Value := lfrTmpFieldRef.Value;
                        lintFieldIndex += 1;
                    end;
                    lfrFieldRef := lrrRecRef.Field(99999);
                    lfrFieldRef.Value := 0;
                    lrrRecRef.Insert;
                until p_rrefRecRef.Next = 0;
        end;
    end;

    //[Scope('Internal')]
    procedure gfncCleanUp(var p_recImportLog: Record "Import Log"; var p_rrefRecRef: RecordRef)
    var
        lrrRecRef: RecordRef;
        lffFieldRef: FieldRef;
    begin
        lrrRecRef.Open(p_rrefRecRef.Number);
        lffFieldRef := lrrRecRef.Field(99998);
        lffFieldRef.SetFilter(Format(p_recImportLog."Entry No."));
        lrrRecRef.DeleteAll;
    end;

    //[Scope('Internal')]
    procedure lfncConvertXLStoXLSX(var p_recImportLog: Record "Import Log"; p_txtXLSFileName: Text[1024]; var p_txtXLSXFileName: Text[1024]; p_blnDialog: Boolean) r_blnResult: Boolean
    var
        /*
            [RunOnClient]
            ldotXlApp: DotNet ApplicationClass;
            [RunOnClient]
            ldotXlWrkBk: DotNet Workbook;
            [RunOnClient]
            ldotXlHelper: DotNet ExcelHelper;
            [RunOnClient]
            ldotXlFileFormat: DotNet XlFileFormat;
            [RunOnClient]
            ldotXlSaveAsAccessMode: DotNet XlSaveAsAccessMode;*/
        ltxtVersion: Text[30];
        lfilFile: File;
        ldecVersion: Decimal;
        ldlgDialog: Dialog;
        lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
    begin

        r_blnResult := true;
        p_txtXLSXFileName := CopyStr(p_txtXLSFileName, 1, StrPos(p_txtXLSFileName, '.xls')) + 'xlsx';

        // MP 25-May-16 Redone to use .NET >>
        //CREATE(lautXLSApplication, TRUE, TRUE);
        //lautXLSApplication.Visible := FALSE;
        // Check Excel version
        //ltxtVersion := lautXLSApplication.Version;

        /*ldotXlApp := ldotXlApp.ApplicationClass;
        ldotXlApp.Visible := false;
        // Check Excel version
        ltxtVersion := ldotXlApp.Version;
        // MP 25-May-16 <<
        if StrPos(ltxtVersion, '.') > 0 then
            ltxtVersion := CopyStr(ltxtVersion, 1, StrPos(ltxtVersion, '.') - 1);
        if not Evaluate(ldecVersion, ltxtVersion) then begin
            // Error - strange version
            r_blnResult := false;
            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                           StrSubstNo(ERR_024, ltxtVersion));
        end;

        if ldecVersion < 12 then begin
            // Error wrong client version
            r_blnResult := false;
            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                           StrSubstNo(ERR_025, ltxtVersion));
        end;*/

        // Check we can write to the directory
        // Caused problems on RTC - disabled
        //lfilFile.WRITEMODE(TRUE);
        //lfilFile.TEXTMODE(TRUE);
        //IF NOT lfilFile.CREATE(p_txtXLSXFileName) THEN BEGIN
        //  // Cannot create file
        //  r_blnResult := FALSE;
        //  lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
        //                                 STRSUBSTNO(ERR_026, p_txtXLSXFileName));
        //END;
        //lfilFile.WRITE('A');
        //lfilFile.CLOSE();
        //error('After file close');
        //
        //IF NOT ERASE(p_txtXLSXFileName) THEN BEGIN
        //  r_blnResult := FALSE;
        //  lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
        //                                 STRSUBSTNO(ERR_027, p_txtXLSXFileName));
        //END;

        //error('Before automation');

        // MP 25-May-16 Redone to use .NET >>
        //IF r_blnResult THEN BEGIN
        //  lautXLSWorkbooks := lautXLSApplication.Workbooks;
        //  lautXLSWorkbook := lautXLSWorkbooks.Open(p_txtXLSFileName);
        //  lautXLSWorkbook.SaveAs(p_txtXLSXFileName, 51);
        //  lautXLSWorkbook.Close();
        //  CLEAR(lautXLSWorkbooks);
        //  CLEAR(lautXLSWorkbook);
        //END;
        //CLEAR(lautXLSApplication);
        /*
        ldotXlWrkBk := ldotXlHelper.CallOpen(ldotXlApp,p_txtXLSFileName);
        ldotXlWrkBk.SaveAs(p_txtXLSXFileName,ldotXlFileFormat.xlWorkbookDefault,'','',FALSE,FALSE,ldotXlSaveAsAccessMode.xlNoChange,'',FALSE,'','',TRUE);
        
        CLEAR(ldotXlWrkBk);
        ldotXlHelper.CallQuit(ldotXlApp);
        CLEAR(ldotXlApp);
        */
        // MP 25-May-16 <<

    end;

    local procedure lfncInitRecord(var p_rrefRecRef: RecordRef; p_intLineNo: Integer; p_codClientID: Code[20]; p_bintImportLogEntryNo: BigInteger; p_optInterfaceType: Option "Trial Balance","GL Transactions","AR Transactions",APTransactions,"Chart Of Accounts","Corporate Chart Of Accounts",Customer,Vendor)
    var
        lfrefFieldRef: FieldRef;
        lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
        lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
        lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
        lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
        lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
    begin
        p_rrefRecRef.Init;

        //99000 Interface Type - only if exists
        if p_rrefRecRef.FieldExist(99000) then begin
            lfrefFieldRef := p_rrefRecRef.Field(99000);
            lfrefFieldRef.Value(p_optInterfaceType);
        end;

        //99994 Company No.   In file - cant be populated here

        //99995 Client No.  Parent client
        lfrefFieldRef := p_rrefRecRef.Field(99995);
        lfrefFieldRef.Value(p_codClientID);

        //99996 User ID
        lfrefFieldRef := p_rrefRecRef.Field(99996);
        lfrefFieldRef.Value(UserId);

        //99997 Status - Leave defaul value

        //99998 Import Log Entry No.
        lfrefFieldRef := p_rrefRecRef.Field(99998);
        lfrefFieldRef.Value(p_bintImportLogEntryNo);

        //99999 Entry No.
        lfrefFieldRef := p_rrefRecRef.Field(99999);
        if p_rrefRecRef.IsTemporary then
            lfrefFieldRef.Value(p_intLineNo)
        else
            lfrefFieldRef.Value(0);
        //
        // Table specific record initialization
        //
        /*case p_rrefRecRef.Number of
            60009:
                lmodDataImportMgt_60009.gfncAfterInitRecord(p_rrefRecRef);
            60012:
                lmodDataImportMgt_60012.gfncAfterInitRecord(p_rrefRecRef);
            60018:
                lmodDataImportMgt_60018.gfncAfterInitRecord(p_rrefRecRef);
            60019:
                lmodDataImportMgt_60019.gfncAfterInitRecord(p_rrefRecRef);
            60020:
                lmodDataImportMgt_60020.gfncAfterInitRecord(p_rrefRecRef);
        end;*/
    end;
    /*
        local procedure lfncConvertTextValue(p_txtText: Text[1024]; var p_recImportTemplateHeader: Record "Import Template Header"; var p_recImportTemplateLine: Record "Import Template Line"; var p_frefFieldRef: FieldRef; p_intLineNo: Integer; var p_recImportLog: Record "Import Log") r_blnResult: Boolean
        var
            ltxtType: Text[30];
            ltxtConverted: Text[1024];
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            r_blnResult := true;
            //
            // Pre-format some data types
            //
            ltxtType := Format(p_frefFieldRef.Type);
            case ltxtType of
                'Date':
                    begin
                        if lfncConvertDate(p_txtText, ltxtConverted,
                                              p_recImportTemplateHeader."Date Format") then begin
                            p_txtText := ltxtConverted;
                        end else begin
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                StrSubstNo(ERR_007, p_txtText, p_intLineNo, p_recImportTemplateLine.Column));
                            exit(false);
                        end;
                    end;
                'Decimal':
                    begin
                        if p_txtText = '' then p_txtText := '0'; // Handle null values
                        if lfncConvertDecimal(p_txtText, ltxtConverted,
                                              p_recImportTemplateHeader."Decimal Symbol"[1],
                                              p_recImportTemplateHeader."Thousand Separator"[1]) then begin
                            p_txtText := ltxtConverted;
                        end else begin
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                StrSubstNo(ERR_006, p_txtText, p_intLineNo, p_recImportTemplateLine.Column));
                            exit(false);
                        end;
                    end;
                'Text':
                    begin
                        if StrLen(p_txtText) > p_frefFieldRef.Length then begin
                            p_txtText := CopyStr(p_txtText, 1, p_frefFieldRef.Length); // Truncate text
                        end;
                    end;
                'Code':
                    begin
                        if StrLen(p_txtText) > p_frefFieldRef.Length then begin // For code, throw error
                            lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                StrSubstNo(ERR_008, CopyStr(p_txtText, 1, 20), p_frefFieldRef.Length, p_intLineNo, p_recImportTemplateLine.Column));
                            exit(false);
                        end;
                    end;
            end;

            //
            // Generic conversion
            //
            if not lfncSetFieldValue(p_frefFieldRef, p_txtText, p_recImportLog) then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                    StrSubstNo(ERR_003, p_txtText, p_intLineNo, p_recImportTemplateLine.Column, p_frefFieldRef.Type));
                r_blnResult := false;
            end;
        end;

        local procedure lfncConvertVariantValue(p_varVariant: Variant; var p_recImportTemplateHeader: Record "Import Template Header"; var p_recImportTemplateLine: Record "Import Template Line"; var p_frefFieldRef: FieldRef; p_intLineNo: Integer; var p_recImportLog: Record "Import Log") r_blnResult: Boolean
        var
            ltxtType: Text[30];
            ltxtText: Text[1024];
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            ldtDatetime: DateTime;
        begin
            r_blnResult := true;
            //
            // Try direct conversion first
            //
            ltxtType := Format(p_frefFieldRef.Type);
            case true of
                p_varVariant.IsBoolean:
                    if ltxtType = 'Boolean' then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
                p_varVariant.IsOption:
                    if ltxtType = 'Option' then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
                p_varVariant.IsInteger:
                    if ltxtType in ['Integer', 'BigInteger'] then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
                p_varVariant.IsDecimal:
                    if ltxtType = 'Decimal' then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
                p_varVariant.IsText,
                p_varVariant.IsCode:
                    begin
                        if ltxtType = 'Code' then begin
                            p_frefFieldRef.Value(p_varVariant);
                            exit(true);
                        end;
                        if ltxtType = 'Text' then begin
                            ltxtText := p_varVariant;
                            if StrLen(ltxtText) > p_frefFieldRef.Length then begin
                                ltxtText := CopyStr(ltxtText, 1, p_frefFieldRef.Length); // Truncate text
                            end;
                            p_frefFieldRef.Value(ltxtText);
                            exit(true);
                        end;
                    end;
                p_varVariant.IsDate:
                    if ltxtType = 'Date' then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
                p_varVariant.IsTime:
                    if ltxtType = 'Time' then begin
                        p_frefFieldRef.Value(p_varVariant);
                        exit(true);
                    end;
            end;

            ltxtText := DelChr(Format(p_varVariant, 250, 9), '<>');

            //
            // Try if this is not datetime (p_varVariant.ISDATETIME method is missing)
            //
            if Evaluate(ldtDatetime, ltxtText, 9) then begin
                if ltxtType = 'DateTime' then begin
                    p_frefFieldRef.Value(ldtDatetime);
                    exit(true);
                end;
                if ltxtType = 'Date' then begin
                    p_frefFieldRef.Value(DT2Date(ldtDatetime));
                    exit(true);
                end;
                if ltxtType = 'Time' then begin
                    p_frefFieldRef.Value(DT2Time(ldtDatetime));
                    exit(true);
                end;
            end;

            //
            // Try Text value conversion
            //
            r_blnResult := r_blnResult and lfncConvertTextValue(ltxtText, p_recImportTemplateHeader, p_recImportTemplateLine,
                                                            p_frefFieldRef, p_intLineNo, p_recImportLog);
        end;

        local procedure lfncGetLastColumnName(p_recImportTemplateHeader: Record "Import Template Header") r_codValue: Code[2]
        var
            lrecImportTemplateLine: Record "Import Template Line";
            lcodValue1: Code[2];
            lcodValue2: Code[2];
        begin
            r_codValue := '';
            lcodValue2 := '';
            lrecImportTemplateLine.SetRange("Template Header Code", p_recImportTemplateHeader.Code);
            if lrecImportTemplateLine.FindSet(false) then
                repeat
                    lcodValue1 := lflncNormColName(lrecImportTemplateLine.Column);
                    if lcodValue1 > lcodValue2 then begin
                        r_codValue := lrecImportTemplateLine.Column;
                        lcodValue2 := lflncNormColName(r_codValue)
                    end;
                until lrecImportTemplateLine.Next = 0;
        end;

        local procedure lfncIncrColName(var p_codColName: Code[2]) r_codValue: Code[2]
        var
            lchr0: Char;
            lchr1: Char;
        begin
            r_codValue := 'A';
            if p_codColName <> '' then begin
                lchr0 := p_codColName[2];
                if lchr0 = 0 then
                    lchr0 := p_codColName[1]
                else
                    lchr1 := p_codColName[1];
                lchr0 += 1;
                if lchr0 > 'Z' then begin
                    lchr1 += 1;
                    if lchr1 = 1 then lchr1 := 'A';
                    if lchr1 > 'Z' then lchr1 := 0;
                    lchr0 := 'A';
                end;
                r_codValue := Format(lchr0);
                if lchr1 > 0 then r_codValue := Format(lchr1) + r_codValue;
            end;
        end;

        local procedure lflncNormColName(p_codColName: Code[2]) r_codValue: Code[2]
        begin
            //
            // Normalize column name so they are sorted as A,B,...,AA,AB (not the A,AA,B,BB)
            //
            r_codValue := p_codColName;
            if StrLen(r_codValue) = 1 then r_codValue := '.' + r_codValue
        end;

        local procedure lfncSetFieldValue(var p_frefFieldRef: FieldRef; p_txtValue: Text[1024]; var p_recImportLog: Record "Import Log"): Boolean
        var
            ltxtType: Text[30];
            lintValue: Integer;
            lintOptionCount: Integer;
            ltxtValue: Text[1024];
            lcodValue: Code[1024];
            ldecValue: Decimal;
            loptValue: Option;
            lblnValue: Boolean;
            ldatValue: Date;
            ltimValue: Time;
            lbinValue: Binary[100];
            ldfValue: DateFormula;
            lbintValue: BigInteger;
            ldurValue: Duration;
            lguidValue: Guid;
            lrecidValue: RecordID;
            ldtValue: DateTime;
            lblnOptionAsInteger: Boolean;
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            ltxtValue := p_txtValue;
            ltxtType := Format(p_frefFieldRef.Type);
            case ltxtType of
              'Integer' : begin
                   if not Evaluate(lintValue, ltxtValue, 9) then exit(false);
                   p_frefFieldRef.Value(lintValue);
                 end;
              'BigInteger' : begin
                   if not Evaluate(lintValue, ltxtValue, 9) then exit(false);
                   p_frefFieldRef.Value(lintValue);
                 end;
              'Text'    : begin
                   ltxtValue := ltxtValue;
                   p_frefFieldRef.Value(ltxtValue);
                 end;
              'Code'    : begin
                   lcodValue := UpperCase(ltxtValue);
                   p_frefFieldRef.Value(lcodValue);
                 end;
              'Decimal' : begin
                   if not Evaluate(ldecValue, ltxtValue, 9) then exit(false);
                   p_frefFieldRef.Value(ldecValue);
                 end;
              'Option'  : begin
                     if not Evaluate(lintValue, ltxtValue, 9) then begin
                       lintValue := lfncOptionToInt(p_frefFieldRef.OptionString, ltxtValue);
                     end else begin
                       if lintValue > lfncLastOptionNo(p_frefFieldRef.OptionString) then exit(false);
                     end;
                     if lintValue = -1 then exit(false);
                   p_frefFieldRef.Value(lintValue);
                 end;
              'Boolean' : begin
                   if not Evaluate(lblnValue, ltxtValue, 9) then exit(false);
                   p_frefFieldRef.Value(lblnValue);
                 end;
              'Date'    : begin
                   if not Evaluate(ldatValue, ltxtValue, 9) then exit(false);
                   if ldatValue < 17540101D then ldatValue := 0D;  // All dates before 01011754 are assumed to be 0D
                   p_frefFieldRef.Value(ldatValue);
                 end;
              'Time'    : begin
                   if not Evaluate(ltimValue, ltxtValue, 9) then exit(false);
                   p_frefFieldRef.Value(ltimValue);
                 end;
              'DateTime'    : begin
                   if not Evaluate(ldtValue, ltxtValue, 9) then exit(false);
                   if ldtValue < CreateDateTime(17540101D,0T) then ldtValue := CreateDateTime(0D,0T);
                   p_frefFieldRef.Value(ldtValue);
                 end;
               else begin
                 lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_005, ltxtType, p_frefFieldRef.Name));
                 exit(false); // Unsupported data type
               end;
            end;
            exit(true);
        end;

        local procedure lfncOptionToInt(p_txtOptionString: Text[1024];p_txtOption: Text[1024]) r_intValue: Integer
        var
            lintPosition: Integer;
            lintCounter: Integer;
            lintLength: Integer;
        begin
            r_intValue := 0;
            if p_txtOption = '' then p_txtOption := ' ';
            lintPosition := StrPos(p_txtOptionString, p_txtOption);
            if lintPosition = 1 then begin
              r_intValue := 0;
            end else begin
              if  lintPosition > 0 then begin
                p_txtOptionString := CopyStr(p_txtOptionString, 1, lintPosition-1);
                lintLength := StrLen(p_txtOptionString);
                lintCounter := 1;
                while lintCounter <= lintLength do begin
                  if p_txtOptionString[lintCounter] = ',' then r_intValue += 1;
                  lintCounter += 1;
                end;
              end else begin
                r_intValue := -1;
              end;
            end;
        end;

        local procedure lfncLastOptionNo(p_txtOptionString: Text[1024]) r_intValue: Integer
        var
            lintPosition: Integer;
            lintCounter: Integer;
            lintLength: Integer;
        begin
            r_intValue := 0;
            lintLength := StrLen(p_txtOptionString);
            lintCounter := 1;
            while lintCounter <= lintLength do begin
              if p_txtOptionString[lintCounter] = ',' then r_intValue += 1;
              lintCounter += 1;
            end;
        end;

        local procedure lfncConvertDecimal(p_txtOriginal: Text[1024];var p_txtConverted: Text[1024];p_chrDecimalSymbol: Char;p_chrThousandDelimiter: Char): Boolean
        var
            i: Integer;
            ldecDecimal: Decimal;
            lintDecimalPosition: Integer;
            lint: Integer;
            ltxtText: Text[30];
        begin
            p_txtConverted := p_txtOriginal;
            //
            // Check string if contains only numbers, spaces decimal and thousand separator
            // if not return original string. do not attempt to do anything else
            //
            for i := 1 to StrLen(p_txtOriginal) do
              if not(p_txtOriginal[i] in ['0'..'9',' ', '-', '+', p_chrDecimalSymbol, p_chrThousandDelimiter]) then
                exit(false);

            // Check if there is only one decimal symbol and get its position from right
            i := StrLen(p_txtOriginal);
            lintDecimalPosition := 0;
            while i > 0 do begin
              if p_txtOriginal[i] = p_chrDecimalSymbol then begin
                if lintDecimalPosition > 0 then exit(false); // second decimal symbol - error
                lintDecimalPosition := i;
              end;
              i -= 1;
            end;

            // Clear out all spaces
            p_txtConverted := DelChr(p_txtConverted, '<=>', ' ');

            // Clear out all thousand separators
            p_txtConverted := DelChr(p_txtConverted, '<=>', Format(p_chrThousandDelimiter));

            // The '.' is default XML decimal delimiter
            if p_chrDecimalSymbol <> '.' then begin
              p_txtConverted := ConvertStr(p_txtConverted, Format(p_chrDecimalSymbol), '.');
            end;

            if p_txtConverted[1] = '+' then p_txtConverted := CopyStr(p_txtConverted, 2);

            exit(Evaluate(ldecDecimal, p_txtConverted, 9)); // Make sure string can be evaluated
        end;

        local procedure lfncConvertDate(p_txtOriginal: Text[1024];var p_txtConverted: Text[1024];p_txtDateFormat: Text[30]): Boolean
        var
            lintDummy: Integer;
            lintDay: Integer;
            lintMonth: Integer;
            lintYear: Integer;
            lintActiveBlock: Integer;
            lintPFormat: Integer;
            lintPOriginal: Integer;
            lintFChars: Integer;
            lintOChars: Integer;
            lblnDelimiter: Boolean;
            lblnLeap: Boolean;
            ldatDate: Date;
            lchrFChar: Char;
            lchrOChar: Char;
        begin
            p_txtConverted  := p_txtOriginal;
            if p_txtDateFormat = '' then exit(false);
            p_txtDateFormat := UpperCase(p_txtDateFormat);
            lintFChars      := StrLen(p_txtDateFormat);
            lintOChars      := StrLen(p_txtOriginal);
            lintPFormat     := 0;
            lintPOriginal   := 0;

            repeat
              if lintPFormat < lintFChars then lintPFormat += 1;
              lchrFChar := p_txtDateFormat[lintPFormat];
              lblnDelimiter := false;
              case lchrFChar of
                'D' : lintActiveBlock := 1;
                'M' : lintActiveBlock := 2;
                'Y' : lintActiveBlock := 3;
                else
                  lblnDelimiter := true;
              end;
              lintPOriginal += 1;
              if lintPOriginal > lintOChars then exit(false); // we run out of characters
              lchrOChar := p_txtOriginal[lintPOriginal];
              if lchrOChar in ['0'..'9'] then begin
                Evaluate(lintDummy, Format(lchrOChar));
                case lintActiveBlock of
                  1 : lintDay := lintDay*10 + lintDummy;
                  2 : lintMonth := lintMonth*10 + lintDummy;
                  3 : lintYear := lintYear*10 + lintDummy;
                end;
              end else begin
                if not lblnDelimiter then exit(false); // Expecting number
              end;
              if lblnDelimiter then begin
                if lchrFChar <> lchrOChar then lintPOriginal += 1;
              end;
            until (lintPFormat = lintFChars) and (lintPOriginal = lintOChars);

            if lintYear < 100 then
              if lintYear < 80 then lintYear += 2000
                               else lintYear += 1900;

            // Check validity of day month etc
            if (lintMonth < 1) or (lintMonth > 12) then exit(false);
            if (lintDay < 1) or (lintDay > 31) then exit(false);
            if (lintMonth in [4,6,9,11]) and (lintDay > 30) then exit(false);
            // Leap years between 1980 and 2079 - every 4th.
            // the only year here divisible by 100 is 2000, which is also leap - divisible by 400)
            lblnLeap := ((lintYear mod 4) = 0);
            if lintMonth = 2 then begin
              if (lblnLeap and (lintDay > 29)) then exit(false);
              if ((not lblnLeap) and (lintDay > 28)) then exit(false);
            end;

            p_txtConverted:= Format(DMY2Date(lintDay, lintMonth, lintYear), 10, 9);
            exit(Evaluate(ldatDate, p_txtConverted, 9)); // Make sure string can be evaluated
        end;

        local procedure lfncServerUpload(var p_recImportLog: Record "Import Log";p_txtClientFullFileName: Text[1024];var p_txtServerFullFileName: Text[1024];p_blnShowDialog: Boolean) r_blnValue: Boolean
        var
            lmdlFileManagement: Codeunit "File Management";
            lfilFile: File;
            listrInStream: InStream;
            xlistrInStream2: InStream;
            lostrOutStream: OutStream;
            ltxtDummy: Text[1024];
            ltxtMagicFullFileName: Text[1024];
            ltxtMagicPath: Text[1024];
            ltxtTmpFullFileName: Text[1024];
            ltxtTmpFilePath: Text[1024];
            ltxtClientFileName: Text[1024];
            ltxtServerFileName: Text[1024];
            ldlgDialog: Dialog;
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            r_blnValue := true;
            if p_blnShowDialog then begin
              ldlgDialog.Open(DLG_002);
              ldlgDialog.Update(1, MSG_012);
            end;

            // Get Client file name
            ltxtClientFileName := lfncGetFileName(p_txtClientFullFileName);
            // Create server temporary file
            lfilFile.CreateTempFile;
            ltxtTmpFilePath := lfncGetFilePath(lfilFile.Name);


            // Try delete all previous tmp files
            //ltxtDummy := 'cmd /c del ' + ltxtTmpFilePath + '\*.* ';
            //CREATE(lautWsShell, TRUE, FALSE);
            //lautWsShell.Exec(ltxtDummy);
            //CLEAR(lautWsShell);

            // Build Server side file name
            //ltxtServerFileName := lfncGetFileName(lfilFile.NAME) + '.' + lfncGetFileExtension(ltxtClientFileName); // xxxx.tmp.xlsx
            ltxtServerFileName := lfncGetFileName(lfilFile.Name);  // leave file name as .tmp
            //ltxtServerFileName := ltxtClientFileName;
            lfilFile.CreateInStream(listrInStream);
            // Download server temp file to local Magic path
            DownloadFromStream(listrInStream, '', '<TEMP>', '', ltxtMagicFullFileName);
            lfilFile.Close();
            Clear(listrInStream);

            // MP 25-May-16 Redone to not use Automation Servers >>
            //IF ISCLEAR(lautFileSystemObject) THEN
            //  CREATE(lautFileSystemObject, TRUE, TRUE);
            // MP 25-May-16 <<

            // Build full server file name
            p_txtServerFullFileName := ltxtTmpFilePath + ltxtServerFileName;

            ltxtMagicPath := lfncGetFilePath(ltxtMagicFullFileName);

            // Copy local file to magic path
            // MP 25-May-16 Redone to not use Automation Servers >>
            //lautFileSystemObject.CopyFile(p_txtClientFullFileName, ltxtMagicPath+ltxtServerFileName, TRUE);
            lmdlFileManagement.CopyClientFile(p_txtClientFullFileName, ltxtMagicPath+ltxtServerFileName, true);
            // MP 25-May-16 <<

            if p_blnShowDialog then begin
              ldlgDialog.Update(1, MSG_013);
            end;

            // Upload file from Magic path to server
            if not Upload('', '<TEMP>', '', ltxtServerFileName, p_txtServerFullFileName) then begin
              r_blnValue := false;
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0,StrSubstNo(ERR_028,ltxtClientFileName, GetLastErrorText));
            end;

            //
            // Uploadintostream is leaving temp file on the server
            //
            //IF UPLOADINTOSTREAM('', '<TEMP>', '', ltxtServerFileName, listrInStream) THEN BEGIN
            //  IF p_blnShowDialog THEN BEGIN
            //    ldlgDialog.UPDATE(1, MSG_014);
            //  END;
            //  lfilFile.WRITEMODE(TRUE);
            //  IF lfilFile.CREATE(p_txtServerFullFileName) THEN BEGIN
            //    lfilFile.CREATEOUTSTREAM(lostrOutStream);
            //    COPYSTREAM(lostrOutStream, listrInStream);
            //    lfilFile.CLOSE;
            //    CLEAR(lostrOutStream);
            //  END ELSE BEGIN
            //    r_blnValue := FALSE;
            //    lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0,STRSUBSTNO(ERR_022,p_txtServerFullFileName));
            //  END;
            //END ELSE BEGIN
            //  r_blnValue := FALSE;
            //  lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog,0,STRSUBSTNO(ERR_023,ltxtClientFileName, GETLASTERRORTEXT));
            //END;

            //CLEAR(listrInStream);

            // Delete files from Local MagicPath
            // MP 25-May-16 Redone to not use Automation Servers >>
            //IF lautFileSystemObject.FileExists(ltxtMagicFullFileName) THEN
            //  lautFileSystemObject.DeleteFile(ltxtMagicFullFileName);
            //
            //IF lautFileSystemObject.FileExists(ltxtMagicPath + ltxtServerFileName) THEN
            //  lautFileSystemObject.DeleteFile(ltxtMagicPath + ltxtServerFileName);

            lmdlFileManagement.DeleteClientFile(ltxtMagicFullFileName);
            lmdlFileManagement.DeleteClientFile(ltxtMagicPath + ltxtServerFileName);
            // MP 25-May-16 <<

            if p_blnShowDialog then begin
              ldlgDialog.Close;
            end;

            ClearAll;
        end;

        local procedure lfncGetFileName(p_txtFullFileName: Text[1024]): Text[1024]
        var
            i: Integer;
        begin
            i := StrLen(p_txtFullFileName);
            while i > 0 do begin
              if p_txtFullFileName[i] = '\' then exit(CopyStr(p_txtFullFileName, i+1));
              i -= 1;
            end;
        end;

        local procedure lfncGetFileExtension(p_txtFullFileName: Text[1024]): Text[1024]
        var
            i: Integer;
        begin
            i := StrLen(p_txtFullFileName);
            while i > 0 do begin
              if p_txtFullFileName[i] = '.' then exit(CopyStr(p_txtFullFileName, i+1));
              i -= 1;
            end;
        end;

        local procedure lfncGetFilePath(p_txtFullFileName: Text[1024]): Text[1024]
        var
            i: Integer;
        begin
            i := StrLen(p_txtFullFileName);
            while i > 0 do begin
              if p_txtFullFileName[i] = '\' then exit(CopyStr(p_txtFullFileName, 1, i));
              i -= 1;
            end;
        end;

        //[Scope('Internal')]
        procedure "<-- Stage 2 related -->"()
        begin
        end;

        //[Scope('Internal')]
        procedure gfncRunStage2(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean;p_blnDeleteErrorLog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            p_recImportLog.Stage := p_recImportLog.Stage::"Post Import Validation";
            p_recImportLog.Status := p_recImportLog.Status::"In Progress";
            p_recImportLog.Modify;
            Commit;

            // Delete old Import log entries
            if p_blnDeleteErrorLog then lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

            r_blnResult := true;
            r_blnResult := r_blnResult and gfncCheckCompanies(p_recImportLog, p_blnDialog);
            r_blnResult := r_blnResult and gfncValidateImportRecords(p_recImportLog, p_blnDialog);
            r_blnResult := r_blnResult and gfncCheckPostingDateRange(p_recImportLog, p_blnDialog);
            r_blnResult := r_blnResult and gfncUpdateDateRange(p_recImportLog, p_blnDialog);

            if not r_blnResult then begin
              // Roll-Back
              lmodDataImportManagementCommon.gfncDeleteEntries(p_recImportLog."Entry No.", p_recImportLog."Table ID", p_blnDialog);
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_013, p_recImportLog."Entry No."));
              p_recImportLog.Status := p_recImportLog.Status::Error;
            end else begin
              p_recImportLog.Status := p_recImportLog.Status::Processed;
            end;
            p_recImportLog.Modify(true);
        end;

        //[Scope('Internal')]
        procedure gfncValidateImportRecords(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
            lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
            lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
            lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
        begin
            r_blnResult := true;
            case p_recImportLog."Table ID" of
              60009 : r_blnResult := r_blnResult and lmodDataImportMgt_60009.gfncValidateImportRec(p_recImportLog, p_blnDialog);
              60012 : r_blnResult := r_blnResult and lmodDataImportMgt_60012.gfncValidateImportRec(p_recImportLog, p_blnDialog);
              60018 : r_blnResult := r_blnResult and lmodDataImportMgt_60018.gfncValidateImportRec(p_recImportLog, p_blnDialog);
              60019 : r_blnResult := r_blnResult and lmodDataImportMgt_60019.gfncValidateImportRec(p_recImportLog, p_blnDialog);
              60020 : r_blnResult := r_blnResult and lmodDataImportMgt_60020.gfncValidateImportRec(p_recImportLog, p_blnDialog);
              else begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_009, p_recImportLog."Table ID"));
              end;
            end;
        end;

        //[Scope('Internal')]
        procedure gfncCheckCompanies(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrrRecRef: RecordRef;
            lfrCompanyNo: FieldRef;
            lfrImportLog: FieldRef;
            lrecTmpCustomer: Record Customer temporary;
            lrecSubsidiaryClient: Record "Subsidiary Client";
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
            ldlgDialog: Dialog;
            lintTotal: Integer;
            lintPosition: Integer;
            lintLastPct: Integer;
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            lrrRecRef.Open(p_recImportLog."Table ID");
            lfrImportLog := lrrRecRef.Field(99998);
            lfrCompanyNo := lrrRecRef.Field(99994);
            lfrImportLog.SetRange(p_recImportLog."Entry No.");
            r_blnResult := true;
            if p_blnDialog then begin
              ldlgDialog.Open(DLG_003);
              ldlgDialog.Update(1, MSG_015);
              lintTotal := lrrRecRef.Count;
              lintPosition := 0;
            end;
            //
            // Make list of unique values
            //
            lrecTmpCustomer.DeleteAll;
            lintLastPct := 0;
            if lrrRecRef.FindSet(false) then repeat
              if p_blnDialog then begin
                lintPosition += 1;
                if Round((lintPosition/lintTotal)*100,1,'<') > lintLastPct then begin
                  lintLastPct := Round((lintPosition/lintTotal)*100,1,'<');
                  ldlgDialog.Update(2, lintLastPct * 100);
                end;
              end;
              lrecTmpCustomer."No." := lfrCompanyNo.Value;
              if lrecTmpCustomer."No." <> '' then
                if not lrecTmpCustomer.Insert(false) then ;
            until lrrRecRef.Next = 0;
            //
            // Check the list against existing records
            //
            lrecTmpCustomer.Reset;
            lrecSubsidiaryClient.SetCurrentKey("Company No.");
            if lrecTmpCustomer.FindSet(false) then repeat
              lrecSubsidiaryClient.SetRange("Company No.", lrecTmpCustomer."No.");
              lrecSubsidiaryClient.SetRange("Parent Client No.", p_recImportLog."Parent Client No.");
              if not lrecSubsidiaryClient.Find('-') then begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_012, lrecTmpCustomer."No."));
              end;
            until lrecTmpCustomer.Next = 0;
            //
            // If success create subs. import entries
            //
            if r_blnResult then begin
              lrecTmpCustomer.Reset;
              lrecSubsidiaryClient.SetCurrentKey("Company No.");
              if lrecTmpCustomer.FindSet(false) then repeat
                lrecSubsidiaryClient.SetRange("Company No.", lrecTmpCustomer."No.");
                lrecSubsidiaryClient.SetRange("Parent Client No.", p_recImportLog."Parent Client No.");
                lrecSubsidiaryClient.Find('-');
                lrecImportLogSubsidiaryClient.Init;
                lrecImportLogSubsidiaryClient."Import Log Entry No."  := p_recImportLog."Entry No.";
                lrecImportLogSubsidiaryClient."Parent Client No."     := lrecSubsidiaryClient."Parent Client No.";
                lrecImportLogSubsidiaryClient."Country Database Code" := lrecSubsidiaryClient."Country Database Code";
                lrecImportLogSubsidiaryClient."Company Name"          := lrecSubsidiaryClient."Company Name";
                lrecImportLogSubsidiaryClient."Company No."           := lrecSubsidiaryClient."Company No.";
                lrecImportLogSubsidiaryClient."Creation Date"         := Today;
                lrecImportLogSubsidiaryClient."Creation Time"         := Time;
                lrecImportLogSubsidiaryClient."Interface Type"        := p_recImportLog."Interface Type";
                lrecImportLogSubsidiaryClient."TB to TB client"       := lrecSubsidiaryClient."TB to TB client";
                lrecImportLogSubsidiaryClient."G/L Detail level"      := lrecSubsidiaryClient."G/L Detail level";
                lrecImportLogSubsidiaryClient."Statutory Reporting"   := lrecSubsidiaryClient."Statutory Reporting";
                lrecImportLogSubsidiaryClient."Corp. Tax Reporting"   := lrecSubsidiaryClient."Corp. Tax Reporting";
                lrecImportLogSubsidiaryClient."VAT Reporting level"   := lrecSubsidiaryClient."VAT Reporting level";
                lrecImportLogSubsidiaryClient.Insert(true);
              until lrecTmpCustomer.Next = 0;
            end;

            if p_blnDialog then begin
              ldlgDialog.Close;
            end;
        end;

        //[Scope('Internal')]
        procedure gfncCheckPostingDateRange(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
        begin
            r_blnResult := true;
            case p_recImportLog."Table ID" of
              60009 : ; // No need to check
              60012 : r_blnResult := r_blnResult and lmodDataImportMgt_60012.gfncCheckPostDateRange(p_recImportLog, p_blnDialog);
              60018 : ; // No need to check
              60019 : ; // No need to check
              60020 : ; // No need to check
              else begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_009, p_recImportLog."Table ID"));
              end;
            end;
        end;

        //[Scope('Internal')]
        procedure gfncUpdateDateRange(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
            lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
            lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
            lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
        begin
            r_blnResult := true;
            case p_recImportLog."Table ID" of
              60009 : r_blnResult := r_blnResult and lmodDataImportMgt_60009.gfncUpdateDateRange(p_recImportLog, p_blnDialog);
              60012 : r_blnResult := r_blnResult and lmodDataImportMgt_60012.gfncUpdateDateRange(p_recImportLog, p_blnDialog);
              60018 : r_blnResult := r_blnResult and lmodDataImportMgt_60018.gfncUpdateDateRange(p_recImportLog, p_blnDialog);
              60019 : r_blnResult := r_blnResult and lmodDataImportMgt_60019.gfncUpdateDateRange(p_recImportLog, p_blnDialog);
              60020 : r_blnResult := r_blnResult and lmodDataImportMgt_60020.gfncUpdateDateRange(p_recImportLog, p_blnDialog);
              else begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0, StrSubstNo(ERR_009, p_recImportLog."Table ID"));
              end;
            end;
        end;

        //[Scope('Internal')]
        procedure "<-- Stage 3 related -->"()
        begin
        end;

        //[Scope('Internal')]
        procedure gfncRunStage3(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean;p_blnDeleteErrorLog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            //
            // Copy all individual companies
            //
            p_recImportLog.Stage := p_recImportLog.Stage::"Data Transfer";
            p_recImportLog.Status := p_recImportLog.Status::"In Progress";
            p_recImportLog.Modify;
            Commit;

            // Delete old Import log entries - Header
            if p_blnDeleteErrorLog then lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);
            // Delete old Import log entries - Subs clients
            gfncDeleteSubsErrEntries(p_recImportLog, p_blnDialog);

            // Local processing of Data (Export files etc)
            r_blnResult := gfncLocalProcessData(p_recImportLog, p_blnDialog);

            // Copy data to subsidiary database
            r_blnResult := r_blnResult and gfncCopyData(p_recImportLog, p_blnDialog);

            if not r_blnResult then begin
              p_recImportLog.Status := p_recImportLog.Status :: Error;
              // Roll-Back Stage 3
              if lmodDataImportManagementCommon.gfncRollBackRemoteData(p_recImportLog, true) then
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                  StrSubstNo(ERR_020, 3, p_recImportLog."Entry No."))
              else
                // Rollback failed
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                  StrSubstNo(ERR_021, 3, p_recImportLog."Entry No."));
            end else begin
              p_recImportLog.Status := p_recImportLog.Status :: Processed;
            end;
            p_recImportLog.Modify;
        end;

        //[Scope('Internal')]
        procedure gfncDeleteSubsErrEntries(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            r_blnResult := true;
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              lmodDataImportManagementCommon.gfncDelSubsClientErrLogEntries(lrecImportLogSubsidiaryClient); // Delete old error entries
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncLocalProcessData(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            r_blnResult := true;
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              r_blnResult := r_blnResult and gfncLocalProcessClient(p_recImportLog, lrecImportLogSubsidiaryClient, p_blnDialog);
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncLocalProcessClient(var p_recImportLog: Record "Import Log";var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
            lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
            lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
            lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
        begin
            p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::"In Progress";
            p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Data Transfer";
            p_recImportLogSubsidiaryClient.Modify;
            Commit;

            r_blnResult := true;

            //  data Process
            case p_recImportLog."Table ID" of
              60009 : r_blnResult := lmodDataImportMgt_60009.gfncProcessClient(p_recImportLog,p_recImportLogSubsidiaryClient,p_blnDialog);
              60012 : r_blnResult := lmodDataImportMgt_60012.gfncProcessClient(p_recImportLog,p_recImportLogSubsidiaryClient,p_blnDialog);
              60018 : r_blnResult := lmodDataImportMgt_60018.gfncProcessClient(p_recImportLog,p_recImportLogSubsidiaryClient,p_blnDialog);
              60019 : r_blnResult := lmodDataImportMgt_60019.gfncProcessClient(p_recImportLog,p_recImportLogSubsidiaryClient,p_blnDialog);
              60020 : r_blnResult := lmodDataImportMgt_60020.gfncProcessClient(p_recImportLog,p_recImportLogSubsidiaryClient,p_blnDialog);
            end;

            if r_blnResult then begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Processed;
            end else begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Error;
            end;
            p_recImportLogSubsidiaryClient.Modify;
        end;

        //[Scope('Internal')]
        procedure gfncCopyData(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            r_blnResult := true;
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              //lmodDataImportManagementCommon.gfncDelSubsClientErrLogEntries(lrecImportLogSubsidiaryClient); // Delete old error entries
              r_blnResult := r_blnResult and gfncCopyClient(p_recImportLog, lrecImportLogSubsidiaryClient, p_blnDialog);
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncCopyClient(var p_recImportLog: Record "Import Log";var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lintCopyActionId: Integer;
            lrecCountryDatabase: Record "Country Database";
            ltxtImportLogKey: Text[1024];
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportSafeWScall: Codeunit "Data Import Safe WS call";
            lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
            lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
            lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
            lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
        begin
            p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::"In Progress";
            p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Data Transfer";
            p_recImportLogSubsidiaryClient.Modify;
            Commit;

            if not lrecCountryDatabase.Get(p_recImportLogSubsidiaryClient."Country Database Code") then begin
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_014, p_recImportLogSubsidiaryClient."Country Database Code"));
              exit(false);
            end;

            lmodDataImportSafeWScall.gfncSetDialog(p_blnDialog);
            lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
            lmodDataImportSafeWScall.gfncSetSubsImportLog(p_recImportLogSubsidiaryClient);
            // Copy log header
            lmodDataImportSafeWScall.gfncSetAction(3); // Copy import log
            Commit;
            if lmodDataImportSafeWScall.Run() then begin
              r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
              ltxtImportLogKey := lmodDataImportSafeWScall.gfncGetKey();
            end else begin
              r_blnResult := false;
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_016, GetLastErrorText));
            end;

            if r_blnResult then begin // Continue only if header was success
              // Copy data
              case p_recImportLog."Table ID" of
                60009 : lintCopyActionId := lmodDataImportMgt_60009.gfncGetActionNoCopyData();
                60012 : lintCopyActionId := lmodDataImportMgt_60012.gfncGetActionNoCopyData();
                60018 : lintCopyActionId := lmodDataImportMgt_60018.gfncGetActionNoCopyData();
                60019 : lintCopyActionId := lmodDataImportMgt_60019.gfncGetActionNoCopyData();
                60020 : lintCopyActionId := lmodDataImportMgt_60020.gfncGetActionNoCopyData();
              end;

              lmodDataImportSafeWScall.gfncSetAction(lintCopyActionId);
              Commit;
              if lmodDataImportSafeWScall.Run() then begin
                r_blnResult := r_blnResult and lmodDataImportSafeWScall.gfncGetLastResult();
              end else begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
              if not r_blnResult then begin
                // Delete local data
                lmodDataImportSafeWScall.gfncSetAction(2);
                Commit;
                if not lmodDataImportSafeWScall.Run() then begin // Even delete crashed. Not much to do here
                  lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                 StrSubstNo(ERR_016, GetLastErrorText));
                end;
                // Delete log
                //lmodDataImportSafeWScall.gfncSetAction(4); // Delete Import log
                //COMMIT;
                //IF NOT lmodDataImportSafeWScall.RUN() THEN BEGIN // Even delete crashed. Not much to do here
                //  lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                //                                 STRSUBSTNO(ERR_016, GETLASTERRORTEXT));
                //END;
              end;
            end;



            if r_blnResult then begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Processed;
            end else begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Error;
            end;
            //p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Data Transfer";
            p_recImportLogSubsidiaryClient.Modify;

            if r_blnResult then begin
              // update import log here
              p_recImportLog.Status := p_recImportLog.Status::Processed;
              lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
              lmodDataImportSafeWScall.gfncSetKey(ltxtImportLogKey);
              lmodDataImportSafeWScall.gfncSetAction(12); // Update import log
              Commit;
              if lmodDataImportSafeWScall.Run() then begin
                r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
              end else begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
            end;
            if  not r_blnResult then begin
              // Delete log
              lmodDataImportSafeWScall.gfncSetAction(4); // Delete Import log
              Commit;
              if not lmodDataImportSafeWScall.Run() then begin // Even delete crashed. Not much to do here
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
            end;
        end;

        //[Scope('Internal')]
        procedure "<-- Stage 4 related -->"()
        begin
        end;

        //[Scope('Internal')]
        procedure gfncRunStage4(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean;p_blnDeleteErrorLog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            //
            // Copy all individual companies
            //
            p_recImportLog.Stage := p_recImportLog.Stage::"Data Validation";
            p_recImportLog.Status := p_recImportLog.Status::"In Progress";
            p_recImportLog.Modify;
            Commit;

            // Delete old Import log entries
            if p_blnDeleteErrorLog then lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

            r_blnResult := gfncValidateRemoteData(p_recImportLog, p_blnDialog);

            if not r_blnResult then begin
              p_recImportLog.Status := p_recImportLog.Status :: Error;
              // Roll-Back Stage 4
              if lmodDataImportManagementCommon.gfncRollBackRemoteData(p_recImportLog, true) then
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                  StrSubstNo(ERR_020, 4, p_recImportLog."Entry No."))
              else
                // Rollback failed
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                                                  StrSubstNo(ERR_021, 4, p_recImportLog."Entry No."));
            end else begin
              p_recImportLog.Status := p_recImportLog.Status :: Processed;
            end;
            p_recImportLog.Modify;
        end;

        //[Scope('Internal')]
        procedure gfncValidateRemoteData(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
        begin
            r_blnResult := true;
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              r_blnResult := r_blnResult and gfncValidateRemoteClientData(p_recImportLog, lrecImportLogSubsidiaryClient, p_blnDialog);
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncValidateRemoteClientData(var p_recImportLog: Record "Import Log";var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecCountryDatabase: Record "Country Database";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportSafeWScall: Codeunit "Data Import Safe WS call";
        begin
            p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::"In Progress";
            p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Data Validation";
            p_recImportLogSubsidiaryClient.Modify;
            Commit;

            if not lrecCountryDatabase.Get(p_recImportLogSubsidiaryClient."Country Database Code") then begin
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_014, p_recImportLogSubsidiaryClient."Country Database Code"));
              exit(false);
            end;
            // Delete old error entries
            lmodDataImportManagementCommon.gfncDelSubsClientErrLogEntries(p_recImportLogSubsidiaryClient);

            lmodDataImportSafeWScall.gfncSetDialog(p_blnDialog);
            lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
            lmodDataImportSafeWScall.gfncSetSubsImportLog(p_recImportLogSubsidiaryClient);

            lmodDataImportSafeWScall.gfncSetAction(5); // ValidateRemote data
            Commit;
            if lmodDataImportSafeWScall.Run() then begin
              r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
              if not r_blnResult then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_017, p_recImportLogSubsidiaryClient."Import Log Entry No.",
                                               p_recImportLogSubsidiaryClient."Company Name"));
              end;
            end else begin
              r_blnResult := false;
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_016, GetLastErrorText));
            end;
            //
            // Validation failed, get validation errors
            //
            if not r_blnResult then begin
              lmodDataImportSafeWScall.gfncSetAction(6); // Retrieve remote error log
              Commit;
              if not lmodDataImportSafeWScall.Run() then begin //
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Error;
            end else begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Processed;
            end;
            //p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Data Validation";
            p_recImportLogSubsidiaryClient.Modify;
        end;

        //[Scope('Internal')]
        procedure "<-- Stage 5 related -->"()
        begin
        end;

        //[Scope('Internal')]
        procedure gfncRunStage5(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean;p_blnDeleteErrorLog: Boolean) r_blnResult: Boolean
        var
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            //
            // Copy all individual companies
            //
            p_recImportLog.Stage := p_recImportLog.Stage::"Record Creation/Update/Posting";
            p_recImportLog.Status := p_recImportLog.Status::"In Progress";
            p_recImportLog.Modify;
            Commit;

            // Delete old Import log entries
            if p_blnDeleteErrorLog then lmodDataImportManagementCommon.gfncDeleteErrorLogEntries(p_recImportLog);

            r_blnResult := gfncPostRemoteData(p_recImportLog, p_blnDialog);

            if not r_blnResult then
              p_recImportLog.Status := p_recImportLog.Status :: Error
            else
              p_recImportLog.Status := p_recImportLog.Status :: Processed;
            p_recImportLog.Modify;
        end;

        //[Scope('Internal')]
        procedure gfncPostRemoteData(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
        begin
            r_blnResult := true;
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              r_blnResult := r_blnResult and gfncPostRemoteClientData(p_recImportLog, lrecImportLogSubsidiaryClient, p_blnDialog);
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncPostRemoteClientData(var p_recImportLog: Record "Import Log";var p_recImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecCountryDatabase: Record "Country Database";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
            lmodDataImportSafeWScall: Codeunit "Data Import Safe WS call";
        begin
            p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::"In Progress";
            p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Record Creation/Update/Posting";
            p_recImportLogSubsidiaryClient.Modify;
            Commit;

            if not lrecCountryDatabase.Get(p_recImportLogSubsidiaryClient."Country Database Code") then begin
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_014, p_recImportLogSubsidiaryClient."Country Database Code"));
              exit(false);
            end;

            // Delete old error entries
            lmodDataImportManagementCommon.gfncDelSubsClientErrLogEntries(p_recImportLogSubsidiaryClient);

            lmodDataImportSafeWScall.gfncSetDialog(p_blnDialog);
            lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
            lmodDataImportSafeWScall.gfncSetSubsImportLog(p_recImportLogSubsidiaryClient);

            lmodDataImportSafeWScall.gfncSetAction(7); // Post Remote data
            Commit;
            if lmodDataImportSafeWScall.Run() then begin
              r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
              if not r_blnResult then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_018, p_recImportLogSubsidiaryClient."Import Log Entry No.",
                                               p_recImportLogSubsidiaryClient."Company Name"));
              end;
            end else begin
              r_blnResult := false;
              lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                             StrSubstNo(ERR_016, GetLastErrorText));
            end;

            //
            // Posting failed, get posting errors
            //
            if not r_blnResult then begin
              lmodDataImportSafeWScall.gfncSetAction(6); // Retrieve remote error log
              Commit;
              if not lmodDataImportSafeWScall.Run() then begin
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Error;
            end else begin
              p_recImportLogSubsidiaryClient.Status := p_recImportLogSubsidiaryClient.Status::Processed;
            end;
            //p_recImportLogSubsidiaryClient.Stage := p_recImportLogSubsidiaryClient.Stage::"Record Creation/Update/Posting";
            p_recImportLogSubsidiaryClient.Modify;
        end;

        //[Scope('Internal')]
        procedure "<-- Stage 6 Related -->"()
        begin
        end;

        //[Scope('Internal')]
        procedure gfncRunStage6(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lrecImportLogSubsidiaryClient: Record "Import Log - Subsidiary Client";
            lmodDataImportSafeWScall: Codeunit "Data Import Safe WS call";
            lmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        begin
            //
            // Archive
            //

            // Archive Master Data
            r_blnResult := gfncArchive(p_recImportLog, p_blnDialog);

            // Archive remote records
            //Import Log Entry No.,Parent Client No.,Country Database Code,Company Name
            lrecImportLogSubsidiaryClient.SetRange("Import Log Entry No.", p_recImportLog."Entry No.");

            lmodDataImportSafeWScall.gfncSetDialog(p_blnDialog);
            lmodDataImportSafeWScall.gfncSetImportLog(p_recImportLog);
            // Copy log header
            lmodDataImportSafeWScall.gfncSetAction(13); // Archive remote data
            if lrecImportLogSubsidiaryClient.FindSet(false) then repeat
              lmodDataImportSafeWScall.gfncSetSubsImportLog(lrecImportLogSubsidiaryClient);
              Commit;
              if lmodDataImportSafeWScall.Run() then begin
                r_blnResult := lmodDataImportSafeWScall.gfncGetLastResult();
              end else begin
                r_blnResult := false;
                lmodDataImportManagementCommon.gfncCreateLogEntry(p_recImportLog, 0,
                                               StrSubstNo(ERR_016, GetLastErrorText));
              end;
            until lrecImportLogSubsidiaryClient.Next = 0;
        end;

        //[Scope('Internal')]
        procedure gfncArchive(var p_recImportLog: Record "Import Log";p_blnDialog: Boolean) r_blnResult: Boolean
        var
            lblnConfirm: Boolean;
            lmodDataImportMgt_60009: Codeunit "Data Import Mgt 60009";
            lmodDataImportMgt_60012: Codeunit "Data Import Mgt 60012";
            lmodDataImportMgt_60018: Codeunit "Data Import Mgt 60018";
            lmodDataImportMgt_60019: Codeunit "Data Import Mgt 60019";
            lmodDataImportMgt_60020: Codeunit "Data Import Mgt 60020";
        begin
            r_blnResult := false;
            if p_blnDialog then begin
              p_recImportLog.CalcFields("Table Name");
              lblnConfirm := Confirm(DLG_004, false, p_recImportLog."Entry No.", p_recImportLog."Table Name");
            end else begin
              lblnConfirm := true;
            end;

            if lblnConfirm then begin
              case p_recImportLog."Table ID" of
                60009 : r_blnResult := lmodDataImportMgt_60009.gfncArchive(p_recImportLog, p_blnDialog);
                60012 : r_blnResult := lmodDataImportMgt_60012.gfncArchive(p_recImportLog, p_blnDialog);
                60018 : r_blnResult := lmodDataImportMgt_60018.gfncArchive(p_recImportLog, p_blnDialog);
                60019 : r_blnResult := lmodDataImportMgt_60019.gfncArchive(p_recImportLog, p_blnDialog);
                60020 : r_blnResult := lmodDataImportMgt_60020.gfncArchive(p_recImportLog, p_blnDialog);
              end;
            end else begin
              exit(false);
            end;

            if p_blnDialog then begin
              if r_blnResult then Message(MSG_020)
                             else Message(MSG_021);
            end;
        end;
        */
}

