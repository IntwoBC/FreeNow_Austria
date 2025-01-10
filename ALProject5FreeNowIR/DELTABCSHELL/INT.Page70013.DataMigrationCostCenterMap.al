page 70013 "Data Migration Cost Center Map"
{
    // #MyTaxi.W1.CRE.DMIG.001 15/05/2017 CCFR.SDE : MyTaxi - Legacy System Data Migration
    //   Page Creation

    PageType = List;
    SourceTable = "Data Migration Cost Center Map";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MyTaxi Cost Center"; Rec."MyTaxi Cost Center")
                {
                }
                field("NAV Cost Center"; Rec."NAV Cost Center")
                {
                }
            }
        }
    }

    actions
    {
    }
}

