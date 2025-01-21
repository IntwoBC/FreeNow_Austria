page 60064 "Corp COA (Processed)"
{
    Caption = 'Corp COA (Processed)';
    PageType = List;
    SourceTable = "Corporate G/L Acc (Processed)";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Accounting Class"; Rec."Accounting Class")
                {
                }
                field("Name - ENU"; Rec."Name - ENU")
                {
                }
                field("Financial Statement Code"; Rec."Financial Statement Code")
                {
                }
                field("Local Chart Of Acc (Mapped)"; Rec."Local Chart Of Acc (Mapped)")
                {
                }
                field("Company No."; Rec."Company No.")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Import Log Entry No."; Rec."Import Log Entry No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

