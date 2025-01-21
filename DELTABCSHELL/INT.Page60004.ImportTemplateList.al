page 60004 "Import Template List"
{
    Caption = 'Import Template List';
    CardPageID = "Import Template Header";
    PageType = List;
    SourceTable = "Import Template Header";
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
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Table Caption"; Rec."Table Caption")
                {
                }
                field("File Format"; Rec."File Format")
                {
                }
                field("Field Delimiter"; Rec."Field Delimiter")
                {
                }
                field("Text Qualifier"; Rec."Text Qualifier")
                {
                }
                field("Decimal Symbol"; Rec."Decimal Symbol")
                {
                }
                field("Thousand Separator"; Rec."Thousand Separator")
                {
                }
                field("Skip Header Lines"; Rec."Skip Header Lines")
                {
                }
            }
        }
    }

    actions
    {
    }
}

