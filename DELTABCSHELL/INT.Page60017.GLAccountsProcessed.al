page 60017 "G/L Accounts (Processed)"
{
    Caption = 'Processed Staging - G/L Accounts';
    PageType = List;
    SourceTable = "G/L Account (Processed)";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                }
                field("Gen. Bus. Posting Type"; Rec."Gen. Bus. Posting Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

