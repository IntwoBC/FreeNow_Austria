pageextension 50114 pageextension50114 extends "Incoming Documents"
{
    actions
    {
        modify(Release)
        {
            Visible = false;
        }
        modify(Reject)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
    }
}

