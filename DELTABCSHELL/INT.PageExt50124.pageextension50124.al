pageextension 50124 pageextension50124 extends "Vendor Ledger Entries"
{
    // SUP:ISSUE:#111525  09/09/2021 COSMO.ABT
    //    # Show two fields ""IBAN / Bank Account" and "URL".
    // SUP:ISSUE:#112374  14/10/2021 COSMO.ABT
    //    # Show new field "E-mail".
    // SUP:ISSUE:#117922  24/08/2022 COSMO.ABT
    //    # Show new field "Purchase Order No.".
      layout
    {
        addafter("External Document No.")
        {
            field(URL; Rec.URL)
            {
                ApplicationArea = All;
                ToolTip = 'URL';
                Caption = 'URL';
            }
        }
    }
}

