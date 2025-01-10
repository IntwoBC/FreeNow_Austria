pageextension 50190 pageextension50190 extends "Approval Comments"
{
    Caption = 'Approval Comments';

    //Unsupported feature: Property Modification (DataCaptionFields) on ""Approval Comments"(Page 660)".

    layout
    {
        addfirst(Control1)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

