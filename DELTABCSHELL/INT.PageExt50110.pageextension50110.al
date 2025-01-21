pageextension 50110 pageextension50110 extends "Posted Sales Credit Memos"
{
    // PK 22-04-24 EY-MYWW0001 Feature 5836204 [CS0750506] -  Request for Price / Quote for Credit Notes in Naivsion - Mytaxi - Ireland
    // Field added
    //   - Invoice Reference
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Invoice Reference"; Rec."Invoice Reference")
            {
                Description = 'EY-MYWW0001';
                ApplicationArea = all;
            }
        }
    }
}

