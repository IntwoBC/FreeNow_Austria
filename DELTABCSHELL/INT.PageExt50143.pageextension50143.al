pageextension 50143 pageextension50143 extends "Reminder List"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Reminder Level"; Rec."Reminder Level")
            {
                ApplicationArea = all;
            }
        }
    }
}

