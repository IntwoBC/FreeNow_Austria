tableextension 50199 tableextension50199 extends "Service Item Line"
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
    }
}

