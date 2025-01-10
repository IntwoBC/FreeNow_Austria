page 60019 "Status Colors"
{
    Caption = 'Status Colors';
    Editable = false;
    PageType = List;
    SourceTable = "Status Color";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                }
                field(Picture; Rec.Picture)
                {
                }
            }
        }
    }

    actions
    {
    }
}

