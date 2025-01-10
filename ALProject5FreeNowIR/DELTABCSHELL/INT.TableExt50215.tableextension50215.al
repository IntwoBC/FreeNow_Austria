tableextension 50215 tableextension50215 extends "Gen. Journal Template"
{
    // MP 17-01-12
    // Added option "GAAP Adjustments" and "Tax Adjustments" to Type field
    // Fixed issue in std. NAV with TableRelation for "Form ID" in order to work with RTC.
    // Added field "Page ID"
    // 
    // MP 18-11-13
    // Added option "Group Adjustments" to Type field (CR 30)
    // 
    // MP 03-12-14
    // NAV 2013 R2 upgrade - removed obsolete field "Page Name"
    fields
    {
        modify(Type)
        {
            OptionCaption = 'General,Sales,Purchases,Cash Receipts,Payments,Assets,Intercompany,Jobs,,,,,,,,,,GAAP Adjustments,Tax Adjustments,Group Adjustments';

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 9)".

        }
        field(60000; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(60020; "Use Ready to Post"; Boolean)
        {
            Caption = 'Use Ready to Post';
            Description = 'MP 17-01-12';
        }
    }
}

