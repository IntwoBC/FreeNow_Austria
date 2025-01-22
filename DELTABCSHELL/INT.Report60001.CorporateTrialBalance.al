report 60001 "Corporate Trial Balance"
{
    // MP 20-11-13
    // Amending filtering in G/L Account - OnPreDataItem() (CR 30)
    // 
    // MP 17-11-14
    // Upgraded to NAV 2013 R2
    // 
    // MP 07-Jun-16
    // Upgraded to NAV 2016
    DefaultLayout = RDLC;
    RDLCLayout = './CorporateTrialBalance.rdlc';

    Caption = 'Corporate Trial Balance';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "Corporate G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 2 Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; "G/L Account".TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(EmptyString_Control12; '')
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(G_L_Account___G_L_Account_No_Local_Caption; FieldCaption("Local G/L Account No."))
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            dataitem(BlankLineCounter; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___G_L_Account_No_Local; "G/L Account"."Local G/L Account No.")
                {
                }
                column(G_L_Account___No___Control25; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2_____G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change__Control27; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control28; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date__Control29; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control30; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(G_L_Account__Indentation; "G/L Account".Indentation)
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(G_L_Account___G_L_Account_No_Local_2; "G/L Account"."Local G/L Account No.")
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date");
                if gblnExcludeZeroBalances and ("Balance at Date" = 0) then
                    CurrReport.Skip;

                if PrintToExcel then
                    MakeExcelDataBody;
            end;

            trigger OnPreDataItem()
            var
                lmdlCompanyTypeMgt: Codeunit "Company Type Management";
            begin
                // MP 20-11-13 >>
                //SETRANGE("Global Dimension 1 Filter",'');
                lmdlCompanyTypeMgt.gfcnApplyFilterCorpGLAcc("G/L Account", 0);
                // MP 20-11-13 <<
            end;
        }
    }

    requestpage
    {
        Caption = 'Trial Balance';

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        ApplicationArea = All;
                    }
                    field(gblnExcludeZeroBalances; gblnExcludeZeroBalances)
                    {
                        Caption = 'Do Not Show Zero Balances';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if PrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
        if PrintToExcel then
            MakeExcelInfo;
    end;

    var
        Text000: Label 'Period: %1';
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        CurrFormat: Text[30];
        Text011: Label 'Period Filter';
        gblnExcludeZeroBalances: Boolean;
        Trial_BalanceCaptionLbl: Label 'Corporate Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';

    //[Scope('Internal')]
    procedure MakeExcelInfo()
    begin
        // MP 17-11-14 Upgraded to NAV 2013 R2, adding last parameter in AddInfoColumn function calls
        /*
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        // MP 17-11-14 Upgraded to NAV 2013 R2, adding last parameter in AddInfoColumn function calls
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text003), false, '', true, false, true, '',
          ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text004), false, '', true, false, true, '',
          ExcelBuf."Cell Type"::Text);
    end;

    //[Scope('Internal')]
    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        // MP 17-11-14 Upgraded to NAV 2013 R2, adding last parameter in AddInfoColumn function calls
        BlankFiller := PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          "G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
          ExcelBuf."Cell Type"::Text);
        if "G/L Account".Indentation = 0 then
            ExcelBuf.AddColumn(
              "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
              ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn(
              CopyStr(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
              false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);

        case true of
            "G/L Account"."Net Change" = 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Net Change" > 0:
                begin
                    ExcelBuf.AddColumn(
                      "G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Net Change" < 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                end;
        end;

        case true of
            "G/L Account"."Balance at Date" = 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Balance at Date" > 0:
                begin
                    ExcelBuf.AddColumn(
                      "G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                end;
            "G/L Account"."Balance at Date" < 0:
                begin
                    ExcelBuf.AddColumn(
                      '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '',
                      ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                end;
        end;
    end;

    //[Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // MP 17-11-14 Upgraded to NAV 2013 R2 >>
        //ExcelBuf.CreateBook;
        //ExcelBuf.UpdateBook(Text002,Text001,COMPANYNAME,USERID);
        //ExcelBuf.GiveUserControl;
        //ExcelBuf.CreateBookAndOpenExcel(Text002,Text001,COMPANYNAME,USERID);
        //ExcelBuf.CreateBookAndOpenExcel(Text002, Text001, Text001, CompanyName, UserId); // MP 07-Jun-16 Replaces above line, upgraded to NAV 2016
        // MP 17-11-14 Upgraded to NAV 2013 R2 <<

        Error('');
    end;
}

