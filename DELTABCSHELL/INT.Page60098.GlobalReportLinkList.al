page 60098 "Global Report Link List"
{
    Caption = 'Global Report Link List';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Line Number Buffer";
    SourceTableTemporary = true;
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("grecRecordLink.Description"; grecRecordLink.Description)
                {
                    Caption = 'Description';
                }
                field(gtxtURL; gtxtURL)
                {
                    Caption = 'Link Address';
                    ExtendedDatatype = URL;
                }
                field("grecRecordLink.Created"; grecRecordLink.Created)
                {
                    Caption = 'Created';
                    Editable = false;
                }
                field("grecRecordLink.""User ID"""; grecRecordLink."User ID")
                {
                    Caption = 'User ID';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("<Action1000000007>")
            {
                Caption = 'Card';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Global Report Link Card", Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        grecRecordLink.Get(Rec."Old Line Number");
        gtxtURL := grecRecordLink.URL1;//+ grecRecordLink.URL2 + grecRecordLink.URL3 + grecRecordLink.URL4;//SPS
    end;

    trigger OnOpenPage()
    var
        lrrfRecord: RecordRef;
    begin
        lrrfRecord.Open(DATABASE::"EY Core Setup");
        if not lrrfRecord.FindFirst then
            lrrfRecord.Insert;
        grecRecordLink.SetRange("Record ID", lrrfRecord.RecordId);
        grecRecordLink.SetRange(Company, '');
        if grecRecordLink.FindSet then
            repeat
                Rec."Old Line Number" := grecRecordLink."Link ID";
                Rec.Insert;
            until grecRecordLink.Next = 0;
        lrrfRecord.Close;
    end;

    var
        grecRecordLink: Record "Record Link";
        gtxtURL: Text[1024];
}

