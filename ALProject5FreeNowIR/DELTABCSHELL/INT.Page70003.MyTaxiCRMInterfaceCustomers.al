page 70003 "MyTaxi CRM Interface Customers"
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation
    // #MyTaxi.W1.CRE.INT01.009 02/01/2018 CCFR.SDE : New request
    //   New added fields : accountHolder,iban,bic,directDebitAllowed,bankAccountNumber,sortCode,statusCode
    // PK 12-08-24 EY-MYWW0002 Case CS0806754 / Feature 6079423
    // Action added:
    //   - Get MyTaxi Customers by ID

    Caption = 'MyTaxi CRM Interface Customers';
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MyTaxi CRM Interface Records";
    SourceTableView = WHERE("Interface Type" = CONST(Customer));
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Interface Type"; Rec."Interface Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                }
                field("Transfer Time"; Rec."Transfer Time")
                {
                }
                field("Process Status"; Rec."Process Status")
                {
                }
                field(company; Rec.company)
                {
                }
                field(id; Rec.id)
                {
                }
                field(number; Rec.number)
                {
                }
                field(name; Rec.name)
                {
                }
                field(orgNo; Rec.orgNo)
                {
                }
                field(address1; Rec.address1)
                {
                }
                field(city; Rec.city)
                {
                }
                field(zip; Rec.zip)
                {
                }
                field(country; Rec.country)
                {
                }
                field(tele1; Rec.tele1)
                {
                }
                field(email; Rec.email)
                {
                }
                field(contact; Rec.contact)
                {
                }
                field(vatNo; Rec.vatNo)
                {
                }
                field(customerGroup; Rec.customerGroup)
                {
                }
                field("Process Status Description"; Rec."Process Status Description")
                {
                }
                field(address2; Rec.address2)
                {
                }
                field(address3; Rec.address3)
                {
                }
                field(contact2; Rec.contact2)
                {
                }
                field(contact3; Rec.contact3)
                {
                }
                field(accountHolder; Rec.accountHolder)
                {
                }
                field(iban; Rec.iban)
                {
                }
                field(bic; Rec.bic)
                {
                }
                field(directDebitAllowed; Rec.directDebitAllowed)
                {
                }
                field(bankAccountNumber; Rec.bankAccountNumber)
                {
                }
                field(sortCode; Rec.sortCode)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000018; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Customer Card")
            {
                Caption = 'Customer Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                //RunObject = Page "Customer Card";
                //RunPageLink = "No." = FIELD(id);//SPS
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerCard: Page "Customer Card";
                begin
                    if Customer.Get(Rec.id) then begin
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();
                    end;
                end;
            }
            action("Get MyTaxi Customers")
            {
                Caption = 'Get MyTaxi Customers';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                 trigger OnAction()
                var
                    MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                    FromDate: Date;
                    ToDate: Date;
                    MyTaxiCRMInterfaceSetup: Record "MyTaxi CRM Interface Setup";
                begin
                    MyTaxiCRMInterfaceSetup.Get;
                    // Request user input for From Date and To Date
                    FromDate := MyTaxiCRMInterfaceSetup."Master Data Last Max Date";

                    if OpenDateDialog(FromDate, ToDate) then begin
                        // Call the interface with user-provided dates
                        MyTaxiCRMInterfaceWS.GetMasterData(FromDate, ToDate);
                    end;
                end;
            }
            action("Get MyTaxi Customers by ID")
            {
                Caption = 'Get MyTaxi Customers by ID';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                begin
                    // EY-MYWW0002 >>
                    MyTaxiCRMInterfaceWS.GetMasterDataByID;
                    // EY-MYWW0002 <<
                end;
            }
            action("Import MyTaxi Customers File")
            {
                Caption = 'Import MyTaxi Customers File';
                Image = FileContract;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                begin
                    MyTaxiCRMInterfaceWS.ImportMasterData;
                end;
            }
            action("Create Customers")
            {
                Caption = 'Create Customers';
                Image = EditCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MyTaxiCRMInterfaceRecords: Record "MyTaxi CRM Interface Records";
                    MyTaxiCRMInterfaceProcess: Codeunit "MyTaxi CRM Interface Process";
                begin
                    CurrPage.SetSelectionFilter(MyTaxiCRMInterfaceRecords);
                    MyTaxiCRMInterfaceRecords.SetRange("Transfer Date", 0D);
                    if MyTaxiCRMInterfaceRecords.FindFirst then
                        repeat
                            ClearLastError;
                            Clear(MyTaxiCRMInterfaceProcess);
                            MyTaxiCRMInterfaceProcess.SetParams(1, MyTaxiCRMInterfaceRecords);
                            if not MyTaxiCRMInterfaceProcess.Run then begin
                                MyTaxiCRMInterfaceRecords."Process Status" := MyTaxiCRMInterfaceRecords."Process Status"::Error;
                                MyTaxiCRMInterfaceRecords."Process Status Description" := CopyStr(GetLastErrorText, 1, 250);
                                MyTaxiCRMInterfaceRecords.Modify;
                            end;
                            Commit;
                        until MyTaxiCRMInterfaceRecords.Next = 0;
                end;
            }
        }
    }
    local procedure OpenDateDialog(var FromDate: Date; var ToDate: Date): Boolean
    var
        Dialog: Page "I2I Input Date Range Dialog"; // A custom page for date input
    begin
        Dialog.SetDateRange(FromDate, ToDate);
        if Dialog.RunModal = Action::OK then begin
            FromDate := Dialog.GetFromDate();
            ToDate := Dialog.GetToDate();
            exit(true);
        end;
        exit(false);
    end;
}

