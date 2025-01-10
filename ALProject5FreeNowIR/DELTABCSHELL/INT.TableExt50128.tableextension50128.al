tableextension 50128 tableextension50128 extends "Customer Bank Account"
{
    // -----------------------------------------------------
    // (c) gbedv, OPplus, All rights reserved
    // 
    // No.  Date       changed
    // -----------------------------------------------------
    // EA   01.11.08   Extended Application
    //                 - New Field added
    //                 - 2nd Key Field added :
    //                   Bank Branch No.,Bank Account No.
    //                 - 3rd Key added:
    //                   IBAN
    // PMT  01.11.08   OPplus Payment
    //                 - New Fields added
    //                 - Lookup Bank Branch No.
    // -----------------------------------------------------
    keys
    {
        /* key(Key1; "Bank Branch No.", "Bank Account No.")
         {
         }*///SPS
    }
}

