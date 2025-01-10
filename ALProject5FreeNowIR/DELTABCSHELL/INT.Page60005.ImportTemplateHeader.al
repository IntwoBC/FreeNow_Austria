page 60005 "Import Template Header"
{
    Caption = 'Import Template Header';
    PageType = Card;
    SourceTable = "Import Template Header";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Table Caption"; Rec."Table Caption")
                {
                }
                field("File Format"; Rec."File Format")
                {
                }
                field("Field Delimiter"; Rec."Field Delimiter")
                {
                }
                field("Field Delimiter ASCII"; Rec."Field Delimiter ASCII")
                {
                }
                field("Text Qualifier"; Rec."Text Qualifier")
                {
                }
                field("Decimal Symbol"; Rec."Decimal Symbol")
                {
                }
                field("Thousand Separator"; Rec."Thousand Separator")
                {
                }
                field("Skip Header Lines"; Rec."Skip Header Lines")
                {
                }
                field("Date Format"; Rec."Date Format")
                {
                }
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field("XLS Worksheet No."; Rec."XLS Worksheet No.")
                {
                }
            }
            part(Lines; "Import Template Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Template Header Code" = FIELD(Code);
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lchrChar: Char;
    begin
        //lchrChar := "Field Delimiter"[1];
        gintDelimChar := lchrChar;
    end;

    var
        gintDelimChar: Integer;
}

