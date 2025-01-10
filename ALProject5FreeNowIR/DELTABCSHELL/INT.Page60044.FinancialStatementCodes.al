page 60044 "Financial Statement Codes"
{
    // MP 24-11-14
    // Upgraded to NAV 2013 R2

    Caption = 'Financial Statement Codes';
    PageType = List;
    SourceTable = "Financial Statement Code";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description (English)"; Rec."Description (English)")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000006>")
            {
                Caption = 'Import/Export';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //XMLPORT.RUN(XMLPORT::"Financial Statement Code");
                    REPORT.Run(REPORT::"Import/Export Fin. Stat. Codes"); // MP 24-11-14 Replaces above
                    CurrPage.Update(false);
                end;
            }
        }
    }
}

