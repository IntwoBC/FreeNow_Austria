page 60060 "Financial Stat. Structure List"
{
    // MP 02-12-13
    // Amended Action View Financial Statement (CR 30)
    // Added field "Rounding Precision" (CR 31 - Case 14130)
    // 
    // MP 11-11-14
    // Upgrade to NAV 2013 R2

    Caption = 'Financial Statement Structure List';
    PageType = List;
    SourceTable = "Financial Statement Structure";
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
                field(Default; Rec.Default)
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Rounding Factor"; Rec."Rounding Factor")
                {
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
                Caption = 'Edit Structure';
                Image = EditList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Financial Statement Structure";
                RunPageLink = "Financial Stat. Structure Code" = FIELD(Code);
            }
            action("<Action1000000008>")
            {
                Caption = 'View Financial Statement';
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lmdlGAAPMgtFinStat: Codeunit "GAAP Mgt. -Financial Statement";
                begin
                    lmdlGAAPMgtFinStat.gfcnShow(Rec.Code); // MP 02-12-13
                end;
            }
        }
        area(processing)
        {
            action(ImportExport)
            {
                Caption = 'Import/Export';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Import/Export Fin. Stat. Struc";
            }
        }
    }
}

