page 60057 "Import Log Subs. List"
{
    Caption = 'Import Log Subform';
    Editable = false;
    PageType = ListPlus;
    SourceTable = "Import Log - Subsidiary Client";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Picture (Stage-Data Transfer)"; Rec."Picture (Stage-Data Transfer)")
                {
                }
                field("Picture (Stage-Data Validat.)"; Rec."Picture (Stage-Data Validat.)")
                {
                }
                field("Picture (Stage-Rec. CreUpdPos)"; Rec."Picture (Stage-Rec. CreUpdPos)")
                {
                }
                field(Imported; gmodDataImportManagementCommon.gfncGetNoEntriesFromImportLog(grecImportLog, Rec."Company No."))
                {

                    trigger OnDrillDown()
                    var
                        lrecImportLog: Record "Import Log";
                    begin
                        lrecImportLog.Get(Rec."Import Log Entry No.");
                        gmodDataImportManagementCommon.gfncShowEntriesFromImportLog(lrecImportLog, Rec."Company No.");
                    end;
                }
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecImportLog: Record "Import Log";
                    begin
                        if lrecImportLog.Get(Rec."Import Log Entry No.") then begin
                            PAGE.RunModal(PAGE::"Import Log Card", lrecImportLog);
                        end;
                    end;
                }
                field("Parent Client No."; Rec."Parent Client No.")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecParentClient: Record "Parent Client";
                    begin
                        //IF lrecParentClient.GET("Parent Client No.") THEN
                        //  PAGE.RUNMODAL(PAGE::"Parent Client Card", lrecParentClient);
                    end;
                }
                field("Country Database Code"; Rec."Country Database Code")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // This will disable default lookup
                    end;
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Company No."; Rec."Company No.")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("First Entry Date"; Rec."First Entry Date")
                {
                }
                field("Last Entry Date"; Rec."Last Entry Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Stage; Rec.Stage)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.gfcnUpdateStagePicture(gtmpStatusColor);
        grecImportLog.Get(Rec."Import Log Entry No.");
    end;

    trigger OnOpenPage()
    begin
        lfcnInitStatusColor;
    end;

    var
        gtmpStatusColor: array[4] of Record "Status Color" temporary;
        grecImportLog: Record "Import Log";
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

