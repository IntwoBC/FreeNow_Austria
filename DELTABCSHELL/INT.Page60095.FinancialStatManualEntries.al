page 60095 "Financial Stat. Manual Entries"
{
    // MP 04-12-13
    // Object created (CR 30)

    Caption = 'Financial Statement Manual Entries';
    PageType = List;
    SourceTable = "Financial Stat. Manual Entry";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Start Balance"; Rec."Start Balance")
                {
                }
                field("End Balance"; Rec."End Balance")
                {
                }
            }
        }
    }

    actions
    {
    }
}

