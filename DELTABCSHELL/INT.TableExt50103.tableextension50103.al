tableextension 50103 tableextension50103 extends "Sales Invoice Header"
{
    // PK 22-04-24 EY-MYWW0001 Feature 5836204 [CS0750506] -  Request for Price / Quote for Credit Notes in Naivsion - Mytaxi - Ireland
    // Field added
    //   - Invoice Reference
    fields
    {
        field(80000; "Invoice Reference"; Text[30])
        {
            Description = 'EY-MYWW0001';
        }
    }
}

