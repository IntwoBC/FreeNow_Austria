page 70000 "MyTaxi CRM Interface Setup"
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation
    // #MyTaxi.W1.CRE.INT01.009 02/01/2018 CCFR.SDE : Retreive bank account details from CRM App
    //   New added fields : 9 "Bank Account No Start Position", 10 "Bank Account No Start Length"
    // #MyTaxi.W1.CRE.INT01.011 18/05/2018 CCFR.SDE : Set the cost center 2 dimension on sales header
    //   New added field : 11 "Cost Center 2 Dimension Code"
    // #MyTaxi.W1.CRE.PURCH.017 07/06/2019 CCFR.SDE : P2P2 Approval Workflow Process (CRN201900010  Uniform Document Approval Status)
    //   New added field : 12 "Auto Approve Same Level"
    // 
    // PK 12-08-24 EY-MYWW0002 Case CS0806754 / Feature 6079423
    // Field added
    //   - Master Data by ID WS

    PageType = Card;
    SourceTable = "MyTaxi CRM Interface Setup";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Web Service Base URL"; Rec."Web Service Base URL")
                {
                }
                field(User; Rec.User)
                {
                }
                field(Password; Rec.Password)
                {
                    ExtendedDatatype = Masked;
                }
                field("Master Data WS"; Rec."Master Data WS")
                {
                }
                field("Master Data by ID WS"; Rec."Master Data by ID WS")
                {
                    Description = 'EY-MYWW0002';
                }
                field("Invoice List WS"; Rec."Invoice List WS")
                {
                }
                field("Invoice WS"; Rec."Invoice WS")
                {
                }
                field("Master Data Last Max Date"; Rec."Master Data Last Max Date")
                {
                }
                field("Bank Account No Start Position"; Rec."Bank Account No Start Position")
                {
                }
                field("Bank Account No Length"; Rec."Bank Account No Length")
                {
                }
                field("Cost Center 2 Dimension Code"; Rec."Cost Center 2 Dimension Code")
                {
                }
                field("Auto Approve Same Level"; Rec."Auto Approve Same Level")
                {
                }
            }
        }
    }

    actions
    {
    }
}

