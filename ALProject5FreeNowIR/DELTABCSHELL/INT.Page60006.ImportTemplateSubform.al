page 60006 "Import Template Subform"
{
    Caption = 'Import Template Subform';
    PageType = ListPart;
    SourceTable = "Import Template Line";
    ApplicationArea = all;//SPS

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Column; Rec.Column)
                {
                }
                field("Field ID"; Rec."Field ID")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

