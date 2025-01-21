codeunit 61001 "T:G/L Account"
{

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 15, 'OnAfterModifyEvent', '', false, false)]
    local procedure levtOnAfterModify(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; RunTrigger: Boolean)
    var
        lmdlFSCodeMgt: Codeunit "Fin. Stmt. Code Management";
    begin
        lmdlFSCodeMgt.gfcnUpdateGLAccFSCodeAndHistory(Rec, xRec."Financial Statement Code");
    end;

    [EventSubscriber(ObjectType::Table, 15, 'OnBeforeValidateEvent', 'Account Class', false, false)]
    local procedure levtOnBeforeValidateAccountClass(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        with Rec do
            if "Account Class" <> "Account Class"::" " then
                if "Account Class" = "Account Class"::"P&L" then
                    Validate("Income/Balance", "Income/Balance"::"Income Statement")
                else
                    Validate("Income/Balance", "Income/Balance"::"Balance Sheet");
    end;

    [EventSubscriber(ObjectType::Table, 15, 'OnBeforeValidateEvent', 'Corporate G/L Account No.', false, false)]
    local procedure levtOnBeforeValidateCorporateGLAccountNo(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
    begin
        with Rec do
            if "Corporate G/L Account No." <> '' then begin
                lrecCorpGLAcc.Get("Corporate G/L Account No.");
                lrecCorpGLAcc.TestField("Account Class", "Account Class");
                lrecCorpGLAcc.TestField("Financial Statement Code", "Financial Statement Code");
            end;
    end;

    //[Scope('Internal')]
    procedure gfcnGetFinancialStatementCode(var precRec: Record "G/L Account"; pdateDate: Date): Code[10]
    var
        lrecHistAccFinStatmtCode: Record "Hist. Acc. Fin. Statmt. Code";
    begin
        with precRec do begin
            lrecHistAccFinStatmtCode.SetRange("G/L Account Type", lrecHistAccFinStatmtCode."G/L Account Type"::"G/L Account");
            lrecHistAccFinStatmtCode.SetRange("G/L Account No.", "No.");
            lrecHistAccFinStatmtCode.SetFilter("Starting Date", '..%1', pdateDate);
            lrecHistAccFinStatmtCode.SetFilter("Ending Date", '%1..', pdateDate);
            if lrecHistAccFinStatmtCode.FindLast then
                exit(lrecHistAccFinStatmtCode."Financial Statement Code");

            exit("Financial Statement Code");
        end;
    end;
}

