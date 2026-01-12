pageextension 50227 pageextension50227 extends "Purchase Invoices"
{
    Caption = 'Purchase Invoices';
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("<Vendor Invoice No 1.>"; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Job Queue Status")
        {
            //#69855: Extension incompatibility
            // field("Amount Including VAT"; Rec."Amount Including VAT")
            // {
            //     ApplicationArea = all;
            // }
            field("Pending Approvals"; Rec."Pending Approvals")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("&Invoice")
        {
            Caption = '&Invoice';
        }
        modify(Statistics)
        {
            Caption = 'Statistics';
        }
        modify("Co&mments")
        {
            Caption = 'Co&mments';
        }
        modify(Dimensions)
        {
            Caption = 'Dimensions';
        }
        modify(Approvals)
        {
            Caption = 'Approvals';
        }
        modify(Action7)
        {
            Caption = 'Release';
        }
        modify(Release)
        {
            Caption = 'Re&lease';
        }
        modify(Reopen)
        {
            Caption = 'Re&open';
        }
        modify("Request Approval")
        {
            Caption = 'Request Approval';
        }
        modify(SendApprovalRequest)
        {
            Caption = 'Send A&pproval Request';
        }
        modify(CancelApprovalRequest)
        {
            Caption = 'Cancel Approval Re&quest';
        }
        modify("P&osting")
        {
            Caption = 'P&osting';
        }
        modify(Preview)
        {
            Caption = 'Preview Posting';
        }
        modify(TestReport)
        {
            Caption = 'Test Report';
        }
        modify(PostAndPrint)
        {
            Caption = 'Post and &Print';
        }
        modify(PostBatch)
        {
            Caption = 'Post &Batch';
        }
        modify(RemoveFromJobQueue)
        {
            Caption = 'Remove From Job Queue';
        }
    }
}

