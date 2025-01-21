codeunit 61003 "T:Standard General Journal Lin"
{

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 751, 'OnBeforeValidateEvent', 'Corporate G/L Account No.', false, false)]
    local procedure levtOnBeforeValidateCorporateGLAccountNo(var Rec: Record "Standard General Journal Line"; var xRec: Record "Standard General Journal Line"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        with Rec do begin
            if not lfcnIsBottomUp then begin
                if "Corporate G/L Account No." <> '' then begin
                    lrecCorpGLAcc.Get("Corporate G/L Account No.");
                    lrecCorpGLAcc.TestField("Local G/L Account No.");

                    Validate("Account Type", "Account Type"::"G/L Account");
                    Validate("Account No.", lrecCorpGLAcc."Local G/L Account No.");
                end
            end else
                if "Corporate G/L Account No." <> '' then begin
                    Validate("Account Type", "Account Type"::"G/L Account");

                    lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");
                    lrecGLAcc.SetRange("Corporate G/L Account No.", "Corporate G/L Account No.");
                    if lrecGLAcc.Count = 1 then begin
                        lrecGLAcc.FindFirst;
                        Validate("Account No.", lrecGLAcc."No.");
                    end else
                        Validate("Account No.", '');
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 751, 'OnBeforeValidateEvent', 'Bal. Corporate G/L Account No.', false, false)]
    local procedure levtOnBeforeValidateBalCorporateGLAccountNo(var Rec: Record "Standard General Journal Line"; var xRec: Record "Standard General Journal Line"; CurrFieldNo: Integer)
    var
        lrecCorpGLAcc: Record "Corporate G/L Account";
        lrecGLAcc: Record "G/L Account";
    begin
        with Rec do begin
            if not lfcnIsBottomUp then begin
                if "Bal. Corporate G/L Account No." <> '' then begin
                    lrecCorpGLAcc.Get("Bal. Corporate G/L Account No.");
                    lrecCorpGLAcc.TestField("Local G/L Account No.");

                    Validate("Bal. Account Type", "Bal. Account Type"::"G/L Account");
                    Validate("Bal. Account No.", lrecCorpGLAcc."Local G/L Account No.");
                end
            end else
                if "Bal. Corporate G/L Account No." <> '' then begin
                    Validate("Bal. Account Type", "Bal. Account Type"::"G/L Account");

                    lrecGLAcc.SetCurrentKey("Corporate G/L Account No.");
                    lrecGLAcc.SetRange("Corporate G/L Account No.", "Bal. Corporate G/L Account No.");
                    if lrecGLAcc.Count = 1 then begin
                        lrecGLAcc.FindFirst;
                        Validate("Bal. Account No.", lrecGLAcc."No.");
                    end else
                        Validate("Bal. Account No.", '');
                end;
        end;
    end;

    local procedure lfcnIsBottomUp(): Boolean
    var
        lrecEYCoreSetup: Record "EY Core Setup";
    begin
        lrecEYCoreSetup.Get;
        exit(lrecEYCoreSetup."Company Type" = lrecEYCoreSetup."Company Type"::"Bottom-up");
    end;
}

