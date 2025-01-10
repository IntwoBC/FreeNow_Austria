pageextension 50192 pageextension50192 extends "Purchase Return Order"
{
    layout
    {

        //Unsupported feature: Property Insertion (SubPageLink) on "ApprovalFactBox(Control 1906354007)".

    }
    actions
    {

        //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 23)".


        //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 23)".

        modify(Comment)
        {
            Visible = false;
            ApplicationArea = all;
        }
    }
}

