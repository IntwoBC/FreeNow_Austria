query 50012 "Vendor with Open Entries"
{
    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // PMT  14.07.16   OPplus Payment
    //                 - Object created
    // -----------------------------------------------------

    Caption = 'Vendor with Open Entries';

    elements
    {
        dataitem(Vendor_Ledger_Entry; "Vendor Ledger Entry")
        {
            DataItemTableFilter = Open = CONST(true);
            column(No; "Vendor No.")
            {
            }
            column(No_Of_Open_Entries)
            {
                Caption = 'No. of Open Entries';
                Method = Count;
            }
        }
    }
}

