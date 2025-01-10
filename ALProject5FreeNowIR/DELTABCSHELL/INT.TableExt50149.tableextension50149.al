tableextension 50149 tableextension50149 extends "Posted Approval Entry"
{
    // #MyTaxi.W1.CRE.PURCH.018 24/06/2019 CCFR.SDE : P2P2 Approval Workflow Process (CRN201900012 Approval History View per approver)
    //   New added fields : 70000 "Source Type", 70001 "Source No.", 70002 "Source Name"
    Caption = 'Posted Approval Entry';
    fields
    {
        modify("Table ID")
        {
            Caption = 'Table ID';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Sequence No.")
        {
            Caption = 'Sequence No.';
        }
        modify("Approval Code")
        {
            Caption = 'Approval Code';
        }
        modify("Sender ID")
        {
            Caption = 'Sender ID';
        }
        modify("Salespers./Purch. Code")
        {
            Caption = 'Salespers./Purch. Code';
        }
        modify("Approver ID")
        {
            Caption = 'Approver ID';
        }
        modify(Status)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
        }
        modify("Date-Time Sent for Approval")
        {
            Caption = 'Date-Time Sent for Approval';
        }
        modify("Last Date-Time Modified")
        {
            Caption = 'Last Date-Time Modified';
        }
        modify("Last Modified By ID")
        {
            Caption = 'Last Modified By ID';
        }
        modify(Comment)
        {
            Caption = 'Comment';
        }
        modify("Due Date")
        {
            Caption = 'Due Date';
        }
        modify(Amount)
        {
            Caption = 'Amount';
        }
        modify("Amount (LCY)")
        {
            Caption = 'Amount (LCY)';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Approval Type")
        {
            Caption = 'Approval Type';
            OptionCaption = 'Workflow User Group,Sales Pers./Purchaser,Approver';
        }
        modify("Limit Type")
        {
            Caption = 'Limit Type';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits';
        }
        modify("Available Credit Limit (LCY)")
        {
            Caption = 'Available Credit Limit (LCY)';
        }
        modify("Posted Record ID")
        {
            Caption = 'Posted Record ID';
        }
        modify("Delegation Date Formula")
        {
            Caption = 'Delegation Date Formula';
        }
        modify("Number of Approved Requests")
        {
            Caption = 'Number of Approved Requests';
        }
        modify("Number of Rejected Requests")
        {
            Caption = 'Number of Rejected Requests';
        }
        modify("Iteration No.")
        {
            Caption = 'Iteration No.';
        }
        modify("Entry No.")
        {
            Caption = 'Entry No.';
        }
        field(70000; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Description = 'MyTaxi.W1.CRE.PURCH.018';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(70001; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Description = 'MyTaxi.W1.CRE.PURCH.018';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(70002; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
            Description = 'MyTaxi.W1.CRE.PURCH.018';
        }
    }
}

