page 60010 "Country Database List"
{
    // MP 26-11-14
    // NAV 2013 R2 Upgrade - added field "Tenant Id"

    Caption = 'Country Database List';
    CardPageID = "Country Database Card";
    PageType = List;
    SourceTable = "Country Database";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Country Database Code"; Rec."Country Database Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Server Address (Web Service)"; Rec."Server Address (Web Service)")
                {
                }
                field("Tenant Id"; Rec."Tenant Id")
                {
                }
            }
        }
    }

    actions
    {
    }
}

