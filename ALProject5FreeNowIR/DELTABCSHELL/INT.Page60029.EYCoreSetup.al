page 60029 "EY Core Setup"
{
    // MP 18-11-13
    // Added field "Company Type" (CR 30)
    // 
    // MP 30-04-14
    // Development taken from Core II for Import Tool Enhancements

    Caption = 'EY Core Setup';
    PageType = Card;
    SourceTable = "EY Core Setup";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                Visible = NOT gblnImportTool;
                field("Company Type"; Rec."Company Type")
                {
                    Editable = false;
                }
                field("Corp. Accounts In use"; Rec."Corp. Accounts In use")
                {
                }
            }
            group("Close Income Statement")
            {
                Caption = 'Close Income Statement';
                Visible = NOT gblnImportTool;
                field("Local Retained Earnings Acc."; Rec."Local Retained Earnings Acc.")
                {
                }
                field("Local Suspense Acc."; Rec."Local Suspense Acc.")
                {
                }
                field("Corp. Retained Earnings Acc."; Rec."Corp. Retained Earnings Acc.")
                {
                }
            }
            group("Import Tool Default Templates")
            {
                Caption = 'Import Tool Default Templates';
                Visible = gblnImportTool;
                group("Trial Balance Clients")
                {
                    Caption = 'Trial Balance Clients';
                    field("TB Local CoA Template"; Rec."TB Local CoA Template")
                    {
                        Caption = 'Local CoA Template';
                    }
                    field("TB Corp. CoA Template"; Rec."TB Corp. CoA Template")
                    {
                        Caption = 'Corp. CoA Template';
                    }
                    field("TB Trial Bal. Template"; Rec."TB Trial Bal. Template")
                    {
                        Caption = 'Trial Bal. Template';
                    }
                    field("TB G/L Trans. Template"; Rec."TB G/L Trans. Template")
                    {
                        Caption = 'G/L Trans. Template';
                    }
                }
                group("Transactional Clients")
                {
                    Caption = 'Transactional Clients';
                    field("TR Local CoA Template"; Rec."TR Local CoA Template")
                    {
                        Caption = 'Local CoA Template';
                    }
                    field("TR Corp. CoA Template"; Rec."TR Corp. CoA Template")
                    {
                        Caption = 'Corp. CoA Template';
                    }
                    field("TR Trial Balance Template"; Rec."TR Trial Balance Template")
                    {
                        Caption = 'Trial Balance Template';
                    }
                    field("TR G/L Transactions Template"; Rec."TR G/L Transactions Template")
                    {
                        Caption = 'G/L Transactions Template';
                    }
                    field("TR Customer Template"; Rec."TR Customer Template")
                    {
                        Caption = 'Customer Template';
                    }
                    field("TR Vendor Template"; Rec."TR Vendor Template")
                    {
                        Caption = 'Vendor Template';
                    }
                    field("TR A/R Trans. Template"; Rec."TR A/R Trans. Template")
                    {
                        Caption = 'A/R Trans. Template';
                    }
                    field("TR A/P Trans. Template"; Rec."TR A/P Trans. Template")
                    {
                        Caption = 'A/P Trans. Template';
                    }
                }
            }
            group("VAT Integration")
            {
                Caption = 'VAT Integration';
                Visible = gblnImportTool;
                field("Custom AR posting"; Rec."Custom AR posting")
                {
                }
                field("Custom AP posting"; Rec."Custom AP posting")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
        gblnImportTool := Rec."Company Type" = Rec."Company Type"::"Import Tool"; // MP 30-04-14
    end;

    var
        [InDataSet]
        gblnImportTool: Boolean;
}

