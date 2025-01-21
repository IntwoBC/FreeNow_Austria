pageextension 50145 pageextension50145 extends "Sales Credit Memo"
{
    // PK 22-04-24 EY-MYWW0001 Feature 5836204 [CS0750506] -  Request for Price / Quote for Credit Notes in Naivsion - Mytaxi - Ireland
    // Field added
    //   - Invoice Reference
    layout
    {
        addafter("Posting Date")
        {
            field("<Posting Description 1>"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }
        }
        addafter("External Document No.")
        {
            field("Invoice Reference"; Rec."Invoice Reference")
            {
                Description = 'EY-MYWW0001';
                ApplicationArea = all;
            }
        }
    }
}

