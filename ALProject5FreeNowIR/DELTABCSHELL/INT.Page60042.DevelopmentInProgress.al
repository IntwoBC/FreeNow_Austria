page 60042 "Development In Progress"
{
    Caption = 'Development In Progress';
    Editable = false;
    PageType = List;
    SourceTable = "Standard Text";
    SourceTableTemporary = true;
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Description := '***** TO BE DEVELOPED *****';
        Rec.Insert;
    end;
}

