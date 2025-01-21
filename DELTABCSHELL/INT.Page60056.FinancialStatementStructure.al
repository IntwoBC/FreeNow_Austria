page 60056 "Financial Statement Structure"
{
    // MP 02-12-13
    // Amended Action View Financial Statement (CR 30)
    // Added field "Manual Entries Exist" on AssistEdit for this (CR 31 - Case 14140)
    // 
    // MP 24-11-14
    // Upgraded to NAV 2013 R2

    AutoSplitKey = true;
    Caption = 'Financial Statement Structure';
    DataCaptionFields = "Financial Stat. Structure Code";
    PageType = List;
    ShowFilter = false;
    SourceTable = "Financial Statement Line";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Row No."; Rec."Row No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field(Description; Rec.Description)
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Description (English)"; Rec."Description (English)")
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Line Type"; Rec."Line Type")
                {
                    Style = Standard;
                    StyleExpr = gblnBold;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Manual Entries Exist"; Rec."Manual Entries Exist")
                {
                    DrillDownPageID = Navigate;
                    HideValue = NOT gblnBalancesEditable;

                    trigger OnDrillDown()
                    var
                        lrecFinStatManualEntry: Record "Financial Stat. Manual Entry";
                    begin
                        Rec.TestField("Line Type", Rec."Line Type"::"Manual Entry");

                        lrecFinStatManualEntry.SetRange("Financial Stat. Structure Code", Rec."Financial Stat. Structure Code");
                        lrecFinStatManualEntry.SetRange("Financial Stat. Line No.", Rec."Line No.");
                        PAGE.RunModal(0, lrecFinStatManualEntry);

                        if (Rec."Start Balance" <> 0) or (Rec."End Balance" <> 0) then begin // Clear historic data if exists
                            Rec."Start Balance" := 0;
                            Rec."End Balance" := 0;
                        end;

                        CurrPage.Update(true);
                    end;
                }
                field("Totalling/Formula"; Rec."Totalling/Formula")
                {
                    Editable = gblnTotallingEditable;
                    Style = Standard;
                    StyleExpr = gblnBold;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lmdlGAAPMgtFinStat: Codeunit "GAAP Mgt. -Financial Statement";
                        lcodRowNo: Code[10];
                    begin
                        if Rec."Line Type" = Rec."Line Type"::Formula then begin
                            lcodRowNo := lmdlGAAPMgtFinStat.gfcnLookupRowNo(Rec);
                            if lcodRowNo <> '' then begin
                                Text += lcodRowNo;
                                exit(true);
                            end;
                        end;
                    end;
                }
                field("Start Balance"; Rec."Start Balance")
                {
                    Editable = false;
                }
                field("End Balance"; Rec."End Balance")
                {
                    Editable = false;
                }
                field("Show Opposite Sign"; Rec."Show Opposite Sign")
                {
                    Editable = gblnShowOppositeSignEditable;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("<Action1000000012>")
            {
                Caption = 'Import Standardized Model';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrptImportStdFinStat: Report "Import Standardized Fin. Stat.";
                begin
                    // MP 24-11-14 >>
                    //lxmlImportStdFinStat.gfcnSetFinStatStructCode("Financial Stat. Structure Code");
                    //lxmlImportStdFinStat.RUN;

                    lrptImportStdFinStat.gfcnSetFinStatStructCode(Rec."Financial Stat. Structure Code");
                    lrptImportStdFinStat.Run;
                    // MP 24-11-14 <<

                    CurrPage.Update(false);
                end;
            }
            action(Copy)
            {
                Caption = 'Copy';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrptCopyFinancialStatmtStruct: Report "Copy Financial Statmt Struct.";
                begin
                    lrptCopyFinancialStatmtStruct.gfcnSetFinStatmtStructCode(Rec."Financial Stat. Structure Code");
                    lrptCopyFinancialStatmtStruct.RunModal;
                end;
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
                    lmdlGAAPMgtFinStat.gfcnShow(Rec."Financial Stat. Structure Code"); // MP 02-12-13
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        gblnBold := not (Rec."Line Type" in [Rec."Line Type"::" ", Rec."Line Type"::Posting, Rec."Line Type"::"Manual Entry", Rec."Line Type"::Formula]);
        gblnTotallingEditable := Rec."Line Type" in [Rec."Line Type"::Totalling, Rec."Line Type"::Formula];
        gblnBalancesEditable := Rec."Line Type" = Rec."Line Type"::"Manual Entry";
        gblnShowOppositeSignEditable := Rec."Line Type" in [Rec."Line Type"::Posting, Rec."Line Type"::Totalling, Rec."Line Type"::Formula];
    end;

    var
        [InDataSet]
        gblnBold: Boolean;
        [InDataSet]
        gblnTotallingEditable: Boolean;
        [InDataSet]
        gblnBalancesEditable: Boolean;
        [InDataSet]
        gblnShowOppositeSignEditable: Boolean;
}

