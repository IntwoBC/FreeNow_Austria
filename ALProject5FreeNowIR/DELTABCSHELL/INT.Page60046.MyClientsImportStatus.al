page 60046 "My Clients Import Status"
{
    // MP 19-04-12
    // Changed caption for Page Actions: Local Chart of Accounts and Corporate Chart of Accounts
    // 
    // MP 30-04-14
    // Development taken from Core II
    // 
    // MP 04-12-14
    // NAV 2013 R2 Upgrade

    Caption = 'My Clients - Last Import Dates';
    CardPageID = "Import Monitoring Matrix";
    Editable = false;
    PageType = ListPart;
    SourceTable = "My Client";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Client No."; Rec."Parent Client No.")
                {
                }
                field("Parent Client Name"; Rec."Parent Client Name")
                {
                }
                field("Chart of Acc. Import Date"; Rec."Chart of Acc. Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorGLAcc;
                }
                field("Corp. Chart of Acc.Import Date"; Rec."Corp. Chart of Acc.Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorCorpGLAcc;
                }
                field("TB Import Date"; Rec."TB Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorTB;
                }
                field("G/L Entries Import Date"; Rec."G/L Entries Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorGLEntries;
                }
                field("Customer Import Date"; Rec."Customer Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorCustomer;
                }
                field("AR Import Date"; Rec."AR Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorAR;
                }
                field("Vendor Import Date"; Rec."Vendor Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorVendor;
                }
                field("AP Import Date"; Rec."AP Import Date")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnErrorAP;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000021>")
            {
                Caption = 'Import Status';
                Image = PeriodStatus;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Return';

                trigger OnAction()
                var
                    lpagImportMonitoringMatrix: Page "Import Monitoring Matrix";
                begin
                    lpagImportMonitoringMatrix.gfncSetParentClientFilter(Rec."Parent Client No.");
                    lpagImportMonitoringMatrix.RunModal;
                end;
            }
            group("Import Single Files")
            {
                Caption = 'Import Single Files';
                Image = ImportDatabase;
                action("Local Chart of Accounts")
                {
                    Caption = 'Local Chart of Accounts';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(1);
                    end;
                }
                action("Corporate Chart of Accounts")
                {
                    Caption = 'Corporate Chart of Accounts';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(2);
                    end;
                }
                action("G/L Trial Balance")
                {
                    Caption = 'G/L Trial Balance';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(3);
                    end;
                }
                action("G/L Transactions")
                {
                    Caption = 'G/L Transactions';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(4);
                    end;
                }
                action(Vendors)
                {
                    Caption = 'Vendors';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(6);
                    end;
                }
                action("AP Transactions")
                {
                    Caption = 'AP Transactions';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(8);
                    end;
                }
                action(Customers)
                {
                    Caption = 'Customers';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(5);
                    end;
                }
                action("AR Transactions")
                {
                    Caption = 'AR Transactions';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        lfcnImport(7);
                    end;
                }
            }
            group("Import Combined File")
            {
                Caption = 'Import Combined File';
                Image = ExecuteBatch;
                action("Statutory Standardization Upload Model (SSUM)")
                {
                    Caption = 'Statutory Standardization Upload Model (SSUM)';
                    Image = ImportExcel;

                    trigger OnAction()
                    var
                        lrecParentClient: Record "Parent Client";
                        lmodDataImportManagementGlobal: Codeunit "Data Import Management Global";
                    begin
                        lrecParentClient.Get(Rec."Parent Client No.");
                        lmodDataImportManagementGlobal.gfncSSBImports(lrecParentClient, true, '', false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        grecImportLog.SetCurrentKey("Parent Client No.");
        grecImportLog.SetRange("Parent Client No.", Rec."Parent Client No.");

        gblnErrorGLAcc := lfcnCheckError(grecImportLog."Interface Type"::"Chart Of Accounts");
        gblnErrorCorpGLAcc := lfcnCheckError(grecImportLog."Interface Type"::"Corporate Chart Of Accounts");
        gblnErrorTB := lfcnCheckError(grecImportLog."Interface Type"::"Trial Balance");
        gblnErrorGLEntries := lfcnCheckError(grecImportLog."Interface Type"::"GL Transactions");
        gblnErrorCustomer := lfcnCheckError(grecImportLog."Interface Type"::Customer);
        gblnErrorAR := lfcnCheckError(grecImportLog."Interface Type"::"AR Transactions");
        gblnErrorVendor := lfcnCheckError(grecImportLog."Interface Type"::Vendor);
        gblnErrorAP := lfcnCheckError(grecImportLog."Interface Type"::APTransactions);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("User ID", UserId);
    end;

    var
        grecImportLog: Record "Import Log";
        [InDataSet]
        gblnErrorGLAcc: Boolean;
        [InDataSet]
        gblnErrorCorpGLAcc: Boolean;
        [InDataSet]
        gblnErrorTB: Boolean;
        [InDataSet]
        gblnErrorGLEntries: Boolean;
        [InDataSet]
        gblnErrorCustomer: Boolean;
        [InDataSet]
        gblnErrorAR: Boolean;
        [InDataSet]
        gblnErrorVendor: Boolean;
        [InDataSet]
        gblnErrorAP: Boolean;

    local procedure lfcnImport(p_intInfoType: Integer)
    var
        lrecParentClient: Record "Parent Client";
        lmdlDataImportMgtGlobal: Codeunit "Data Import Management Global";
    begin
        lrecParentClient.Get(Rec."Parent Client No.");
        //lmdlDataImportMgtGlobal.gfncRunStage1(lrecParentClient,p_intInfoType,TRUE);
        lmdlDataImportMgtGlobal.gfncEndToEndProcess(lrecParentClient, p_intInfoType, true, '');
    end;

    local procedure lfcnCheckError(pintInterfaceType: Integer): Boolean
    begin
        grecImportLog.SetRange("Interface Type", pintInterfaceType);
        if grecImportLog.FindLast then
            exit(grecImportLog.Status = grecImportLog.Status::Error);

        exit(false);
    end;
}

