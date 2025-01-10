pageextension 50213 pageextension50213 extends "Account Manager Activities"
{
    // #MyTaxi.W1.CRE.PURCH.017 07/06/2019 CCFR.SDE : P2P2 Approval Workflow Process (CRN201900011 Requests to approver per approver in cue)
    //   New added field : 70000 "All Requests Sent for Approval"
    //   Modified field : "Requests Sent for Approval" deactivated
    //   Modified trigger : OnOpenPage
    Caption = 'Activities';
    layout
    {
        modify(Payments)
        {
            Caption = 'Payments';
        }
        modify("Document Approvals")
        {
            Caption = 'Document Approvals';
        }
        modify("Incoming Documents")
        {
            Caption = 'Incoming Documents';
        }
        addfirst(Content)
        {
            /*field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
            {
                Description = 'MyTaxi.W1.CRE.PURCH.017';
                DrillDownPageID = "Approval Entries";
                Enabled = false;
                Visible = false;
            }*/
        }
    }
    actions
    {
        /*
        modify("Payments(Control 6).""Edit Cash Receipt Journal""")
        {
            Caption = 'Edit Cash Receipt Journal';
        }
        modify("Payments(Control 6).""New Sales Credit Memo""")
        {
            Caption = 'New Sales Credit Memo';
        }
        modify("Payments(Control 6).""Edit Payment Journal""")
        {
            Caption = 'Edit Payment Journal';
        }
        modify("Payments(Control 6).""New Purchase Credit Memo""")
        {
            Caption = 'New Purchase Credit Memo';
        }
        modify("""Document Approvals""(Control 19).""Create Reminders...""")
        {
            Caption = 'Create Reminders...';
        }
        modify("""Document Approvals""(Control 19).""Create Finance Charge Memos...""")
        {
            Caption = 'Create Finance Charge Memos...';
        }
        modify("""Incoming Documents""(Control 2).CheckForOCR")
        {
            Caption = 'Receive from OCR Service';
        }
        */
    }
}

