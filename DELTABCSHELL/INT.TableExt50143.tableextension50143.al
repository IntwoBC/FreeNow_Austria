tableextension 50143 tableextension50143 extends "Detailed CV Ledg. Entry Buffer"
{

    //Unsupported feature: Code Modification on "InsertDtldCVLedgEntry(PROCEDURE 53)".

    //procedure InsertDtldCVLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (DtldCVLedgEntryBuf.Amount = 0) and
       (DtldCVLedgEntryBuf."Amount (LCY)" = 0) and
       (DtldCVLedgEntryBuf."VAT Amount (LCY)" = 0) and
       (DtldCVLedgEntryBuf."Additional-Currency Amount" = 0) and
       (not InsertZeroAmout)
    then
    #7..75
      CVLedgEntryBuf."Original Amt. (LCY)" := NewDtldCVLedgEntryBuf."Amount (LCY)";
    end;
    DtldCVLedgEntryBuf.Reset;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if (DtldCVLedgEntryBuf.Amount = 0) and
       (DtldCVLedgEntryBuf."Amount (LCY)" = 0) and
    #4..78
    */
    //end;
}

