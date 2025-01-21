page 70004 "MyTaxi CRM Interface Documents"
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation
    // #MyTaxi.W1.CRE.INT01.008 22/11/2017 CCFR.SDE : New request
    //   Credit Note creation without invoice : new added action "Posted Sales Credit Memo"
    // #MyTaxi.W1.CRE.INT01.013 05/12/2018 CCFR.SDE : New request
    //   New added fields : businessAccountPaymentMethod,NAV Document Date
    // #MyTaxi.W1.CRE.INT01.015 26/12/2018 CCFR.SDE : New request
    //   New added fields : NAV Invoice Posted,NAV Credit Memo Posted,NAV Payment Posted
    //   New added action : Payment Ledger Entry
    // 
    // 
    // PK 22-04-24 EY-MYWW0001 Feature 5836204 [CS0750506] -  Request for Price / Quote for Credit Notes in Naivsion - Mytaxi - Ireland
    // Field added:
    //   - invoiceReference

    Caption = 'MyTaxi CRM Interface Documents';
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MyTaxi CRM Interface Records";
    SourceTableView = WHERE("Interface Type" = CONST(Invoice));
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
                field(id; Rec.id)
                {
                }
                field(country; Rec.country)
                {
                }
                field("Send Update"; Rec."Send Update")
                {
                }
                field(statusCode; Rec.statusCode)
                {
                }
                field(dateStatusChanged; Rec.dateStatusChanged)
                {
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
                field(invoiceid; Rec.invoiceid)
                {
                }
                field(externalReference; Rec.externalReference)
                {
                }
                field(invoiceType; Rec.invoiceType)
                {
                }
                field(idCustomer; Rec.idCustomer)
                {
                }
                field(dateInvoice; Rec.dateInvoice)
                {
                }
                field(dueDate; Rec.dueDate)
                {
                }
                field("NAV Document Date"; Rec."NAV Document Date")
                {
                }
                field(businessAccountPaymentMethod; Rec.businessAccountPaymentMethod)
                {
                }
                field(countryCode; Rec.countryCode)
                {
                }
                field(currency; Rec.currency)
                {
                }
                field(sumNetValue; Rec.sumNetValue)
                {
                }
                field(sumTaxValue; Rec.sumTaxValue)
                {
                }
                field(sumGrossValue; Rec.sumGrossValue)
                {
                }
                field(discountCommissionNet; Rec.discountCommissionNet)
                {
                }
                field(discountCommissionTax; Rec.discountCommissionTax)
                {
                }
                field(discountCommissionGross; Rec.discountCommissionGross)
                {
                }
                field(netCommission; Rec.netCommission)
                {
                }
                field(taxCommission; Rec.taxCommission)
                {
                }
                field(grossCommission; Rec.grossCommission)
                {
                }
                field(netHotelValue; Rec.netHotelValue)
                {
                }
                field(taxHotelValue; Rec.taxHotelValue)
                {
                }
                field(grossHotelValue; Rec.grossHotelValue)
                {
                }
                field(netInvoicingFee; Rec.netInvoicingFee)
                {
                }
                field(taxInvoicingFee; Rec.taxInvoicingFee)
                {
                }
                field(grossInvoicingFee; Rec.grossInvoicingFee)
                {
                }
                field(netPayment; Rec.netPayment)
                {
                }
                field(netPaymentFeeMP; Rec.netPaymentFeeMP)
                {
                }
                field(taxPaymentFeeMP; Rec.taxPaymentFeeMP)
                {
                }
                field(grossPaymentFeeMP; Rec.grossPaymentFeeMP)
                {
                }
                field(netPaymentFeeBA; Rec.netPaymentFeeBA)
                {
                }
                field(taxPaymentFeeBA; Rec.taxPaymentFeeBA)
                {
                }
                field(grossPaymentFeeBA; Rec.grossPaymentFeeBA)
                {
                }
                field(additionalInformation; Rec.additionalInformation)
                {
                }
                field(additionalNotes; Rec.additionalNotes)
                {
                }
                field("Process Status Description"; Rec."Process Status Description")
                {
                }
                field("NAV Invoice Status"; Rec."NAV Invoice Status")
                {
                }
                field("NAV Credit Memo Status"; Rec."NAV Credit Memo Status")
                {
                }
                field("NAV Payment Status"; Rec."NAV Payment Status")
                {
                }
                field(invoiceReference; Rec.invoiceReference)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000042; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Documents)
            {
                Caption = 'Documents';
                action("Sales Invoice")
                {
                    Caption = 'Sales Invoice';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec.externalReference);
                        PAGE.RunModal(PAGE::"Sales Invoice", SalesHeader);
                    end;
                }
                action("Sales Credit Memo")
                {
                    Caption = 'Sales Credit Memo';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Get(SalesHeader."Document Type"::"Credit Memo", Rec.externalReference);
                        PAGE.RunModal(PAGE::"Sales Credit Memo", SalesHeader);
                    end;
                }
                action("Cash Receipt Journal")
                {
                    Caption = 'Cash Receipt Journal';
                    Image = CashReceiptJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Cash Receipt Journal";

                    trigger OnAction()
                    var
                        MyTaxiCRMIntPostingSetup: Record "MyTaxi CRM Int. Posting Setup";
                        GenJournalLine: Record "Gen. Journal Line";
                    begin
                        /*MyTaxiCRMIntPostingSetup.GET(invoiceType);
                        GenJournalLine.SETRANGE("Journal Template Name",MyTaxiCRMIntPostingSetup."Cash Rec. Jnl. Template Name");
                        GenJournalLine.SETRANGE("Journal Batch Name",MyTaxiCRMIntPostingSetup."Cash Rec. Jnl. Batch Name");
                        PAGE.RUNMODAL(PAGE::"Cash Receipt Journal",GenJournalLine);*/

                    end;
                }
                group("Posted Sales Document")
                {
                    Caption = 'Posted Sales Document';
                    Image = PostDocument;
                    action("Posted Sales Invoice")
                    {
                        Caption = 'Posted Sales Invoice';
                        Image = PostDocument;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Posted Sales Invoices";
                        RunPageLink = "No." = FIELD(externalReference);
                    }
                    action("Posted Sales Credit Memo")
                    {
                        Caption = 'Posted Sales Credit Memo';
                        Description = 'MyTaxi.W1.CRE.INT01.008';
                        Image = PostDocument;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Posted Sales Credit Memos";
                        RunPageLink = "No." = FIELD(externalReference);
                    }
                    action("<Payment Ledger Entry>")
                    {
                        Caption = 'Payment Ledger Entry';
                        Image = CustomerLedger;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;

                        trigger OnAction()
                        var
                            CustLedgerEntry: Record "Cust. Ledger Entry";
                        begin
                            CustLedgerEntry.Reset;
                            CustLedgerEntry.SetRange("Customer No.", Format(Rec.idCustomer));
                            CustLedgerEntry.SetRange("Posting Date", Rec.dateInvoice);
                            CustLedgerEntry.SetRange("External Document No.", Rec.externalReference);
                            PAGE.RunModal(PAGE::"Customer Ledger Entries", CustLedgerEntry);
                        end;
                    }
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                action("Get MyTaxi Sales Documents")
                {
                    Caption = 'Get MyTaxi Sales Documents';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                    begin
                        MyTaxiCRMInterfaceWS.GetInvoices(0, false);
                    end;
                }
                action("Import MyTaxi Sales Documents File")
                {
                    Caption = 'Import MyTaxi Sales Documents File';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                    begin
                        MyTaxiCRMInterfaceWS.ImportInvoices;
                    end;
                }
                action("Create Sales Document")
                {
                    Caption = 'Create Sales Document';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MyTaxiCRMInterfaceRecords: Record "MyTaxi CRM Interface Records";
                        MyTaxiCRMInterfaceProcess: Codeunit "MyTaxi CRM Interface Process";
                        MyTaxiCRMInterfaceRecords2: Record "MyTaxi CRM Interface Records";
                    begin
                        CurrPage.SetSelectionFilter(MyTaxiCRMInterfaceRecords);
                        if MyTaxiCRMInterfaceRecords.FindSet then
                            repeat
                                ClearLastError;
                                Clear(MyTaxiCRMInterfaceProcess);
                                MyTaxiCRMInterfaceProcess.SetParams(2, MyTaxiCRMInterfaceRecords);
                                if not MyTaxiCRMInterfaceProcess.Run then begin
                                    MyTaxiCRMInterfaceRecords2.Get(MyTaxiCRMInterfaceRecords."Entry No.");
                                    MyTaxiCRMInterfaceRecords2."Process Status" := MyTaxiCRMInterfaceRecords."Process Status"::Error;
                                    MyTaxiCRMInterfaceRecords2."Process Status Description" := CopyStr(GetLastErrorText, 1, 250);
                                    MyTaxiCRMInterfaceRecords2.statusCode := 'ERROR';
                                    MyTaxiCRMInterfaceRecords2.dateStatusChanged := CurrentDateTime;
                                    MyTaxiCRMInterfaceRecords2."Send Update" := true;
                                    MyTaxiCRMInterfaceRecords2.Modify;
                                end;
                                Commit;
                            until MyTaxiCRMInterfaceRecords.Next = 0;
                    end;
                }
                action("Update MyTaxi Sales Documents")
                {
                    Caption = 'Update MyTaxi Sales Documents';
                    Image = RefreshLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MyTaxiCRMInterfaceRecords: Record "MyTaxi CRM Interface Records";
                        MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                    begin
                        CurrPage.SetSelectionFilter(MyTaxiCRMInterfaceRecords);
                        if MyTaxiCRMInterfaceRecords.FindSet then
                            repeat
                                MyTaxiCRMInterfaceWS.UpdateInvoice(MyTaxiCRMInterfaceRecords);
                            until MyTaxiCRMInterfaceRecords.Next = 0;
                    end;
                }
                action("Get MyTaxi Sales Document")
                {
                    Caption = 'Get MyTaxi Sales Document';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MyTaxiCRMInterfaceWS: Codeunit "MyTaxi CRM Interface WS";
                    begin
                        MyTaxiCRMInterfaceWS.GetInvoices(Rec.invoiceid, true);
                    end;
                }
            }
        }
    }

    local procedure ShowSalesDocument()
    begin
    end;
}

