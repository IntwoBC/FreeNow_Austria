page 60012 "Import Log List"
{
    Caption = 'Import Log List';
    CardPageID = "Import Log Card";
    Editable = false;
    PageType = List;
    SourceTable = "Import Log";
    SourceTableView = ORDER(Descending);
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Picture (Status)"; Rec."Picture (Status)")
                {
                    Caption = '^';
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Parent Client No."; Rec."Parent Client No.")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("Import Date"; Rec."Import Date")
                {
                }
                field("Import Time"; Rec."Import Time")
                {
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("File Name"; Rec."File Name")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field(Status; Rec.Status)
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field(Stage; Rec.Stage)
                {
                }
                field(Errors; Rec.Errors)
                {
                    HideValue = gblnHideValueErrors;
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field(Imported; gmodDataImportManagementCommon.gfncGetNoEntriesFromImportLog(Rec, ''))
                {

                    trigger OnDrillDown()
                    begin
                        gmodDataImportManagementCommon.gfncShowEntriesFromImportLog(Rec, '');
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Error Log")
            {
                Caption = 'Error Log';
                RunObject = Page "Import Error Log";
                RunPageLink = "Import Log Entry No." = FIELD("Entry No.");
                RunPageView = SORTING("Import Log Entry No.");
            }
            separator(Action1000000015)
            {
            }
            action("<Action1000000016>")
            {
                Caption = 'Process';

                trigger OnAction()
                var
                    lmodDataImportManagementGlobal: Codeunit "Data Import Management Global";
                begin
                    lmodDataImportManagementGlobal.gfncPostImportRunConfirm(Rec, true);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status <> gtmpStatusColor.Status then begin
            gtmpStatusColor.Get(Rec.Status);
            gtmpStatusColor.CalcFields(Picture);
        end;

        Rec."Picture (Status)" := gtmpStatusColor.Picture;

        gblnError := Rec.Status = Rec.Status::"In Progress";
        gblnHideValueErrors := ((Rec.Status = Rec.Status::Processed) and (Rec.Stage = Rec.Stage::"Record Creation/Update/Posting"));
        //gblnHideValueErrors := 'TRUE';
    end;

    trigger OnInit()
    begin
        gblnHideValueErrors := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
        lfcnInitStatusColor;
    end;

    var
        gtmpStatusColor: Record "Status Color" temporary;
        [InDataSet]
        gblnError: Boolean;
        gmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        [InDataSet]
        gblnHideValueErrors: Boolean;

    local procedure lfcnInitStatusColor()
    var
        lrecStatusColor: Record "Status Color";
    begin
        lrecStatusColor.FindSet;
        repeat
            lrecStatusColor.CalcFields(Picture);
            gtmpStatusColor := lrecStatusColor;
            gtmpStatusColor.Insert;
        until lrecStatusColor.Next = 0;
    end;

    //[Scope('Internal')]
    procedure lfncImportedEntries(): Integer
    begin
        exit(10);
    end;
}

