pageextension 50146 pageextension50146 extends "Issued Reminder List"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Reminder Level"; Rec."Reminder Level")
            {
                ApplicationArea = all;
            }
        }
    }
}

