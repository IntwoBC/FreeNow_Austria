page 70011 "Data Migration VAT Group Map"
{
    // #MyTaxi.W1.CRE.DMIG.001 15/05/2017 CCFR.SDE : MyTaxi - Legacy System Data Migration
    //   Page Creation

    PageType = List;
    SourceTable = "Data Migration VAT Group Map";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MayTaxi VAT Prod Group"; Rec."MayTaxi VAT Prod Group")
                {
                }
                field("NAV VAT Prod Group"; Rec."NAV VAT Prod Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

