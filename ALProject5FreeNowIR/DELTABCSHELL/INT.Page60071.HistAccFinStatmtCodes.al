page 60071 "Hist. Acc. Fin. Statmt. Codes"
{
    Caption = 'Historic G/L Account Financial Statement Codes';
    DataCaptionFields = "G/L Account No.";
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Hist. Acc. Fin. Statmt. Code";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Financial Statement Code"; Rec."Financial Statement Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

