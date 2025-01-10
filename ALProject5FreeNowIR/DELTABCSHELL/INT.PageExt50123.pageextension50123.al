pageextension 50123 pageextension50123 extends "Vendor List"
{
    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Balance (LCY)"(Control 32)".

        addafter("Phone No.")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
        modify("Ven&dor")
        {
            Caption = 'Ven&dor';
        }
        modify(Dimensions)
        {
            Caption = 'Dimensions';
        }
        modify(DimensionsSingle)
        {
            Caption = 'Dimensions-Single';
        }
        modify(DimensionsMultiple)
        {
            Caption = 'Dimensions-&Multiple';
        }
        modify("Bank Accounts")
        {
            Caption = 'Bank Accounts';
        }
        modify("C&ontact")
        {
            Caption = 'C&ontact';
        }
        modify(OrderAddresses)
        {
            Caption = 'Order &Addresses';
        }
        modify("Co&mments")
        {
            Caption = 'Co&mments';
        }

        modify("&Purchases")
        {
            Caption = '&Purchases';
        }
        modify(Items)
        {
            Caption = 'Items';
        }
        modify("Invoice &Discounts")
        {
            Caption = 'Invoice &Discounts';
        }
        modify(Prices)
        {
            Caption = 'Prices';
        }
        modify("Line Discounts")
        {
            Caption = 'Line Discounts';
        }
        modify("Prepa&yment Percentages")
        {
            Caption = 'Prepa&yment Percentages';
        }
        modify(Documents)
        {
            Caption = 'Documents';
        }
        modify(Quotes)
        {
            Caption = 'Quotes';
        }
        modify(Orders)
        {
            Caption = 'Orders';
        }
        modify("Return Orders")
        {
            Caption = 'Return Orders';
        }
        modify("Blanket Orders")
        {
            Caption = 'Blanket Orders';
        }
        modify(History)
        {
            Caption = 'History';
        }
        modify("Ledger E&ntries")
        {
            Caption = 'Ledger E&ntries';
        }
        modify(Statistics)
        {
            Caption = 'Statistics';
        }
        modify(Purchases)
        {
            Caption = 'Purchases';
        }
        modify("Entry Statistics")
        {
            Caption = 'Entry Statistics';
        }
        modify("Statistics by C&urrencies")
        {
            Caption = 'Statistics by C&urrencies';
        }
        modify("Item &Tracking Entries")
        {
            Caption = 'Item &Tracking Entries';
        }
        modify(NewBlanketPurchaseOrder)
        {
            Caption = 'Blanket Purchase Order';
        }
        modify(NewPurchaseQuote)
        {
            Caption = 'Purchase Quote';
        }
        modify(NewPurchaseInvoice)
        {
            Caption = 'Purchase Invoice';
        }
        modify(NewPurchaseOrder)
        {
            Caption = 'Purchase Order';
        }
        modify(NewPurchaseCrMemo)
        {
            Caption = 'Purchase Credit Memo';
        }
        modify(NewPurchaseReturnOrder)
        {
            Caption = 'Purchase Return Order';
        }
        modify("Request Approval")
        {
            Caption = 'Request Approval';
        }
        modify(SendApprovalRequest)
        {
            Caption = 'Send A&pproval Request';
        }
        modify(CancelApprovalRequest)
        {
            Caption = 'Cancel Approval Re&quest';
        }
        modify("Payment Journal")
        {
            Caption = 'Payment Journal';
        }
        modify("Purchase Journal")
        {
            Caption = 'Purchase Journal';
        }
        modify(General)
        {
            Caption = 'General';
        }
        modify("Vendor - List")
        {
            Caption = 'Vendor - List';
        }
        modify("Vendor Register")
        {
            Caption = 'Vendor Register';
        }
        modify("Vendor Item Catalog")
        {
            Caption = 'Vendor Item Catalog';
        }
        modify("Vendor - Labels")
        {
            Caption = 'Vendor - Labels';
        }
        modify("Vendor - Top 10 List")
        {
            Caption = 'Vendor - Top 10 List';
        }
        modify(Action5)
        {
            Caption = 'Orders';
        }
        modify("Vendor - Order Summary")
        {
            Caption = 'Vendor - Order Summary';
        }
        modify("Vendor - Order Detail")
        {
            Caption = 'Vendor - Order Detail';
        }
        modify(Purchase)
        {
            Caption = 'Purchase';
        }
        modify("Vendor - Purchase List")
        {
            Caption = 'Vendor - Purchase List';
        }
        modify("Vendor/Item Purchases")
        {
            Caption = 'Vendor/Item Purchases';
        }
        modify("Purchase Statistics")
        {
            Caption = 'Purchase Statistics';
        }
        modify("Financial Management")
        {
            Caption = 'Financial Management';
        }
        modify("Payments on Hold")
        {
            Caption = 'Payments on Hold';
        }
        modify("Vendor - Summary Aging")
        {
            Caption = 'Vendor - Summary Aging';
        }
        modify("Aged Accounts Payable")
        {
            Caption = 'Aged Accounts Payable';
        }
        modify("Vendor - Balance to Date")
        {
            Caption = 'Vendor - Balance to Date';
        }
        modify("Vendor - Trial Balance")
        {
            Caption = 'Vendor - Trial Balance';
        }
        modify("Vendor - Detail Trial Balance")
        {
            Caption = 'Vendor - Detail Trial Balance';
        }
    }
}

