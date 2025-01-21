tableextension 50226 tableextension50226 extends "Finance Cue"
{
    // #MyTaxi.W1.CRE.INT01.017 28/05/2019 CCFR.SDE : P2P2 Approval Workflow Process
    //   New added field : 70000 "All Requests Sent for Approval"
    Caption = 'Finance Cue';
    fields
    {
        modify("Primary Key")
        {
            Caption = 'Primary Key';
        }
        modify("Overdue Sales Documents")
        {
            Caption = 'Overdue Sales Documents';
        }
        modify("POs Pending Approval")
        {
            Caption = 'POs Pending Approval';
        }
        modify("SOs Pending Approval")
        {
            Caption = 'SOs Pending Approval';
        }
        modify("Approved Sales Orders")
        {
            Caption = 'Approved Sales Orders';
        }
        modify("Approved Purchase Orders")
        {
            Caption = 'Approved Purchase Orders';
        }
        modify("Vendors - Payment on Hold")
        {
            Caption = 'Vendors - Payment on Hold';
        }
        modify("Purchase Return Orders")
        {
            Caption = 'Purchase Return Orders';
        }
        modify("Sales Return Orders - All")
        {
            Caption = 'Sales Return Orders - All';
        }
        modify("Customers - Blocked")
        {
            Caption = 'Customers - Blocked';
        }
        modify("Due Date Filter")
        {
            Caption = 'Due Date Filter';
        }
        modify("Overdue Date Filter")
        {
            Caption = 'Overdue Date Filter';
        }
        modify("New Incoming Documents")
        {
            Caption = 'New Incoming Documents';
        }
        modify("Approved Incoming Documents")
        {
            Caption = 'Approved Incoming Documents';
        }
        modify("OCR Pending")
        {
            Caption = 'OCR Pending';
        }
        modify("OCR Completed")
        {
            Caption = 'OCR Completed';
        }
        /*
        modify("Requests to Approve")
        {
            Caption = 'Requests to Approve';
        }
        modify("Requests Sent for Approval")
        {
            Caption = 'Requests Sent for Approval';
        }
        modify("User ID Filter")
        {
            Caption = 'User ID Filter';
        }
        */
        field(70000; "All Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status = FILTER(Open)));
            Caption = 'All Requests Sent for Approval';
            Description = 'MyTaxi.W1.CRE.INT01.017';
            FieldClass = FlowField;
        }
    }
}

