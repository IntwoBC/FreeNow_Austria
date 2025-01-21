page 60040 "Equity Correction Code List"
{
    Caption = 'Equity Correction Code List';
    PageType = List;
    SourceTable = "Equity Correction Code";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

