page 60068 "Subsidiary Company"
{
    Caption = 'Subsidiary Company';
    PageType = List;
    SourceTable = "Subsidiary Company";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
            }
        }
    }

    actions
    {
    }
}

