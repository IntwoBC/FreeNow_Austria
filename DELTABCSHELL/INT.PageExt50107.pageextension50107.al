pageextension 50107 pageextension50107 extends "Posted Sales Invoice"
{
    // PK 22-04-24 EY-MYWW0001 Feature 5836204 [CS0750506] -  Request for Price / Quote for Credit Notes in Naivsion - Mytaxi - Ireland
    // Field added
    //   - Invoice Reference
    layout
    {
        addafter("External Document No.")
        {
            field("Invoice Reference"; Rec."Invoice Reference")
            {
                Description = 'EY-MYWW0001';
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
}

