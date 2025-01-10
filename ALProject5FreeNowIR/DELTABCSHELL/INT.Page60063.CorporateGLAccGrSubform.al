page 60063 "Corporate G/L Acc. Gr. Subform"
{
    AutoSplitKey = true;
    Caption = 'Corporate G/L Acc. Gr. Subform';
    PageType = ListPart;
    SourceTable = "Corporate G/L Account Gr. Line";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Corporate G/L Account Filter"; Rec."Corporate G/L Account Filter")
                {
                }
            }
        }
    }

    actions
    {
    }
}

