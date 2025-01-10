pageextension 50131 pageextension50131 extends "General Journal"
{
    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 68)".


        //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 68)".

    }
}

