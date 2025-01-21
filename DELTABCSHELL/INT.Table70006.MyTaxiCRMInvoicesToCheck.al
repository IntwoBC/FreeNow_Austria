table 70006 "MyTaxi CRM Invoices To Check"
{
    DataClassification = ToBeClassified;//SPS
    fields
    {
        field(1; externalReference; Text[30])
        {
        }
        field(2; statusCode; Text[10])
        {
        }
        field(3; dateInvoice; Date)
        {
        }
        field(4; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
        }
        field(5; "Transfer Time"; Time)
        {
            Caption = 'Transfer Time';
        }
        field(6; "Process Status"; Option)
        {
            Caption = 'Process Status';
            OptionMembers = " ",Error,Warning,Information;
        }
        field(7; "Process Status Description"; Text[250])
        {
            Caption = 'Process Status Description';
        }
        field(8; "Send Update"; Boolean)
        {
        }
        field(9; "Booked in G/L NAV"; Boolean)
        {
        }
        field(10; "Check Status"; Option)
        {
            OptionMembers = "To Check",Checked;
        }
        field(11; "Count CRM Table"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; externalReference)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

