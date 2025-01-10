pageextension 50111 pageextension50111 extends "Posted Purchase Invoices"
{
    Caption = 'Posted Purchase Invoices';
    actions
    {
        modify("&Invoice")
        {
            Caption = '&Invoice';
        }
        modify(Statistics)
        {
            Caption = 'Statistics';
        }
        modify("Co&mments")
        {
            Caption = 'Co&mments';
        }
        modify(Dimensions)
        {
            Caption = 'Dimensions';
        }
        modify(IncomingDoc)
        {
            Caption = 'Incoming Document';
        }
        modify("&Print")
        {
            Caption = '&Print';
        }
    }
}

