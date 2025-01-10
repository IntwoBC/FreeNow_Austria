pageextension 50151 pageextension50151 extends "Opportunity List"
{

    //Unsupported feature: Property Modification (Id) on "Text001(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : 2004;
    //Variable type has not been exported.

    var
        Cont: Record Contact;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Campaign: Record Campaign;
        SegHeader: Record "Segment Header";


        //Unsupported feature: Code Modification on "Caption(PROCEDURE 1)".

        //procedure Caption();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        case true of
          BuildCaptionContact(CaptionStr,GetFilter("Contact Company No.")),
          BuildCaptionContact(CaptionStr,GetFilter("Contact No.")),
          BuildCaptionSalespersonPurchaser(CaptionStr,GetFilter("Salesperson Code")),
          BuildCaptionCampaign(CaptionStr,GetFilter("Campaign No.")),
          BuildCaptionSegmentHeader(CaptionStr,GetFilter("Segment No.")):
            exit(CaptionStr)
        end;

        exit(Text001);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Cont.Get(GetFilter("Contact Company No.")) then
          CaptionStr := CopyStr(Cont."No." + ' ' + Cont.Name,1,MaxStrLen(CaptionStr));
        if Cont.Get(GetFilter("Contact No.")) then
          CaptionStr := CopyStr(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name,1,MaxStrLen(CaptionStr));
        if SalesPurchPerson.Get(GetFilter("Salesperson Code")) then
          CaptionStr := CopyStr(CaptionStr + ' ' + SalesPurchPerson.Code + ' ' + SalesPurchPerson.Name,1,MaxStrLen(CaptionStr));
        if Campaign.Get(GetFilter("Campaign No.")) then
          CaptionStr := CopyStr(CaptionStr + ' ' + Campaign."No." + ' ' + Campaign.Description,1,MaxStrLen(CaptionStr));
        if SegHeader.Get(GetFilter("Segment No.")) then
          CaptionStr := CopyStr(CaptionStr + ' ' + SegHeader."No." + ' ' + SegHeader.Description,1,MaxStrLen(CaptionStr));
        if CaptionStr = '' then
          CaptionStr := Text001;

        exit(CaptionStr);
        */
        //end;
}

