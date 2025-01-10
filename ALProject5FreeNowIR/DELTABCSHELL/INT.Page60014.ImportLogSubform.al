page 60014 "Import Log Subform"
{
    Caption = 'Import Log Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Import Log - Subsidiary Client";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Client No."; Rec."Parent Client No.")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //
                    end;
                }
                field("Country Database Code"; Rec."Country Database Code")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //
                    end;
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Company No."; Rec."Company No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Stage; Rec.Stage)
                {
                }
                field("Picture (Stage-Data Transfer)"; Rec."Picture (Stage-Data Transfer)")
                {
                }
                field("Picture (Stage-Data Validat.)"; Rec."Picture (Stage-Data Validat.)")
                {
                }
                field("Picture (Stage-Rec. CreUpdPos)"; Rec."Picture (Stage-Rec. CreUpdPos)")
                {
                }
                field("TB to TB client"; Rec."TB to TB client")
                {
                }
                field(Imported; gmodDataImportManagementCommon.gfncGetNoEntriesFromImportLog(grecImportLog, Rec."Company No."))
                {

                    trigger OnDrillDown()
                    begin
                        gmodDataImportManagementCommon.gfncShowEntriesFromImportLog(grecImportLog, Rec."Company No.");
                    end;
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

