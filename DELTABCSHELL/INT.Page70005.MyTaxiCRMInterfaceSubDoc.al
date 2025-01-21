page 70005 "MyTaxi CRM Interface Sub Doc."
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation

    Caption = 'MyTaxi CRM Interface Sub Document';
    PageType = List;
    SourceTable = "MyTaxi CRM Interf Sub Records";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Records Entry No."; Rec."Records Entry No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(invoiceid; Rec.invoiceid)
                {
                }
                field(typeOfAdditionalNote; Rec.typeOfAdditionalNote)
                {
                }
                field(accountNumber; Rec.accountNumber)
                {
                }
                field(netCredit; Rec.netCredit)
                {
                }
                field(taxCredit; Rec.taxCredit)
                {
                }
                field(grossCredit; Rec.grossCredit)
                {
                }
            }
        }
    }

    actions
    {
    }
}

