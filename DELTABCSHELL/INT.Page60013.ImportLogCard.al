page 60013 "Import Log Card"
{
    Caption = 'Import Log Card';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Import Log";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Parent Client No."; Rec."Parent Client No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Import Date"; Rec."Import Date")
                {
                }
                field("Import Time"; Rec."Import Time")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Stage; Rec.Stage)
                {
                }
                field(Imported; gmodDataImportManagementCommon.gfncGetNoEntriesFromImportLog(Rec, ''))
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        gmodDataImportManagementCommon.gfncShowEntriesFromImportLog(Rec, '');
                    end;
                }
            }
            part("Subsidiary Clients"; "Import Log Subform")
            {
                Caption = 'Subsidiary Clients';
                SubPageLink = "Import Log Entry No." = FIELD("Entry No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000009>")
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
            separator(Action1000000004)
            {
            }
            action(Archive)
            {
                Caption = 'Archive';

                trigger OnAction()
                var
                    lmodDataImportManagementGlobal: Codeunit "Data Import Management Global";
                begin
                    //lmodDataImportManagementGlobal.gfncArchive(Rec, true);//SPS
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //gfcnUpdateStagePicture(gtmpStatusColor);//SPS
    end;

    trigger OnOpenPage()
    begin
        lfcnInitStatusColor;
    end;

    var
        gtmpStatusColor: array[4] of Record "Status Color" temporary;
        gmodDataImportManagementCommon: Codeunit "Data Import Management Common";

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

