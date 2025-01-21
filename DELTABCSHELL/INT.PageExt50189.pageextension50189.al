pageextension 50189 pageextension50189 extends "Requests to Approve"
{
    // #MyTaxi.W1.CRE.PURCH.017 07/06/2019 CCFR.SDE : P2P2 Approval Workflow Process (CRN201900012 Approval History View per approver)
    //   New added action : PostedRequests
    Caption = 'Requests to Approve';
    layout
    {
        modify(ToApprove)
        {
            Caption = 'To Approve';
        }
        modify(Details)
        {
            Caption = 'Details';
        }
        moveafter(Details; "Sender ID")
    }
    actions
    {
        modify(Show)
        {
            Caption = 'Show';
        }
        modify("Record")
        {
            Caption = 'Open Record';

            //Unsupported feature: Property Insertion (RunPageMode) on "Record(Action 38)".

        }
        modify(Comments)
        {
            Caption = 'Comments';
        }
        modify(Approve)
        {
            Caption = 'Approve';
        }
        modify(Reject)
        {
            Caption = 'Reject';
        }
        modify(Delegate)
        {
            Caption = 'Delegate';
            Visible = false;
        }
        modify(View)
        {
            Caption = 'View';
        }
        modify(OpenRequests)
        {
            Caption = 'Open Requests';
        }
        modify(AllRequests)
        {
            Caption = 'All Requests';
        }
        addafter(AllRequests)
        {
            action(PostedRequests)
            {
                Caption = 'Posted Requests';
                Description = 'MyTaxi.W1.CRE.PURCH.017';
                Image = PostingEntries;
                RunObject = Page "MyTaxi Posted Approval Entries";
                ApplicationArea = all;
            }
        }
    }
}

