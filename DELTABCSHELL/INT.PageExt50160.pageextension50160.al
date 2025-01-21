pageextension 50160 pageextension50160 extends "Purch. Invoice Subform"
{
    Caption = 'Lines';
    layout
    {
        modify(InvoiceDiscountAmount)
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

        addafter("Line No.")
        {

            field("VAT Difference"; Rec."VAT Difference")
            {
                Editable = true;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            Caption = '&Line';
        }
        modify("F&unctions")
        {
            Caption = 'F&unctions';
        }
        modify("E&xplode BOM")
        {
            Caption = 'E&xplode BOM';
        }
        modify(InsertExtTexts)
        {
            Caption = 'Insert &Ext. Texts';
        }
        modify(GetReceiptLines)
        {
            Caption = '&Get Receipt Lines';
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
        modify(Dimensions)
        {
            Caption = 'Dimensions';
        }
        modify("Co&mments")
        {
            Caption = 'Co&mments';
        }
        modify(ItemChargeAssignment)
        {
            Caption = 'Item Charge &Assignment';
        }
        modify("Item &Tracking Lines")
        {
            Caption = 'Item &Tracking Lines';
        }
        modify(DeferralSchedule)
        {
            Caption = 'Deferral Schedule';
        }
    }
}

