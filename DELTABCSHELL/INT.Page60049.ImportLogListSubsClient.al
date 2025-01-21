page 60049 "Import Log List - Subs. Client"
{
    Caption = 'Import Log List - Subsidiary Clients';
    Editable = false;
    PageType = List;
    SourceTable = "Import Log - Subsidiary Client";
    SourceTableView = ORDER(Descending);
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                    Editable = false;
                }
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
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field(Stage; Rec.Stage)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Time"; Rec."Creation Time")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.FindFirst then;
    end;
}

