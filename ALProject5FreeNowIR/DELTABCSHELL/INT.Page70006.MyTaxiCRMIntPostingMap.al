page 70006 "MyTaxi CRM Int. Posting Map."
{
    Caption = 'MyTaxi CRM Int. Posting Mapping';
    PageType = List;
    SourceTable = "MyTaxi CRM Int. Posting Map.";
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
                    Editable = false;
                    Visible = false;
                }
                field(Account; Rec.Account)
                {
                }
                field("Type Of Additional Note"; Rec."Type Of Additional Note")
                {
                }
                field("GL Account"; Rec."GL Account")
                {
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
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

