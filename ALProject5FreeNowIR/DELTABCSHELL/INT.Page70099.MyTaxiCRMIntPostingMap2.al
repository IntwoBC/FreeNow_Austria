page 70099 "MyTaxi CRM Int. Posting Map2"
{
    PageType = List;
    SourceTable = "MyTaxi CRM Int. Posting Map2";
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
                field(Account; Rec.Account)
                {
                }
                field("GL Account"; Rec."GL Account")
                {
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
                {
                }
                field("Type Of Additional Note"; Rec."Type Of Additional Note")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

