page 60032 "WS Import Error Log"
{
    Caption = 'WS Import Error Log';
    PageType = List;
    SourceTable = "Import Error Log";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("Country Database Code"; Rec."Country Database Code")
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                }
                field("Staging Table Entry No."; Rec."Staging Table Entry No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date & Time"; Rec."Date & Time")
                {
                }
            }
        }
    }

    actions
    {
    }
}

