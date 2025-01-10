pageextension 50177 pageextension50177 extends "Get Post.Doc-P.Cr.MemoLn Sbfrm"
{

    //Unsupported feature: Code Modification on "IsShowRec(PROCEDURE 3)".

    //procedure IsShowRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    with PurchCrMemoLine2 do begin
      if "Document No." <> PurchCrMemoHeader."No." then
        PurchCrMemoHeader.Get("Document No.");
      if PurchCrMemoHeader."Prepayment Credit Memo" then
        exit(false);
      exit(true);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      if Type <> Type::Item then
        exit(true);
    end;
    */
    //end;
}

