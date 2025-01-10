page 60096 "Fin. Statm. Code Overview Corp"
{
    Caption = 'Financial Statement Code Overview (Corporate)';
    Editable = false;
    PageType = List;
    SourceTable = "G/L Account";
    SourceTableTemporary = true;
    SourceTableView = SORTING("No.");
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = Rec."No. of Blank Lines";
                IndentationControls = "Corporate G/L Account No.";
                ShowAsTree = true;
                field("Corporate G/L Account No."; Rec."Corporate G/L Account No.")
                {
                    Caption = 'No.';
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field(Name; Rec.Name)
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Name (English)"; Rec."Name (English)")
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Financial Statement Code"; Rec."Financial Statement Code")
                {
                    Caption = 'Financial Statement Code Mismatch';
                    Style = StandardAccent;
                    StyleExpr = true;
                    Visible = gblnShowFinStatCodeMismatch;
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    HideValue = gblnBold;
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Account Class"; Rec."Account Class")
                {
                    HideValue = gblnBold;
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Open)
            {
                Caption = 'Open';
                ShortCutKey = 'Return';

                trigger OnAction()
                var
                    lrecGLAcc: Record "G/L Account";
                    lrecCorpGLAcc: Record "Corporate G/L Account";
                begin
                    case Rec."No. of Blank Lines" of
                        1:
                            begin
                                lrecCorpGLAcc."No." := Rec."Corporate G/L Account No.";
                                PAGE.Run(PAGE::"Corporate G/L Account Card", lrecCorpGLAcc);
                            end;
                        2:
                            begin
                                lrecGLAcc."No." := Rec."Corporate G/L Account No.";
                                PAGE.Run(PAGE::"G/L Account Card", lrecGLAcc);
                            end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        gblnBold := Rec."New Page";
    end;

    trigger OnOpenPage()
    begin
        lfcnCopyGLAccToTemp;
    end;

    var
        [InDataSet]
        gblnBold: Boolean;
        [InDataSet]
        gblnShowFinStatCodeMismatch: Boolean;

    local procedure lfcnCopyGLAccToTemp()
    var
        lrecFinancialStatementCode: Record "Financial Statement Code";
        lrecGLAcc: Record "G/L Account";
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lcodNextNo: Code[20];
    begin
        lrecCorpGLAcc.SetRange("Account Type", lrecCorpGLAcc."Account Type"::Posting);
        lrecCorpGLAcc.SetCurrentKey("Financial Statement Code");
        lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");

        if lrecFinancialStatementCode.FindSet then begin
            lcodNextNo := '10000';
            repeat
                Rec.Init;
                Rec."No." := lcodNextNo;
                lcodNextNo := IncStr(lcodNextNo);

                Rec."Corporate G/L Account No." := lrecFinancialStatementCode.Code;
                Rec.Name := CopyStr(lrecFinancialStatementCode.Description, 1, MaxStrLen(Rec.Name));
                Rec."Name (English)" := CopyStr(lrecFinancialStatementCode."Description (English)", 1, MaxStrLen(Rec."Name (English)"));
                Rec."New Page" := true;
                Rec."No. of Blank Lines" := 0;
                Rec.Insert;

                lrecCorpGLAcc.SetRange("Financial Statement Code", lrecFinancialStatementCode.Code);
                if lrecCorpGLAcc.FindSet then
                    repeat
                        Rec.Init;
                        Rec."No." := lcodNextNo;
                        lcodNextNo := IncStr(lcodNextNo);

                        Rec."Corporate G/L Account No." := lrecCorpGLAcc."No.";
                        Rec.Name := CopyStr(lrecCorpGLAcc.Name, 1, MaxStrLen(Rec.Name));
                        Rec."Name (English)" := lrecCorpGLAcc."Name (English)";
                        Rec."Account Type" := lrecCorpGLAcc."Account Type";
                        Rec."Income/Balance" := lrecCorpGLAcc."Income/Balance";
                        Rec."Account Class" := lrecCorpGLAcc."Account Class";
                        Rec."No. of Blank Lines" := 1;
                        Rec.Insert;

                        lrecGLAcc.SetRange("Corporate G/L Account No.", lrecCorpGLAcc."No.");
                        if lrecGLAcc.FindSet then
                            repeat
                                Rec := lrecGLAcc;
                                Rec."No." := lcodNextNo;
                                lcodNextNo := IncStr(lcodNextNo);

                                Rec."Corporate G/L Account No." := lrecGLAcc."No.";
                                Rec."No. of Blank Lines" := 2;

                                if lrecGLAcc."Financial Statement Code" <> lrecCorpGLAcc."Financial Statement Code" then begin
                                    Rec."Financial Statement Code" := lrecGLAcc."Financial Statement Code";
                                    gblnShowFinStatCodeMismatch := true;
                                end else
                                    Rec."Financial Statement Code" := '';

                                Rec.Insert;
                            until lrecGLAcc.Next = 0;
                    until lrecCorpGLAcc.Next = 0;
            until lrecFinancialStatementCode.Next = 0;
            Rec.FindFirst;
        end;
    end;
}

