tableextension 50217 tableextension50217 extends "Cash Flow Setup"
{
    // #107661.001  19/04/21  COSMO.AMH : New Fields 50000..50013
    // SUP:ISSUE:#110847  23/07/2021  COSMO.ABT
    //    # Added two new fields: 50020 "AR Bank Account No." Code[20].
    //                            50021 "AP Bank Account No." Code[20].
    fields
    {
        field(50000; "Cash Flow Forecast"; Code[20])
        {
            Caption = 'Cash Flow Forecast';
            TableRelation = "Cash Flow Forecast";
        }
        field(50001; "Liquid Funds"; Boolean)
        {
            Caption = 'Liquid Funds';
            Description = '107661';
        }
        field(50002; Receivables; Boolean)
        {
            Caption = 'Receivables';
            Description = '107661';
        }
        field(50003; "Sales Orders"; Boolean)
        {
            Caption = 'Sales Orders';
            Description = '107661';
        }
        field(50004; "Service Orders"; Boolean)
        {
            Caption = 'Service Orders';
            Description = '107661';
        }
        field(50005; "Fixed Assets Disposal"; Boolean)
        {
            Caption = 'Fixed Assets Disposal';
            Description = '107661';
        }
        field(50006; "Cash Flow Manual Revenues"; Boolean)
        {
            Caption = 'Cash Flow Manual Revenues';
            Description = '107661';
        }
        field(50007; Payables; Boolean)
        {
            Caption = 'Payables';
            Description = '107661';
        }
        field(50008; "Purchase Orders"; Boolean)
        {
            Caption = 'Purchase Orders';
            Description = '107661';
        }
        field(50009; "Fixed Assets Budget"; Boolean)
        {
            Caption = 'Fixed Assets Budget';
            Description = '107661';
        }
        field(50010; "Cash Flow Manual Expenses"; Boolean)
        {
            Caption = 'Cash Flow Manual Expenses';
            Description = '107661';
        }
        field(50011; "G/L Budget"; Boolean)
        {
            Caption = 'G/L Budget';
            Description = '107661';
        }
        field(50012; "G/L Budget Name"; Code[10])
        {
            Caption = 'G/L Budget Name';
            Description = '107661';
        }
        field(50013; "Group By Document Type"; Boolean)
        {
            Caption = 'Group By Document Type';
            Description = '107661';
        }
        field(50020; "AR Bank Account No."; Code[20])
        {
            Caption = 'AR Bank Account No.';
            Description = 'SUP:ISSUE:#110847';
            TableRelation = "Bank Account"."No.";
        }
        field(50021; "AP Bank Account No."; Code[20])
        {
            Caption = 'AP Bank Account No.';
            Description = 'SUP:ISSUE:#110847';
            TableRelation = "Bank Account"."No.";
        }
    }
}

