report 70003 "Update MyTaxi CRM Inv To Check"
{
    Caption = 'Update MyTaxi CRM Invoices To Check';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MyTaxi CRM Invoices To Check"; "MyTaxi CRM Invoices To Check")
        {

            trigger OnAfterGetRecord()
            begin
                MyTaxiCRMInterfaceRecords.SetRange("Interface Type", MyTaxiCRMInterfaceRecords."Interface Type"::Invoice);
                MyTaxiCRMInterfaceRecords.SetRange(externalReference, externalReference);
                if MyTaxiCRMInterfaceRecords.FindLast then begin
                    "MyTaxi CRM Invoices To Check".statusCode := MyTaxiCRMInterfaceRecords.statusCode;
                    "MyTaxi CRM Invoices To Check".dateInvoice := MyTaxiCRMInterfaceRecords.dateInvoice;
                    "MyTaxi CRM Invoices To Check"."Transfer Date" := MyTaxiCRMInterfaceRecords."Transfer Date";
                    "MyTaxi CRM Invoices To Check"."Transfer Time" := MyTaxiCRMInterfaceRecords."Transfer Time";
                    "MyTaxi CRM Invoices To Check"."Process Status" := MyTaxiCRMInterfaceRecords."Process Status";
                    "MyTaxi CRM Invoices To Check"."Process Status Description" := MyTaxiCRMInterfaceRecords."Process Status Description";
                    "MyTaxi CRM Invoices To Check"."Send Update" := MyTaxiCRMInterfaceRecords."Send Update";
                    "MyTaxi CRM Invoices To Check"."Count CRM Table" := Count;
                    MyTaxiCRMInterfaceRecords.statusCode := 'NEW';
                    MyTaxiCRMInterfaceRecords.Modify;
                end;
                if SalesInvoiceHeader.Get(externalReference) then
                    "MyTaxi CRM Invoices To Check"."Booked in G/L NAV" := true;
                "MyTaxi CRM Invoices To Check".Modify;
            end;

            trigger OnPostDataItem()
            begin
                ModifyAll("Check Status", "Check Status"::Checked);
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Check Status","Check Status"::"To Check");
                //SalesInvoiceHeader.SETRANGE("Posting Date",TODAY);
                //ERROR(FORMAT(SalesInvoiceHeader.COUNT));
                //MyTaxiCRMInterfaceRecords.SETRANGE("Interface Type",MyTaxiCRMInterfaceRecords."Interface Type"::Invoice);
                //MyTaxiCRMInterfaceRecords.SETRANGE("Send Update",TRUE);
                //ERROR(FORMAT(MyTaxiCRMInterfaceRecords.COUNT));
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        MyTaxiCRMInterfaceRecords: Record "MyTaxi CRM Interface Records";
}

