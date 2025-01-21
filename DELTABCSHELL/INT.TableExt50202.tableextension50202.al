tableextension 50202 tableextension50202 extends "Service Contract Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 16).OnValidate".

        //trigger "(Field 16)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckChangeStatus;
        if xRec."Bill-to Customer No." <> "Bill-to Customer No." then
          if xRec."Bill-to Customer No." <> '' then begin
        #4..36
              "Bill-to Contact" := Cust.Contact;
          end;

          if not HideValidationDialog then
            CustCheckCrLimit.ServiceContractHeaderCheck(Rec);

          CalcFields(
            "Bill-to Name","Bill-to Name 2","Bill-to Address","Bill-to Address 2",
            "Bill-to Post Code","Bill-to City","Bill-to County","Bill-to Country/Region Code");
        #46..54
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Service Contract Template","Template No.",
          DATABASE::"Service Order Type","Service Order Type");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..39
        #43..57
        */
        //end;
    }
}

