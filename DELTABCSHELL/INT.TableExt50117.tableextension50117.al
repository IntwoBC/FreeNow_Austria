tableextension 50117 tableextension50117 extends "G/L Entry"
{
    // MP 18-01-12
    // Added fields "Corporate G/L Account No.", "Bal. Corporate G/L Account No.",
    // "Adjustment Type", "Adjustment Role" and "Adjustment Tax Reason"
    // 
    // Added keys:
    //   Corporate G/L Account No.,Posting Date
    //   Corporate G/L Account No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date
    //   Corporate G/L Account No.,Business Unit Code,Posting Date
    //   Corporate G/L Account No.,Business Unit Code,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date
    // 
    // MDAN 14-02-12
    //   New field
    //     99090Client Entry No.BigInteger
    //   New key
    //     Client Entry No.
    // 
    // MP 27-11-13
    // Added key (CR 30):
    // G/L Account No.,Business Unit Code,Global Dimension 1 Code,Global Dimension 2 Code,GAAP Adjustment Reason,Posting Date
    // 
    // MP 01-05-14
    // Amended options for "Tax Adjustment Reason"
    // Development taken from Core II for Reversal functionality
    // 
    // MP 03-11-15
    // Added option "Tax" to field "GAAP Adjustment Reason" (CB1 Enhancements)
    // Added TableRelation to "Reversal Entry No."
    // Added field "Corporate G/L Account Name"
    // 
    // SUP:ISSUE:#117922  24/08/2022  COSMO.ABT
    //    # Added a new field: 50003 "Purchase Order No." Code[50].
    //    # Updated function "CopyFromGenJnlLine".
    fields
    {
        field(50003; "Purchase Order No."; Code[50])
        {
            Caption = 'Purchase Order No.';
            Description = 'SUP:ISSUE:#117922';
            Editable = false;
        }
        field(60000; "Corporate G/L Account No."; Code[20])
        {
            Caption = 'Corporate G/L Account No.';
            Description = 'MP 18-01-12';
            TableRelation = "Corporate G/L Account";
        }
        field(60010; "Bal. Corporate G/L Account No."; Code[20])
        {
            Caption = 'Bal. Corporate G/L Account No.';
            Description = 'MP 18-01-12';
            TableRelation = "Corporate G/L Account";
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
        field(60060; "Equity Correction Code"; Code[10])
        {
            Caption = 'Equity Correction Code';
            Description = 'MP 18-01-12';
            TableRelation = "Equity Correction Code";
        }
        field(60070; "Record Links"; Boolean)
        {
            CalcFormula = Exist("G/L Entry Document Link" WHERE("Transaction No." = FIELD("Transaction No."),
                                                                 "Document No." = FIELD("Document No.")));
            Caption = 'Links';
            Description = 'MP 18-01-12';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60080; "Description (English)"; Text[50])
        {
            Caption = 'Description (English)';
            Description = 'MP 18-01-12';
        }
        field(60090; "Corporate G/L Account Name"; Text[50])
        {
            CalcFormula = Lookup("Corporate G/L Account".Name WHERE("No." = FIELD("Corporate G/L Account No.")));
            Caption = 'Corporate G/L Account Name';
            Description = 'MP 27-11-15';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60110; Reversible; Boolean)
        {
            Caption = 'Reversible';
            Description = 'MD 25-09-12';
        }
        field(60111; "Reversed at"; Date)
        {
            Caption = 'Reversed at';
            Description = 'MD 25-09-12';
        }
        field(60112; "Reversal Entry No."; Integer)
        {
            Caption = 'Reversal Entry No.';
            Description = 'MD 09-10-12';
            TableRelation = "G/L Entry";
        }
        field(99090; "Client Entry No."; BigInteger)
        {
            Caption = 'Client Entry No.';
        }
        field(60113; "Updated New GL Entry"; Boolean)
        {
            Caption = 'Updated New GL Entry';
        }
    }
    keys
    {
        /*
        key(Key1; "Corporate G/L Account No.", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key2; "Corporate G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Adjustment Role", "GAAP Adjustment Reason", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key3; "Corporate G/L Account No.", "Business Unit Code", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key4; "Corporate G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Adjustment Role", "GAAP Adjustment Reason", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        
        key(Key5; "Global Dimension 1 Code", "Posting Date")
        {
        }
        *///SPS
        key(KeyNew6; "Client Entry No.")
        {
        }
        key(KeyNew; "Updated New GL Entry")
        { }
        /*
        key(Key7; "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "GAAP Adjustment Reason", "Posting Date")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = Amount;
        }
        key(Key8; Reversible, "Reversed at", "Posting Date")
        {
        }
        */
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    #4..32
    "User ID" := UserId;
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";
    "Prod. Order No." := GenJnlLine."Prod. Order No.";

    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..35

    //>>SUP:ISSUE:#117922
    "Purchase Order No." := GenJnlLine."Purchase Order No.";
    //<<SUP:ISSUE:#117922

    "Prod. Order No." := GenJnlLine."Prod. Order No.";


    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
}

