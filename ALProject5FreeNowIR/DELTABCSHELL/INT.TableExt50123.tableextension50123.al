tableextension 50123 tableextension50123 extends "Vendor Ledger Entry"
{
    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // OPP  01.11.08   OPplus Modules
    //                 - New Keys added
    // -----------------------------------------------------
    // SUP:ISSUE:#111525  09/09/2021  COSMO.ABT
    //    # Added two new fields: 50000 "IBAN / Bank Account" Code[50].
    //                            50001 "URL" Text[250].
    //    # Updated function "CopyFromGenJnlLine".
    // 
    // SUP:ISSUE:#112374  14/10/2021  COSMO.ABT
    //    # Added new field: 50002 "E-Mail" Text[80].
    //    # Updated function "CopyFromGenJnlLine".
    // 
    // SUP:ISSUE:#117922  24/08/2022  COSMO.ABT
    //    # Added a new field: 50003 "Purchase Order No." Code[50].
    //    # Updated function "CopyFromGenJnlLine".
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
            Editable = false;
        }
    }
    keys
    {
        /*
        key(Key1; "Vendor No.", "Document No.")
        {
        }
        key(Key2; "Document Type", "External Document No.", "Vendor No.")
        {
        }
        key(Key3; "Vendor No.", Open, "Document Date")
        {
        }
        key(Key4; Open, "Vendor No.", "Document Date")
        {
        }
        key(Key5; Open, "Document No.", "Vendor No.")
        {
        }
        key(Key6; "Document No.", "Document Type", "Vendor No.")
        {
        }
        */
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Vendor No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    #4..35
    "Payment Reference" := GenJnlLine."Payment Reference";
    "Payment Method Code" := GenJnlLine."Payment Method Code";
    "Exported to Payment File" := GenJnlLine."Exported to Payment File";

    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..38
    //>>SUP:ISSUE:#111525
    "IBAN / Bank Account" := GenJnlLine."IBAN / Bank Account";
    URL := GenJnlLine.URL;
    //<<SUP:ISSUE:#111525
    //>>SUP:ISSUE:#112374
    "E-Mail" := GenJnlLine."E-Mail";
    //<<SUP:ISSUE:#112374
    //>>SUP:ISSUE:#117922
    "Purchase Order No." := GenJnlLine."Purchase Order No.";
    //<<SUP:ISSUE:#117922

    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
}

