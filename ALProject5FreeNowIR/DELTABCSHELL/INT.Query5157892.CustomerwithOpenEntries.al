query 50013 "Customer with Open Entries"
{
    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // PMT  14.07.16   OPplus Payment
    //                 - Object created
    // -----------------------------------------------------

    Caption = 'Customer with Open Entries';

    elements
    {
        dataitem(Cust_Ledger_Entry; "Cust. Ledger Entry")
        {
            DataItemTableFilter = Open = CONST(true);
            column(No; "Customer No.")
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

