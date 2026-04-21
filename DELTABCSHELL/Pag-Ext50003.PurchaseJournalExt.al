pageextension 50003 "Purchase Journal Ext" extends "Purchase Journal"
{
    //#73107	ES_BTY1-609_Purchase journal not showing account name
    layout
    {
        modify("<Vendor Name>")
        {
            Visible = false;
        }
        addafter("Account No.")
        {
            field(AccountName; AccName)
            {
                ApplicationArea = All;
                Caption = 'Account Name';
                Editable = false;
            }
        }
    }
}
