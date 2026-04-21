pageextension 50002 "G/Laccountcard" extends "G/L Account Card"
{
    layout
    {
        addafter(Totaling)
        {
            field("Financial Statement Code"; Rec."Financial Statement Code")
            {
                ApplicationArea = all;
                Caption = 'Financial Statement Code';
                ToolTip = 'Specifies the financial statement code for the G/L account.';
                TableRelation = "Financial Statement Code";
                Editable = true;
            }
        }
    }
}
