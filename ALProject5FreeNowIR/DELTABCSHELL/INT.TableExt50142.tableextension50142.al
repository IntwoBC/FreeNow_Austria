tableextension 50142 tableextension50142 extends "Purchase Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Lead Time Calculation"(Field 5792).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

        if "Lead Time Calculation" <> xRec."Lead Time Calculation" then
          UpdatePurchLinesByFieldNo(FieldNo("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        #1..3

        if "Lead Time Calculation" <> xRec."Lead Time Calculation" then
          UpdatePurchLinesByFieldNo(FieldNo("Lead Time Calculation"),CurrFieldNo <> 0);
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
      Error(
        Text023,
    #4..9
    Validate("Applies-to ID",'');
    Validate("Incoming Document Entry No.",0);

    ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RecordId);
    PurchLine.LockTable;

    WhseRequest.SetRange("Source Type",DATABASE::"Purchase Line");
    #17..36
       (PurchCrMemoHeaderPrepmt."No." <> '')
    then
      Message(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12

    ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RecordId);

    #14..39
    */
    //end;


    //Unsupported feature: Property Modification (Id) on "LeadTimeMgt(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //LeadTimeMgt : 1002;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LeadTimeMgt : 6002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PostedDocsToPrintCreatedMsg(Variable 1083)".

    //var
    //>>>> ORIGINAL VALUE:
    //PostedDocsToPrintCreatedMsg : 1083;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostedDocsToPrintCreatedMsg : 5083;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MixedDropshipmentErr(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //MixedDropshipmentErr : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MixedDropshipmentErr : 5001;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SplitMessageTxt(Variable 1085)".

    //var
    //>>>> ORIGINAL VALUE:
    //SplitMessageTxt : 1085;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SplitMessageTxt : 5085;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "CalledFromWhseDoc(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalledFromWhseDoc : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalledFromWhseDoc : 2000;
    //Variable type has not been exported.

    var
        Text000: Label 'Do you want to print receipt %1?';
        Text001: Label 'Do you want to print invoice %1?';
        Text002: Label 'Do you want to print credit memo %1?';

    var
        Text024: Label 'Do you want to print return shipment %1?';

    var
        ArchiveManagement: Codeunit ArchiveManagement;

    var
        Text043: Label 'Do you want to print prepayment invoice %1?';
        Text044: Label 'Do you want to print prepayment credit memo %1?';
}

