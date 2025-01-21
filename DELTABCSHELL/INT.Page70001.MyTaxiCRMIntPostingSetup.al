page 70001 "MyTaxi CRM Int. Posting Setup"
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation
    // #MyTaxi.W1.CRE.INT01.012 18/05/2018 CCFR.SDE : Set a default value in field "Reminder Terms Code" when a customer is created
    //   New added field : 38 "Default Cust. Rem. Terms Code"

    Caption = 'MyTaxi CRM Interface Posting Setup';
    PageType = List;
    SourceTable = "MyTaxi CRM Int. Posting Setup";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice Type"; Rec."Invoice Type")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Cash Rec. Jnl. Template Name"; Rec."Cash Rec. Jnl. Template Name")
                {
                }
                field("Cash Rec. Jnl. Batch Name"; Rec."Cash Rec. Jnl. Batch Name")
                {
                }
                field("Auto-Post Payment Journal"; Rec."Auto-Post Payment Journal")
                {
                }
                field("Sum Gross Value GL Account"; Rec."Sum Gross Value GL Account")
                {
                }
                field("Sum Gross Value VAT Grp"; Rec."Sum Gross Value VAT Grp")
                {
                }
                field("Discount Commission GL Account"; Rec."Discount Commission GL Account")
                {
                }
                field("Disc. Com. VAT Prod Post Group"; Rec."Disc. Com. VAT Prod Post Group")
                {
                }
                field("Commission GL Account"; Rec."Commission GL Account")
                {
                }
                field("Commission VAT Prod Post Group"; Rec."Commission VAT Prod Post Group")
                {
                }
                field("Hotel Value GL Account"; Rec."Hotel Value GL Account")
                {
                }
                field("Hotel Val VAT Prod Post Group"; Rec."Hotel Val VAT Prod Post Group")
                {
                }
                field("Invoicing Fee GL Account"; Rec."Invoicing Fee GL Account")
                {
                }
                field("Inv Fee VAT Prod Post Group"; Rec."Inv Fee VAT Prod Post Group")
                {
                }
                field("Payment Fee MP GL Account"; Rec."Payment Fee MP GL Account")
                {
                }
                field("Pay Fee MP VAT Prod Post Group"; Rec."Pay Fee MP VAT Prod Post Group")
                {
                }
                field("Payment Fee BA GL Account"; Rec."Payment Fee BA GL Account")
                {
                }
                field("Pay Fee BA VAT Prod Post Group"; Rec."Pay Fee BA VAT Prod Post Group")
                {
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }
                field("Default Cust. Rem. Terms Code"; Rec."Default Cust. Rem. Terms Code")
                {
                }
                field("Automatic Posting"; Rec."Automatic Posting")
                {
                }
                field("On Car Advert. Account"; Rec."On Car Advert. Account")
                {
                }
                field("On Car Advert. GL Account"; Rec."On Car Advert. GL Account")
                {
                }
                field("On Car Advert. VAT Grp"; Rec."On Car Advert. VAT Grp")
                {
                }
                field("Driver Ref. Prog. Account"; Rec."Driver Ref. Prog. Account")
                {
                }
                field("Driver Ref. Prog. GL Acc."; Rec."Driver Ref. Prog. GL Acc.")
                {
                }
                field("Driver Ref. Prog. VAT Grp"; Rec."Driver Ref. Prog. VAT Grp")
                {
                }
                field("Driver Incent. Prog. Account"; Rec."Driver Incent. Prog. Account")
                {
                }
                field("Driver Incent. Prog. GL Acc."; Rec."Driver Incent. Prog. GL Acc.")
                {
                }
                field("Driver Incent. Prog. VAT Grp"; Rec."Driver Incent. Prog. VAT Grp")
                {
                }
                field("Driver Comp. Fee Account"; Rec."Driver Comp. Fee Account")
                {
                }
                field("Driver Comp. Fee GL Account"; Rec."Driver Comp. Fee GL Account")
                {
                }
                field("Driver Comp. Fee VAT Grp"; Rec."Driver Comp. Fee VAT Grp")
                {
                }
                field("Commission Fee Corr. Account"; Rec."Commission Fee Corr. Account")
                {
                }
                field("Commission Fee Corr. GL Acc."; Rec."Commission Fee Corr. GL Acc.")
                {
                }
                field("Commission Fee Corr. VAT Grp"; Rec."Commission Fee Corr. VAT Grp")
                {
                }
                field("Mobile Pay. Fee Corr. Account"; Rec."Mobile Pay. Fee Corr. Account")
                {
                }
                field("Mobile Pay. Fee Corr. GL Acc."; Rec."Mobile Pay. Fee Corr. GL Acc.")
                {
                }
                field("Mobile Pay. Fee Corr. VAT Grp"; Rec."Mobile Pay. Fee Corr. VAT Grp")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000017; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Account Mapping")
            {
                Caption = 'Account Mapping';
                Image = MapAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "MyTaxi CRM Int. Posting Map.";
                RunPageLink = "Invoice Type" = FIELD("Invoice Type");
                RunPageMode = Edit;
            }
        }
    }
}

