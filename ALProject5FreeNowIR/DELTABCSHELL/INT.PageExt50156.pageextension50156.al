pageextension 50156 pageextension50156 extends "Purchase Lines"
{
    layout
    {
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
            ApplicationArea = all;
        }
        moveafter("Line Amount"; "Shortcut Dimension 2 Code")
    }
}

