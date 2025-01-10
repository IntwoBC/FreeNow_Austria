tableextension 50223 tableextension50223 extends "Warehouse Basic Cue"
{
    fields
    {
        modify("Rlsd. Sales Orders Until Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Rlsd. Sales Orders Until Today"(Field 2)".

            Caption = 'Released Sales Orders - Today';
        }
        modify("Exp. Purch. Orders Until Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Exp. Purch. Orders Until Today"(Field 4)".

            Caption = 'Expected Purch. Orders - Today';
        }
        modify("Invt. Picks Until Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Invt. Picks Until Today"(Field 6)".

            Caption = 'Inventory Picks - Today';
        }
        modify("Invt. Put-aways Until Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Invt. Put-aways Until Today"(Field 7)".

            Caption = 'Inventory Put-aways - Today';
        }
    }
}

