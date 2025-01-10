page 60035 "WS Corporate GL Account Stg"
{
    // TEC 12-04-13 -mdan-
    //   New fields
    //     Tax Return Code
    //     Tax Return Description
    //     Tax Return Desc. (English)
    // 
    // MP 30-04-14
    // Development taken from Core II. Substituted CIT Core II fields for variables (in order to use exact same Core II WS dll)

    Caption = 'WS Corporate GL Account Stg';
    PageType = List;
    SourceTable = "Corporate G/L Acc (Staging)";
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
                field("FS Name"; Rec."FS Name")
                {
                }
                field("FS Name (English)"; Rec."FS Name (English)")
                {
                }
                field("CIT Class Code"; gcodCITClassCode)
                {
                    Caption = 'CIT Class Code';
                }
                field("CIT Name"; gtxtCITName)
                {
                    Caption = 'CIT Name';
                }
                field("CIT Name (English)"; gtxtCITNameEnglish)
                {
                    Caption = 'CIT Name (English)';
                }
                field("Tax Return Code"; gocdTaxReturnCode)
                {
                    Caption = 'Tax Return Code';
                }
                field("Tax Return Description"; gtxtTaxReturnDescription)
                {
                    Caption = 'Tax Return Description';
                }
                field("Tax Return Desc. (English)"; gtxtTaxReturnDescEnglish)
                {
                    Caption = 'Tax Return Desc. (English)';
                }
            }
        }
    }

    actions
    {
    }

    var
        gcodCITClassCode: Code[10];
        gtxtCITName: Text[50];
        gtxtCITNameEnglish: Text[50];
        gocdTaxReturnCode: Code[10];
        gtxtTaxReturnDescription: Text[50];
        gtxtTaxReturnDescEnglish: Text[50];
}

