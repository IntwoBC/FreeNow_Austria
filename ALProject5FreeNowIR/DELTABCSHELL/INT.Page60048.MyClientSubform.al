page 60048 "My Client Subform"
{
    Caption = 'My Client Subform';
    PageType = ListPart;
    SourceTable = "Subsidiary Client";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company No."; Rec."Company No.")
                {
                }
                field("Company Name"; Rec."Company Name")
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
    }

    trigger OnAfterGetRecord()
    begin
        grecImportLogSubsClient.SetCurrentKey("Parent Client No.");
        grecImportLogSubsClient.SetRange("Parent Client No.", Rec."Parent Client No.");
        grecImportLogSubsClient.SetRange("Company No.", Rec."Company No.");

        gblnErrorGLAcc := lfcnCheckError(grecImportLogSubsClient."Interface Type"::"Chart Of Accounts");
        gblnErrorCorpGLAcc := lfcnCheckError(grecImportLogSubsClient."Interface Type"::"Corporate Chart Of Accounts");
        gblnErrorTB := lfcnCheckError(grecImportLogSubsClient."Interface Type"::"Trial Balance");
        gblnErrorGLEntries := lfcnCheckError(grecImportLogSubsClient."Interface Type"::"GL Transactions");
        gblnErrorCustomer := lfcnCheckError(grecImportLogSubsClient."Interface Type"::Customer);
        gblnErrorAR := lfcnCheckError(grecImportLogSubsClient."Interface Type"::"AR Transactions");
        gblnErrorVendor := lfcnCheckError(grecImportLogSubsClient."Interface Type"::Vendor);
        gblnErrorAP := lfcnCheckError(grecImportLogSubsClient."Interface Type"::APTransactions);
    end;

    var
        grecImportLogSubsClient: Record "Import Log - Subsidiary Client";
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

    local procedure lfcnCheckError(pintInterfaceType: Integer): Boolean
    begin
        grecImportLogSubsClient.SetRange("Interface Type", pintInterfaceType);
        if grecImportLogSubsClient.FindLast then
            exit(grecImportLogSubsClient.Status = grecImportLogSubsClient.Status::Error);

        exit(false);
    end;
}

