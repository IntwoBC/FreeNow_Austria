page 60094 "Corp. G/L Acc. Map. Overview"
{
    // MP 03-12-13
    // Object created (CR 30)
    // 
    // MP 15-04-14
    // Removed Action "Import Mapping"

    Caption = 'Local G/L Account Mapping Overview';
    Editable = false;
    PageType = List;
    SourceTable = "G/L Account";
    SourceTableTemporary = true;
    SourceTableView = SORTING("Corporate G/L Account No.");
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = gintNameIndent;
                IndentationControls = "Search Name";
                ShowAsTree = true;
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'No.';
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
                field("Income/Balance"; Rec."Income/Balance")
                {
                    Style = Standard;
                    StyleExpr = gblnBold;
                }
                field("Account Class"; Rec."Account Class")
                {
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
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Return';

                trigger OnAction()
                var
                    lrecGLAcc: Record "G/L Account";
                    lrecCorpGLAcc: Record "Corporate G/L Account";
                begin
                    if Rec."New Page" then begin
                        lrecCorpGLAcc."No." := Rec."Search Name";
                        PAGE.Run(PAGE::"Corporate G/L Account Card", lrecCorpGLAcc);
                    end else begin
                        lrecGLAcc."No." := Rec."Search Name";
                        PAGE.Run(PAGE::"G/L Account Card", lrecGLAcc);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        gblnBold := Rec."New Page";
        if Rec."New Page" then
            gintNameIndent := 0
        else
            gintNameIndent := 1;
    end;

    trigger OnOpenPage()
    var
        lmdlCompanyTypeMgt: Codeunit "Company Type Management";
    begin
        lfcnCopyGLAccToTemp;
    end;

    var
        [InDataSet]
        gblnBold: Boolean;
        [InDataSet]
        gintNameIndent: Integer;

    local procedure lfcnCopyGLAccToTemp()
    var
        lrecGLAcc: Record "G/L Account";
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lcodNextNo: Code[20];
    begin
        lrecCorpGLAcc.SetRange("Account Type", lrecCorpGLAcc."Account Type"::Posting);
        lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");

        if lrecCorpGLAcc.FindSet then begin
            lcodNextNo := '10000';
            repeat
                Rec.Init;
                Rec."No." := lcodNextNo;
                Rec."Search Name" := lrecCorpGLAcc."No.";
                Rec.Name := lrecCorpGLAcc.Name;
                Rec."Name (English)" := lrecCorpGLAcc."Name (English)";
                Rec."Account Type" := lrecCorpGLAcc."Account Type";
                Rec."Income/Balance" := lrecCorpGLAcc."Income/Balance";
                Rec."New Page" := true;
                Rec."Corporate G/L Account No." := lcodNextNo;
                lcodNextNo := IncStr(lcodNextNo);
                Rec.Insert;

                lrecGLAcc.SetRange("Corporate G/L Account No.", lrecCorpGLAcc."No.");
                if lrecGLAcc.FindSet then
                    repeat
                        Rec := lrecGLAcc;
                        Rec."No." := lcodNextNo;
                        Rec."Search Name" := lrecGLAcc."No.";
                        Rec."New Page" := false;
                        Rec."Corporate G/L Account No." := lcodNextNo;
                        lcodNextNo := IncStr(lcodNextNo);
                        Rec.Insert;
                    until lrecGLAcc.Next = 0;
            until lrecCorpGLAcc.Next = 0;

            Rec.FindFirst;
        end;
    end;
}

