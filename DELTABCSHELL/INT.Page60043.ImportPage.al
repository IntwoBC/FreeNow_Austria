page 60043 "Import Page"
{
    Caption = 'Import Page';
    PageType = Card;
    SourceTable = "Integer";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                field(gcodParentNumber; gcodParentNumber)
                {
                    Caption = 'Parent No.';
                    TableRelation = "Parent Client"."No.";
                }
            }
        }
    }

    actions
    {
    }

    var
        gcodParentNumber: Code[20];
        grecParentClient: Record "Parent Client";

    //[Scope('Internal')]
    procedure gfncGetParentCustomerNo(): Code[20]
    begin
        exit(gcodParentNumber);
    end;
}

