page 60062 "Corporate G/L Acc. Group Card"
{
    Caption = 'Corporate G/L Account Group Card';
    PageType = Card;
    SourceTable = "Corporate G/L Account Group";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
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
            part(Lines; "Corporate G/L Acc. Gr. Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Corp. G/L Account Group Code" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

