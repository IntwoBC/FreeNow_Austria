page 60047 "Global File Storage"
{
    PageType = List;
    SourceTable = "Global File Storage";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Attachment")
            {
                Caption = '&Attachment';
                Image = Attachments;
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Enabled = gblnIsEditable;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.gfcnImport;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Enabled = gblnIsEditable;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.gfcnExport;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Enabled = gblnIsEditable;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.gfcnRemove;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        gblnIsEditable := CurrPage.Editable;
    end;

    var
        [InDataSet]
        gblnIsEditable: Boolean;
}

