tableextension 50105 tableextension50105 extends "Sales Cr.Memo Header"
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

