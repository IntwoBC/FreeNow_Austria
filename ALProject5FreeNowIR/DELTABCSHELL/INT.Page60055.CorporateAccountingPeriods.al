page 60055 "Corporate Accounting Periods"
{
    Caption = 'Corporate Accounting Periods';
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Corporate Accounting Period";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Date Locked"; Rec."Date Locked")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Create Year")
            {
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Create Corporate Fiscal Year";
            }
            action("C&lose Year")
            {
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lmdlGAAPMgtRollForward: Codeunit "GAAP Mgt. - Roll Forward";
                begin
                    lmdlGAAPMgtRollForward.gfcnCloseYear(Rec);
                end;
            }
            action("Close Income Statement")
            {
                Caption = 'Close Income Statement';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Close Corporate Income Statmt.";
            }
        }
    }
}

