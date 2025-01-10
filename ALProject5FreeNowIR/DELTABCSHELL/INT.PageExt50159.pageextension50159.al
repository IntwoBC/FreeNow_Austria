pageextension 50159 pageextension50159 extends "Dimension Values"
{
    // #MyTaxi.W1.CRE.INT01.011 18/05/2018 CCFR.SDE : Set the cost center 2 dimension on sales header
    //   New added field : 70000 "MyTaxi CRM Interace Code"
    layout
    {
        addafter("Consolidation Code")
        {
            field("MyTaxi CRM Interace Code"; Rec."MyTaxi CRM Interace Code")
            {
                ApplicationArea = all;
            }
        }
    }
}

