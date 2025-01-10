page 60011 "Country Database Card"
{
    // MP 26-11-14
    // NAV 2013 R2 Upgrade - added field "Tenant Id"

    Caption = 'Country Database Card';
    PageType = Card;
    SourceTable = "Country Database";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
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

