page 60097 "Report Links"
{
    Caption = 'Report Links';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = Language;
    SourceTableTemporary = true;
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    Caption = 'Description';
                }
                field(gtxtURL; gtxtURL)
                {
                    Caption = 'Link Address';
                    ExtendedDatatype = URL;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        grecRecordLink.Get(Rec."Windows Language ID");
        gtxtURL := grecRecordLink.URL1;// + grecRecordLink.URL2 + grecRecordLink.URL3 + grecRecordLink.URL4;//SPS Fields removed
    end;

    trigger OnOpenPage()
    var
        lrrfRecord: RecordRef;
    begin
        lrrfRecord.Open(DATABASE::"EY Core Setup");
        grecRecordLink.SetRange("Record ID", lrrfRecord.RecordId);
        lrrfRecord.Close;
        grecRecordLink.SetFilter(Company, '%1|%2', CompanyName, '');
        if grecRecordLink.FindSet then
            repeat
                Rec.Code := Format(grecRecordLink."Link ID");
                Rec.Name := grecRecordLink.Description;
                Rec."Windows Language ID" := grecRecordLink."Link ID";
                Rec.Insert;
            until grecRecordLink.Next = 0;
    end;

    var
        grecRecordLink: Record "Record Link";
        gtxtURL: Text[1024];
}

