page 70008 "MyTaxi CRM Invoices To Check"
{
    PageType = List;
    SourceTable = "MyTaxi CRM Invoices To Check";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(externalReference; Rec.externalReference)
                {
                }
                field(statusCode; Rec.statusCode)
                {
                }
                field(dateInvoice; Rec.dateInvoice)
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
                field("Process Status Description"; Rec."Process Status Description")
                {
                }
                field("Send Update"; Rec."Send Update")
                {
                }
                field("Booked in G/L NAV"; Rec."Booked in G/L NAV")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Invoices To Check")
            {
                RunObject = Report "Update MyTaxi CRM Inv To Check";
            }
        }
    }
}

