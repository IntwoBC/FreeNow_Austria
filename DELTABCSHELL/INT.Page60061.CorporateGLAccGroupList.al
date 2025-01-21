page 60061 "Corporate G/L Acc. Group List"
{
    Caption = 'Corporate G/L Account Group List';
    PageType = List;
    SourceTable = "Corporate G/L Account Group";
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
                field("Description (English)"; Rec."Description (English)")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Corporate G/L Acc. Group Card";
                RunPageOnRec = true;
                ShortCutKey = 'Shift+F7';
            }
        }
    }
}

