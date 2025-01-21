pageextension 50176 pageextension50176 extends "Get Post.Doc-S.Cr.MemoLn Sbfrm"
{

    //Unsupported feature: Code Modification on "IsShowRec(PROCEDURE 3)".

    //procedure IsShowRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeIsShowRec(Rec,SalesCrMemoLine2,ReturnValue,IsHandled);
    if IsHandled then
    #4..7
        SalesCrMemoHeader.Get("Document No.");
      if SalesCrMemoHeader."Prepayment Credit Memo" then
        exit(false);
      exit(true);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
      if Type <> Type::Item then
        exit(true);
    end;
    */
    //end;
}

