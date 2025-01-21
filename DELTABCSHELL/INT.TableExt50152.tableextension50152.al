tableextension 50152 tableextension50152 extends Contact
{

    //Unsupported feature: Property Modification (Permissions) on "Contact(Table 5050)".


    //Unsupported feature: Code Modification on "CreateCustomer(PROCEDURE 3)".

    //procedure CreateCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    CheckIfPrivacyBlockedGeneric;
    RMSetup.Get;
    RMSetup.TestField("Bus. Rel. Code for Customers");

    if CustomerTemplate <> '' then
      if CustTemplate.Get(CustomerTemplate) then;

    Clear(Cust);
    Cust.SetInsertFromContact(true);
    Cust."Contact Type" := Type;
    OnBeforeCustomerInsert(Cust,CustomerTemplate,Rec);
    Cust.Insert(true);
    Cust.SetInsertFromContact(false);

    ContBusRel."Contact No." := "No.";
    ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Customers";
    ContBusRel."Link to Table" := ContBusRel."Link to Table"::Customer;
    ContBusRel."No." := Cust."No.";
    ContBusRel.Insert(true);

    UpdateCustVendBank.UpdateCustomer(Rec,ContBusRel);

    Cust.Get(ContBusRel."No.");
    if Type = Type::Company then
      Cust.Validate(Name,"Company Name");

    OnCreateCustomerOnBeforeCustomerModify(Cust,Rec);
    Cust.Modify;

    if CustTemplate.Code <> '' then begin
      if "Territory Code" = '' then
        Cust."Territory Code" := CustTemplate."Territory Code"
      else
        Cust."Territory Code" := "Territory Code";
      if "Currency Code" = '' then
        Cust."Currency Code" := CustTemplate."Currency Code"
      else
        Cust."Currency Code" := "Currency Code";
      if "Country/Region Code" = '' then
        Cust."Country/Region Code" := CustTemplate."Country/Region Code"
      else
        Cust."Country/Region Code" := "Country/Region Code";
      Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
      Cust."Customer Price Group" := CustTemplate."Customer Price Group";
      if CustTemplate."Invoice Disc. Code" <> '' then
        Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
      Cust."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
      Cust."Allow Line Disc." := CustTemplate."Allow Line Disc.";
      Cust."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
      Cust."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
      Cust."Payment Terms Code" := CustTemplate."Payment Terms Code";
      Cust."Payment Method Code" := CustTemplate."Payment Method Code";
      Cust."Prices Including VAT" := CustTemplate."Prices Including VAT";
      Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
      Cust.UpdateReferencedIds;
      OnCreateCustomerOnTransferFieldsFromTemplate(Cust,CustTemplate);
      Cust.Modify;

      DefaultDim.SetRange("Table ID",DATABASE::"Customer Template");
      DefaultDim.SetRange("No.",CustTemplate.Code);
      if DefaultDim.Find('-') then
        repeat
          Clear(DefaultDim2);
          DefaultDim2.Init;
          DefaultDim2.Validate("Table ID",DATABASE::Customer);
          DefaultDim2."No." := Cust."No.";
          DefaultDim2.Validate("Dimension Code",DefaultDim."Dimension Code");
          DefaultDim2.Validate("Dimension Value Code",DefaultDim."Dimension Value Code");
          DefaultDim2."Value Posting" := DefaultDim."Value Posting";
          DefaultDim2.Insert(true);
        until DefaultDim.Next = 0;
    end;

    OnCreateCustomerOnBeforeUpdateQuotes(Cust,Rec);

    UpdateQuotes(Cust,CustomerTemplate);
    CampaignMgt.ConverttoCustomer(Rec,Cust);
    if OfficeMgt.IsAvailable then
      PAGE.Run(PAGE::"Customer Card",Cust)
    else
      if not HideValidationDialog then
        Message(RelatedRecordIsCreatedMsg,Cust.TableCaption);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..31
      Cust."Territory Code" := "Territory Code";
      Cust."Currency Code" := CustTemplate."Currency Code";
      Cust."Country/Region Code" := "Country/Region Code";
    #44..83
    */
    //end;

    //Unsupported feature: Property Deletion (DrillDownPageID).

}

