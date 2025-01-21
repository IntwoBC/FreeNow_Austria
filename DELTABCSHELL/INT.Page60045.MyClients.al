page 60045 "My Clients"
{
    Caption = 'My Clients';
    PageType = List;
    SourceTable = "My Client";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("Parent Client No."; Rec."Parent Client No.")
                {
                }
                field("Parent Client Name"; Rec."Parent Client Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

