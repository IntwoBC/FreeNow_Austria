page 60054 "Vendor (Staging) List"
{
    Caption = 'Vendor (Staging) List';
    PageType = List;
    SourceTable = "Vendor (Staging)";
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
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("Payables Account"; Rec."Payables Account")
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

