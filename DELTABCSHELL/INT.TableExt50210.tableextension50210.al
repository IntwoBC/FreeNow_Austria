tableextension 50210 tableextension50210 extends "Posted Invt. Put-away Header"
{

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckLocation;

    PostedInvtPutAwayLine.SetRange("No.","No.");
    PostedInvtPutAwayLine.DeleteAll;

    WhseCommentLine.SetRange("Table Name",WhseCommentLine."Table Name"::"Posted Invt. Put-Away");
    WhseCommentLine.SetRange(Type,WhseCommentLine.Type::" ");
    WhseCommentLine.SetRange("No.","No.");
    WhseCommentLine.DeleteAll;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..9
    */
    //end;
}

