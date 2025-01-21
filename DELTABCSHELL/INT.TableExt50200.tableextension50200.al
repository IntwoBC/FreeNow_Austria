tableextension 50200 tableextension50200 extends "Service Item"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Customer No."(Field 8).OnValidate".

        //trigger "(Field 8)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Customer No." <> xRec."Customer No." then begin
          if CheckifActiveServContLineExist then
            Error(
              Text004,
              FieldCaption("Customer No."),"Customer No.",TableCaption,"No.");
          ServItemLinesExistErr(FieldCaption("Customer No."));
          if ServLedgEntryExist then
            if not ConfirmManagement.ConfirmProcess(
                 StrSubstNo(Text017,TableCaption,FieldCaption("Customer No.")),true)
        #10..18
          ServLogMgt.ServItemCustChange(Rec,xRec);
          ServLogMgt.ServItemShipToCodeChange(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          ErrMessageIfServItemLinesExist(FieldCaption("Customer No."));
        #7..21
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Ship-to Code" <> xRec."Ship-to Code" then begin
          if CheckifActiveServContLineExist then
            Error(
              Text004,
              FieldCaption("Ship-to Code"),"Ship-to Code",TableCaption,"No.");
          ServItemLinesExistErr(FieldCaption("Ship-to Code"));
          if ServLedgEntryExist then
            if not ConfirmManagement.ConfirmProcess(
                 StrSubstNo(Text017,TableCaption,FieldCaption("Customer No.")),true)
        #10..12
            end;
          ServLogMgt.ServItemShipToCodeChange(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          ErrMessageIfServItemLinesExist(FieldCaption("Ship-to Code"));
        #7..15
        */
        //end;
    }

    //Unsupported feature: Property Modification (Name) on "ServItemLinesExistErr(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "ServItemLinesExistErr(PROCEDURE 7)".

    //procedure ServItemLinesExistErr();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ServItemLinesExist then
      Error(
        ChgCustomerErr,
        ChangedFieldName,
        ServItemLine."Document No.",ServItemLine."Line No.",ServItemLine."Service Item No.",
        ServItemLine."Serial No.",ServItemLine."Customer No.",ServItemLine."Ship-to Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ServItemLinesExist then
      Error(
        Text016,
        ChangedFieldName);
    */
    //end;

    var
        Text016: Label 'You cannot change the %1 because there are outstanding service orders/quotes attached to it.';
}

