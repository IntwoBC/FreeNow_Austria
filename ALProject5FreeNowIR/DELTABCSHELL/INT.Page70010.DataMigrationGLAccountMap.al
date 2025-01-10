page 70010 "Data Migration GL Account Map"
{
    // #MyTaxi.W1.CRE.DMIG.001 15/05/2017 CCFR.SDE : MyTaxi - Legacy System Data Migration
    //   Page Creation

    PageType = List;
    SourceTable = "Data Migration GL Account Map";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MyTaxi Account"; Rec."MyTaxi Account")
                {
                }
                field("Group Account"; Rec."Group Account")
                {
                }
                field("Local Account"; Rec."Local Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}

