page 60009 "Parent Client Subform"
{
    Caption = 'Subsidiary Clients';
    PageType = ListPart;
    SourceTable = "Subsidiary Client";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Country Database Code"; Rec."Country Database Code")
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Company No."; Rec."Company No.")
                {
                }
                field("G/L Detail level"; Rec."G/L Detail level")
                {
                }
                field("Statutory Reporting"; Rec."Statutory Reporting")
                {
                }
                field("Corp. Tax Reporting"; Rec."Corp. Tax Reporting")
                {
                }
                field("VAT Reporting level"; Rec."VAT Reporting level")
                {
                }
            }
        }
    }

    actions
    {
    }
}

