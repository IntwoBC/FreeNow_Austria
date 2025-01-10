page 60018 "My Import Log"
{
    // MP 12-11-12
    // Added parameter to function call in Action Process
    // 
    // MP 30-04-14
    // Development taken from Core II
    Caption = 'My Import Log';
    CardPageID = "Import Log Card";
    PageType = ListPart;
    SourceTable = "Import Log";
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
                field("Parent Client No."; Rec."Parent Client No.")
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
                field(Status; Rec.Status)
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("Picture (Stage-File Import)"; Rec."Picture (Stage-File Import)")
                {
                }
                field("Picture (Stage-Post Imp. Va)"; Rec."Picture (Stage-Post Imp. Va)")
                {
                }
                field(Errors; Rec.Errors)
                {
                    HideValue = gblnHideValueErrors;
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field(Imported; gmodDataImportManagementCommon.gfncGetNoEntriesFromImportLog(Rec, ''))
                {
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        gmodDataImportManagementCommon.gfncShowEntriesFromImportLog(Rec, '');
                    end;
                }
                field("File Name"; Rec."File Name")
                {
                    Style = StandardAccent;
                    StyleExpr = gblnError;
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action2>")
            {
                Caption = 'Open';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Import Log Card", Rec);
                end;
            }
            action("Error Log")
            {
                Caption = 'Error Log';
                Image = ErrorLog;
                RunObject = Page "Import Error Log";
                RunPageLink = "Import Log Entry No." = FIELD("Entry No.");
                RunPageView = SORTING("Import Log Entry No.");
            }
            action(Process)
            {
                Caption = 'Process';
                Image = PostDocument;

                trigger OnAction()
                var
                    lmodDataImportManagementGlobal: Codeunit "Data Import Management Global";
                begin
                    lmodDataImportManagementGlobal.gfncPostImportRun(Rec, true, true); // MP 12-11-12 Added third parameter to call (new parameter)
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Picture (Status)" := gtmpStatusColor[Rec.Status + 1].Picture;

        gblnError := Rec.Status = Rec.Status::Error;
        Rec.gfcnUpdateStagePicture(gtmpStatusColor);

        gblnHideValueErrors := ((Rec.Status = Rec.Status::Processed) and (Rec.Stage = Rec.Stage::"Record Creation/Update/Posting"));
    end;

    trigger OnOpenPage()
    begin
        lfcnInitStatusColor;
        Rec.SetRange("User ID", UserId);
        if Rec.FindFirst then;
    end;

    var
        gmodDataImportManagementCommon: Codeunit "Data Import Management Common";
        gtmpStatusColor: array[4] of Record "Status Color" temporary;
        [InDataSet]
        gblnError: Boolean;
        [InDataSet]
        gblnHideValueErrors: Boolean;

    local procedure lfcnInitStatusColor()
    var
        lrecStatusColor: Record "Status Color";
    begin
        lrecStatusColor.FindSet;
        repeat
            lrecStatusColor.CalcFields(Picture);
            gtmpStatusColor[lrecStatusColor.Status + 1] := lrecStatusColor;
            gtmpStatusColor[lrecStatusColor.Status + 1].Insert;
        until lrecStatusColor.Next = 0;
    end;
}

