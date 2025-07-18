codeunit 50006 "Update Mismatched CorpAccNo"
{
    Permissions = tabledata "I2I G/L Entry" = RIMD;

    trigger OnRun()
    var
        GLEntry: Record "I2I G/L Entry";
        lrecCorpGLAcc: Record "Corporate G/L Account";
        MappedCorpGLAccNo: Code[20];
    begin
        if GLEntry.FindSet() then
            repeat
                lrecCorpGLAcc.SetCurrentKey("Local G/L Account No.");
                lrecCorpGLAcc.SetRange("Local G/L Account No.", GLEntry."G/L Account No.");
                if lrecCorpGLAcc.FindFirst then begin
                    MappedCorpGLAccNo := lrecCorpGLAcc."No.";
                    if GLEntry."Corporate G/L Account No." <> MappedCorpGLAccNo then begin
                        GLEntry."Corporate G/L Account No." := MappedCorpGLAccNo;
                        GLEntry.Modify();
                    end;
                end;
            until GLEntry.Next() = 0;
    end;
}