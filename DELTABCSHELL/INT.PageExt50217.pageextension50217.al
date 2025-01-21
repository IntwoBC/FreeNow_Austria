pageextension 50217 pageextension50217 extends "Small Business Owner Act."
{

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Reset;
    if not Get then begin
      Init;
      Insert;
    end;
    SetFilter("Due Date Filter",'<=%1',WorkDate);
    SetFilter("Overdue Date Filter",'<%1',WorkDate);
    SetRange("User ID Filter",UserId);

    CalculateCueFieldValues;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    #7..10
    */
    //end;
}

