page 60059 "Financial Statement View"
{
    // MP 27-11-13
    // Amended to handle bottom-up companies (CR 30)
    // 
    // MP 18-11-15
    // Added functionality to support Unposted entries (CB1 Enhancements)

    Caption = 'Financial Statement View';
    DataCaptionFields = "Financial Stat. Structure Code";
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Financial Statement Line";
    SourceTableTemporary = true;
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("Start Date"; gdatStart)
                {
                    Caption = 'Start Date';

                    trigger OnValidate()
                    var
                        ldatDateTemp: Date;
                    begin
                        gmdlGAAPMgt.gfcnGetAccPeriodFilter(gdatStart, ldatDateTemp, gdatEnd);
                        lfcnUpdate(true, false); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("End Date"; gdatEnd)
                {
                    Caption = 'End Date';

                    trigger OnValidate()
                    begin
                        lfcnUpdate(true, false); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("grecFinStatStructure.""Rounding Factor"""; grecFinStatStructure."Rounding Factor")
                {
                    Caption = 'Rounding Factor';
                    Editable = false;
                }
                field("View Accounts"; goptViewAccounts)
                {
                    Caption = 'View Accounts';
                    Editable = gblnCorpAccInUse;
                    OptionCaption = 'Local,Corporate,Both';

                    trigger OnValidate()
                    begin
                        // MP 27-11-13 >>
                        if gblnBottomUp then
                            goptCorpStatementType := goptCorpStatementType::"Statutory Financial Statement"
                        else
                            // MP 27-11-13 <<
                            if goptViewAccounts = goptViewAccounts::"Local" then
                                goptCorpStatementType := goptCorpStatementType::" "
                            else
                                goptCorpStatementType := goptCorpStatementType::"Statutory Financial Statement";

                        gblnCorpStatementTypeEditable := goptViewAccounts <> goptViewAccounts::"Local";

                        lfcnUpdate(true, true); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("Corporate Statement Type"; goptCorpStatementType)
                {
                    Caption = 'Corporate Statement Type';
                    Editable = gblnCorpStatementTypeEditable;
                    OptionCaption = ' ,Group Financial Statement,Statutory Financial Statement,Tax Financial Statement';
                    Visible = NOT gblnBottomUp;

                    trigger OnValidate()
                    begin
                        lfcnUpdate(true, false); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("Statement Type (Corp.)"; goptCorpStatementType)
                {
                    Caption = 'Statement Type';
                    OptionCaption = ' ,,Group Periodic Reporting,Tax Financial Statement';
                    Visible = gblnBottomUp AND NOT gblnLocalAccView;

                    trigger OnValidate()
                    begin
                        lfcnUpdate(true, false); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("Statement Type (Local)"; goptCorpStatementType)
                {
                    Caption = 'Statement Type';
                    OptionCaption = ' ,,Statutory Financial Statement,Tax Financial Statement';
                    Visible = gblnBottomUp AND gblnLocalAccView;

                    trigger OnValidate()
                    begin
                        lfcnUpdate(true, false); // MP 27-11-13 Added 2nd parameter
                    end;
                }
                field("Include Un-posted Entries"; gblnIncludeUnpostedEntries)
                {
                    Caption = 'Include Un-posted Entries';

                    trigger OnValidate()
                    begin
                        lfcnUpdate(true, false); // MP 18-11-15
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                //IndentationColumn = Indentation;
                IndentationControls = Description, "Description (English)";
                ShowAsTree = true;
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
                field("Code"; Rec.Code)
                {
                    Caption = 'Financial Statement Code';
                    HideValue = gblnHideCodeValue;
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Start Balance"; Rec."Start Balance")
                {
                    CaptionClass = gtxtStartBalanceCaption;
                    Style = Standard;
                    StyleExpr = gblnBold;
                    Visible = NOT gblnRoundingApplied;

                    trigger OnDrillDown()
                    begin
                        gmdlGAAPMgtFinancialStatement.gfcnDrillDown(Rec, Rec.FieldNo("Start Balance"));
                    end;
                }
                field("End Balance"; Rec."End Balance")
                {
                    CaptionClass = gtxtEndBalanceCaption;
                    Style = Standard;
                    StyleExpr = gblnBold;
                    Visible = NOT gblnRoundingApplied;

                    trigger OnDrillDown()
                    begin
                        gmdlGAAPMgtFinancialStatement.gfcnDrillDown(Rec, Rec.FieldNo("End Balance"));
                    end;
                }
                field(StartBalanceRounded; Rec."Start Balance")
                {
                    CaptionClass = gtxtStartBalanceCaption;
                    DecimalPlaces = 0 : 0;
                    Style = Standard;
                    StyleExpr = gblnBold;
                    Visible = gblnRoundingApplied;

                    trigger OnDrillDown()
                    begin
                        gmdlGAAPMgtFinancialStatement.gfcnDrillDown(Rec, Rec.FieldNo("Start Balance"));
                    end;
                }
                field(EndBalanceRounded; Rec."End Balance")
                {
                    CaptionClass = gtxtEndBalanceCaption;
                    DecimalPlaces = 0 : 0;
                    Style = Standard;
                    StyleExpr = gblnBold;
                    Visible = gblnRoundingApplied;

                    trigger OnDrillDown()
                    begin
                        gmdlGAAPMgtFinancialStatement.gfcnDrillDown(Rec, Rec.FieldNo("End Balance"));
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000032>")
            {
                Caption = 'A&ccount';
                action("<Action1000000031>")
                {
                    Caption = 'Card';
                    Enabled = gblnGLAcc;
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        lrecGLAcc: Record "G/L Account";
                        lrecCorpGLAcc: Record "Corporate G/L Account";
                    begin
                        if Rec."Corporate G/L Account No." <> '' then begin
                            lrecCorpGLAcc."No." := Rec."Corporate G/L Account No.";
                            PAGE.Run(PAGE::"Corporate G/L Account Card", lrecCorpGLAcc);
                        end else
                            if Rec."G/L Account No." <> '' then begin
                                lrecGLAcc."No." := Rec."G/L Account No.";
                                PAGE.Run(PAGE::"G/L Account Card", lrecGLAcc);
                            end;
                    end;
                }
                action("<Action1000000004>")
                {
                    Caption = 'Ledger E&ntries';
                    Enabled = gblnGLAcc;
                    Image = GLRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    var
                        lrecGLEntry: Record "G/L Entry";
                    begin
                        if Rec."Corporate G/L Account No." <> '' then begin
                            lrecGLEntry.SetCurrentKey("Corporate G/L Account No.");
                            lrecGLEntry.SetRange("Corporate G/L Account No.", Rec."Corporate G/L Account No.");
                        end else
                            if Rec."G/L Account No." <> '' then begin
                                lrecGLEntry.SetCurrentKey("G/L Account No.");
                                lrecGLEntry.SetRange("G/L Account No.", Rec."G/L Account No.");
                            end else
                                exit;

                        PAGE.Run(PAGE::"General Ledger Entries", lrecGLEntry);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Financial Statement")
            {
                Caption = 'Financial Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrptFinStat: Report "Financial Statement";
                begin
                    lrptFinStat.gfcnSetSource(Rec);
                    lrptFinStat.gfcnSetCaptions(gtxtStartBalanceCaption, gtxtEndBalanceCaption);
                    lrptFinStat.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        gblnBold := not (Rec."Line Type" in [Rec."Line Type"::" ", Rec."Line Type"::Posting, Rec."Line Type"::"Manual Entry", Rec."Line Type"::Formula]);
        gblnGLAcc := (Rec."G/L Account No." <> '') or (Rec."Corporate G/L Account No." <> '');
        gblnHideCodeValue := Rec.Type = Rec.Type::"Corporate G/L Account Group";
    end;

    trigger OnOpenPage()
    var
        lmdlCompanyTypeMgt: Codeunit "Company Type Management";
    begin
        // MP 25-11-13 >>
        gblnBottomUp := lmdlCompanyTypeMgt.gfcnIsBottomUp;
        gblnCorpAccInUse := lmdlCompanyTypeMgt.gfcnCorpAccInUse;
        if not gblnCorpAccInUse then begin
            goptViewAccounts := goptViewAccounts::"Local";
            goptCorpStatementType := goptCorpStatementType::"Statutory Financial Statement";
        end else
            if (not gblnBottomUp) and (goptViewAccounts = goptViewAccounts::"Local") then
                goptCorpStatementType := goptCorpStatementType::" "
            else
                if (goptCorpStatementType = goptCorpStatementType::" ") and (gblnBottomUp or (goptViewAccounts <> goptViewAccounts::"Local"))
                then
                    goptCorpStatementType := goptCorpStatementType::"Statutory Financial Statement";

        gblnReopen := false;
        // MP 25-11-13 <<

        if (gdatStart = 0D) or (gdatEnd = 0D) then
            gmdlGAAPMgt.gfcnGetAccPeriodFilter(WorkDate, gdatStart, gdatEnd);

        if Rec.GetFilter("Financial Stat. Structure Code") = '' then begin
            grecFinStatStructure.SetRange(Default, true); // MP 11-12-13 Changed lrecFinStatStructure to grecFinStatStructure in this function
            grecFinStatStructure.FindFirst;
            gcodFinStatStructureCode := grecFinStatStructure.Code;

            Rec.SetRange("Financial Stat. Structure Code", gcodFinStatStructureCode);
        end else
            gcodFinStatStructureCode := Rec.GetRangeMin("Financial Stat. Structure Code");

        // MP 11-12-13 >>

        if grecFinStatStructure.Code = '' then
            grecFinStatStructure.Get(gcodFinStatStructureCode);

        gblnRoundingApplied := grecFinStatStructure."Rounding Factor" > grecFinStatStructure."Rounding Factor"::None;

        // MP 11-12-13 <<

        gblnCorpStatementTypeEditable := goptViewAccounts <> goptViewAccounts::"Local";

        lfcnUpdate(false, false); // MP 27-11-13 Added 2nd parameter
    end;

    var
        grecFinStatStructure: Record "Financial Statement Structure";
        gmdlGAAPMgt: Codeunit "GAAP Mgt. - Global View";
        gmdlGAAPMgtFinancialStatement: Codeunit "GAAP Mgt. -Financial Statement";
        goptViewAccounts: Option "Local",Corporate,Both;
        goptCorpStatementType: Option " ","Group Financial Statement","Statutory Financial Statement","Tax Financial Statement";
        goptLocalStatementType: Option " ","Statutory Financial Statement","Tax Financial Statement";
        gdatStart: Date;
        gdatEnd: Date;
        gcodFinStatStructureCode: Code[20];
        [InDataSet]
        gtxtStartBalanceCaption: Text[30];
        [InDataSet]
        gtxtEndBalanceCaption: Text[30];
        [InDataSet]
        gblnBold: Boolean;
        [InDataSet]
        gblnCorpStatementTypeEditable: Boolean;
        [InDataSet]
        gblnGLAcc: Boolean;
        [InDataSet]
        gblnHideCodeValue: Boolean;
        [InDataSet]
        gblnBottomUp: Boolean;
        [InDataSet]
        gblnCorpAccInUse: Boolean;
        [InDataSet]
        gblnLocalAccView: Boolean;
        gblnReopen: Boolean;
        [InDataSet]
        gblnRoundingApplied: Boolean;
        gblnIncludeUnpostedEntries: Boolean;

    local procedure lfcnUpdate(pblnRefreshPage: Boolean; pblnReopenPage: Boolean)
    begin
        // MP 27-11-13 Added parameter pblnReloadPage
        gblnLocalAccView := goptViewAccounts = goptViewAccounts::"Local"; // MP 27-11-13

        Clear(gmdlGAAPMgtFinancialStatement);
        gmdlGAAPMgtFinancialStatement.gfcnInit(gcodFinStatStructureCode, gdatStart, gdatEnd, goptViewAccounts, goptCorpStatementType,
          gblnIncludeUnpostedEntries);  // MP 18-11-15 Added gblnIncludeUnpostedEntries
        gmdlGAAPMgtFinancialStatement.gfcnGetCaptions(gtxtStartBalanceCaption, gtxtEndBalanceCaption);
        gmdlGAAPMgtFinancialStatement.gfcnCalc(Rec);

        if pblnRefreshPage then
            // MP 27-11-13 >>
            if pblnReopenPage then begin
                gblnReopen := true;
                CurrPage.Close;
            end else
                // MP 27-11-13 <<
                CurrPage.Update(false);
    end;

    //[Scope('Internal')]
    procedure gfcnReopen(): Boolean
    begin
        // MP 27-11-13

        exit(gblnReopen);
    end;
}

