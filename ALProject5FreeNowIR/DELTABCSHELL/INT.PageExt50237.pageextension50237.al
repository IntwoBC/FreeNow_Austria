pageextension 50237 pageextension50237 extends "Purch. Cr. Memo Subform"
{
    Caption = 'Lines';
    layout
    {
        modify("Invoice Discount Amount")
        {
            Caption = 'Invoice Discount Amount';
        }
        modify("Invoice Disc. Pct.")
        {
            Caption = 'Invoice Discount %';
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Amount Excl. VAT';
        }
        modify("Total VAT Amount")
        {
            Caption = 'Total VAT';
        }
        modify("Total Amount Incl. VAT")
        {
            Caption = 'Total Amount Incl. VAT';
        }

    }
    actions
    {
        modify(InsertExtTexts)
        {
            Caption = 'Insert &Ext. Texts';
        }
        modify(Dimensions)
        {
            Caption = 'Dimensions';
        }
        modify(DeferralSchedule)
        {
            Caption = 'Deferral Schedule';
        }
        modify("F&unctions")
        {
            Caption = 'F&unctions';
        }
        modify("E&xplode BOM")
        {
            Caption = 'E&xplode BOM';
        }
        modify(GetReturnShipmentLines)
        {
            Caption = 'Get Return &Shipment Lines';
        }
        modify("&Line")
        {
            Caption = '&Line';
        }
        modify("Item Availability by")
        {
            Caption = 'Item Availability by';
        }
        modify("Event")
        {
            Caption = 'Event';
        }
        modify(Period)
        {
            Caption = 'Period';
        }
        modify(Variant)
        {
            Caption = 'Variant';
        }
        modify(Location)
        {
            Caption = 'Location';
        }
        modify("BOM Level")
        {
            Caption = 'BOM Level';
        }
        modify("Co&mments")
        {
            Caption = 'Co&mments';
        }
        modify("Item Charge &Assignment")
        {
            Caption = 'Item Charge &Assignment';
        }
        modify("Item &Tracking Lines")
        {
            Caption = 'Item &Tracking Lines';
        }
    }


    //Unsupported feature: Property Modification (TextConstString) on "Text000(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Unable to run this function while in View mode.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : DEU=Diese Funktion kann im Ansichtsmodus nicht ausgeführt werden.;ENU=Unable to run this function while in View mode.;
    //Variable type has not been exported.
}

