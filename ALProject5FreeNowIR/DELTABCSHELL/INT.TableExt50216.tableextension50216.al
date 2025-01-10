tableextension 50216 tableextension50216 extends "Gen. Journal Line"
{
    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // OPP  01.11.08   - New Fields added
    //                 - New Keys added
    //                   ID Applied-Entry
    //                   Pmt. Import Entry No.
    //                 - New Functions
    // -----------------------------------------------------
    // SUP:ISSUE:#111525  09/09/2021  COSMO.ABT
    //    # Added two new fields: 50000 "IBAN / Bank Account" Code[50].
    //                            50001 "URL" Text[250].
    // SUP:ISSUE:#112374  14/10/2021  COSMO.ABT
    //    # Added new field: 50002 "E-Mail" Text[80].
    // 
    // SUP:ISSUE:#117922  24/08/2022  COSMO.ABT
    //    # Added a new field: 50003 "Purchase Order No." Code[50].
    // 
    // SUP:Ticket:#121664  09/05/2023  COSMO.ABT
    //    # Added a new field: 50004 "Sales Order No." Code[50].
    fields
    {
        field(50000; "IBAN / Bank Account"; Code[50])
        {
            Caption = 'IBAN / Bank Account';
            Description = 'SUP:ISSUE:#111525';
            Editable = false;
        }
        field(50001; URL; Text[250])
        {
            Caption = 'URL';
            Description = 'SUP:ISSUE:#111525';
            ExtendedDatatype = URL;
        }
        field(50002; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'SUP:ISSUE:#112374';
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(50003; "Purchase Order No."; Code[50])
        {
            Caption = 'Purchase Order No.';
            Description = 'SUP:ISSUE:#117922';
        }
        field(50004; "Sales Order No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'SUP:Ticket:#121664';
        }
        field(60000; "Corporate G/L Account No."; Code[20])
        {
            Caption = 'Corporate G/L Account No.';
            Description = 'MP 18-01-12';
            TableRelation = IF (BottomUp = CONST(false),
                                "Account No." = FILTER(<> '')) "Corporate G/L Account" WHERE("Local G/L Account No." = FIELD("Account No."))
            ELSE
            "Corporate G/L Account";
        }
        field(60010; "Bal. Corporate G/L Account No."; Code[20])
        {
            Caption = 'Bal. Corporate G/L Account No.';
            Description = 'MP 18-01-12';
            TableRelation = IF (BottomUp = CONST(false),
                                "Bal. Account No." = FILTER(<> '')) "Corporate G/L Account" WHERE("Local G/L Account No." = FIELD("Bal. Account No."))
            ELSE
            "Corporate G/L Account";
        }
        field(60020; "GAAP Adjustment Reason"; Option)
        {
            Caption = 'GAAP Adjustment Reason';
            Description = 'MP 18-01-12';
            OptionCaption = ' ,Timing,GAAP,Reclassification,Tax';
            OptionMembers = " ",Timing,GAAP,Reclassification,Tax;
        }
        field(60030; "Adjustment Role"; Option)
        {
            Caption = 'Adjustment Role';
            Description = 'MP 18-01-12';
            OptionCaption = ' ,EY,Client,Auditor';
            OptionMembers = " ",EY,Client,Auditor;
        }
        field(60040; "Tax Adjustment Reason"; Option)
        {
            Caption = 'Tax Adjustment Reason';
            Description = 'MP 18-01-12';
            OptionCaption = ' ,P&L,Equity,,Non Temporary,Other P&L,Other Equity,Other Non Temporary';
            OptionMembers = " ","P&L",Equity,"<Obsolete>","Non Temporary","Other P&L","Other Equity","Other Non Temporary";
        }
        field(60050; "Ready to Post"; Boolean)
        {
            Caption = 'Ready to Post';
            Description = 'MP 18-01-12';
        }
        field(60060; "Equity Correction Code"; Code[10])
        {
            Caption = 'Equity Correction Code';
            Description = 'MP 18-01-12';
            TableRelation = "Equity Correction Code" WHERE("Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"));
        }
        field(60070; "Interface Type"; Option)
        {
            Caption = 'Interface Type';
            Description = 'MD 01-10-12';
            OptionCaption = ' ,AR Transactions,AP Transactions';
            OptionMembers = " ","AR Transactions","AP Transactions";
        }
        field(60073; "A/R Trans Posting Scenario"; Option)
        {
            Caption = 'A/R Trans Posting Scenario';
            OptionCaption = 'Update G/L,Do Not Update G/L';
            OptionMembers = "Update G/L","Do Not Update G/L";
        }
        field(60074; "A/P Trans Posting Scenario"; Option)
        {
            Caption = 'A/P Trans Posting Scenario';
            OptionCaption = 'Update G/L,Do Not Update G/L';
            OptionMembers = "Update G/L","Do Not Update G/L";
        }
        field(60075; "Custom VAT Posting"; Boolean)
        {
            Caption = 'Custom VAT Posting';
        }
        field(60080; "Description (English)"; Text[50])
        {
            Caption = 'Description (English)';
            Description = 'MP 18-01-12';
        }
        field(60110; Reversible; Boolean)
        {
            Caption = 'Reversible';
            Description = 'MD 25-09-12';
        }
        field(60120; "Entry No. to Reverse"; Integer)
        {
            Caption = 'Entry No. to Reverse';
            Description = 'MP 23-11-15';
            TableRelation = "G/L Entry";
        }
        field(60200; "Corporate G/L Account Name"; Text[50])
        {
            CalcFormula = Lookup("Corporate G/L Account".Name WHERE("No." = FIELD("Corporate G/L Account No.")));
            Caption = 'Corporate G/L Account Name';
            Description = 'MP 12-May-16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60210; "Bal. Corp. G/L Account Name"; Text[50])
        {
            CalcFormula = Lookup("Corporate G/L Account".Name WHERE("No." = FIELD("Bal. Corporate G/L Account No.")));
            Caption = 'Bal. Corporate G/L Account Name';
            Description = 'MP 12-May-16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60300; BottomUp; Boolean)
        {
            CalcFormula = Exist("EY Core Setup" WHERE("Company Type" = CONST("Bottom-up")));
            Caption = 'Country Services';
            Description = 'MP 12-May-16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60310; CorpAccInUse; Boolean)
        {
            CalcFormula = Exist("Corporate G/L Account");
            Caption = 'Corporate Accounts In Use';
            Description = 'MP 12-May-16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60320; UseReadyToPost; Boolean)
        {
            CalcFormula = Lookup("Gen. Journal Template"."Use Ready to Post" WHERE(Name = FIELD("Journal Template Name")));
            Caption = 'Use Ready to Post';
            Description = 'MP 12-May-16';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99090; "Client Entry No."; BigInteger)
        {
            Caption = 'Client Entry No.';
        }
        /*
        field(5157802; "Applied Account Type"; Option)
        {
            Caption = 'Applied Account Type';
            Description = 'EA';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(5157803; "Applied Account No."; Code[20])
        {
            Caption = 'Applied Account No.';
            Description = 'EA';
            TableRelation = IF ("Applied Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Applied Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Applied Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Applied Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(5157804; "Applied by"; Option)
        {
            Caption = 'Applied by';
            Description = 'EA';
            OptionCaption = ',Account,Bal. Account';
            OptionMembers = ,Account,"Bal. Account";
        }
        field(5157810; "Pmt. Import Entry No."; Integer)
        {
            Caption = 'Pmt. Import Entry No.';
            Description = 'EA';
        }
        field(5157812; "Application Status"; Option)
        {
            BlankZero = true;
            Caption = 'Application Status';
            Description = 'EA';
            Editable = false;
            OptionCaption = ',Open,Accounted,Finished,System,To Complete';
            OptionMembers = " ",Open,Accounted,Finished,System,Complete;
        }
        field(5157845; "Imported Currency Code"; Code[10])
        {
            Caption = 'Imported Currency Code';
            Description = 'EA';
            Editable = false;
            TableRelation = Currency;
        }
        field(5157893; "Payment in Process"; Boolean)
        {
            Caption = 'Payment in Process';
            Description = 'PMT';
            Editable = false;
        }
        field(5157896; "PIP Account Type"; Option)
        {
            Caption = 'Payment in Process Account';
            Description = 'PMT';
            Editable = false;
            OptionCaption = ',Account,Bal. Account';
            OptionMembers = ,Account,"Bal. Account";
        }*/
    }
    keys
    {
        /*
        key(Key1; "Journal Template Name", "Journal Batch Name", "Account Type", "Account No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Business Unit Code", "GAAP Adjustment Reason", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Bal. Account Type", "Bal. Account No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Business Unit Code", "GAAP Adjustment Reason", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        key(Key3; "Journal Template Name", "Journal Batch Name", "Corporate G/L Account No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Business Unit Code", "GAAP Adjustment Reason", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        key(Key4; "Journal Template Name", "Journal Batch Name", "Bal. Corporate G/L Account No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Business Unit Code", "GAAP Adjustment Reason", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        key(Key5; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Bal. Account No.", "GAAP Adjustment Reason", "Adjustment Role", "Tax Adjustment Reason", "Equity Correction Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        
        key(Key6; "Journal Template Name", "Journal Batch Name", "Document No.")
        {
        }
        */
        /*key(Key7; "Pmt. Import Entry No.")
        {
        }*/
    }

    [IntegrationEvent(TRUE, TRUE)]
    procedure gpubOnSetUpNewLine(LastGenJnlLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    begin
    end;
}

