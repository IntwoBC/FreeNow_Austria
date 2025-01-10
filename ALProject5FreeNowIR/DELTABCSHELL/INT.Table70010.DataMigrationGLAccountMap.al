table 70010 "Data Migration GL Account Map"
{
    // #MyTaxi.W1.CRE.DMIG.001 15/05/2017 CCFR.SDE : MyTaxi - Legacy System Data Migration
    //   Table Creation

    DataClassification = ToBeClassified;//SPS
    fields
    {
        field(1; "MyTaxi Account"; Code[20])
        {
        }
        field(2; "Group Account"; Code[20])
        {
        }
        field(3; "Local Account"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "MyTaxi Account")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

