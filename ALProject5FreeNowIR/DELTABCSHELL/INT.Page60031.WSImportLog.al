page 60031 "WS Import Log"
{
    Caption = 'WS Import Log';
    CardPageID = "Import Log Card";
    PageType = List;
    SourceTable = "Import Log";
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
                field("Parent Client No."; Rec."Parent Client No.")
                {
                }
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Table Caption"; Rec."Table Caption")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Stage; Rec.Stage)
                {
                }
                field(Errors; Rec.Errors)
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Import Date"; Rec."Import Date")
                {
                }
                field("Import Time"; Rec."Import Time")
                {
                }
                field("TB to TB client"; Rec."TB to TB client")
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
                field("Posting Method"; Rec."Posting Method")
                {
                }
                field(ARTransPost; Rec."A/R Trans Posting Scenario")
                {
                    Caption = 'ARTransPost';
                }
                field(APTransPost; Rec."A/P Trans Posting Scenario")
                {
                    Caption = 'APTransPost';
                }
            }
        }
    }

    actions
    {
    }
}

