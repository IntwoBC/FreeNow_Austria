pageextension 50238 pageextension50238 extends Users
{
    layout
    {
        addafter("License Type")
        {
            field("Contact Email"; Rec."Contact Email")
            {
                ApplicationArea = all;
            }
        }
    }
}

