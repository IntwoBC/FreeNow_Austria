codeunit 60026 "Company Type Management"
{
    // MP 25-11-13
    // Object created (CR 30)
    // 
    // MP 07-05-14
    // Changed filter in function gfcnApplyFilterGLAcc
    // 
    // MP 15-06-15
    // Added function LookupUser, Identical copy of function of same name from Codeunit 418 User Management, in order to
    // hide user listing for client access


    trigger OnRun()
    begin
    end;

    var
        grecEYCoreSetup: Record "EY Core Setup";
        gblnEYCoreSetupRead: Boolean;

    //[Scope('Internal')]
    procedure gfcnApplyFilterGLAcc(var precGLAcc: Record "G/L Account"; pintFilterGroup: Integer) rblnIsBottomUp: Boolean
    var
        lrecGenJnlTemplate: Record "Gen. Journal Template";
    begin
        // MP 25-11-13

        rblnIsBottomUp := gfcnIsBottomUp;
        with precGLAcc do
            if rblnIsBottomUp then begin
                if pintFilterGroup <> 0 then
                    FilterGroup(pintFilterGroup);

                // MP 07-05-14 >>
                //SETRANGE("Global Dimension 1 Filter",'');
                //lrecGenJnlTemplate.SetRange(Type, lrecGenJnlTemplate.Type::"Tax Adjustments");
                lrecGenJnlTemplate.FindFirst;
                SetFilter("Global Dimension 1 Filter", '%1|%2', '', lrecGenJnlTemplate."Shortcut Dimension 1 Code");
                // MP 07-05-14 <<

                if pintFilterGroup <> 0 then
                    FilterGroup(0);
            end;
    end;

    //[Scope('Internal')]
    procedure gfcnApplyFilterCorpGLAcc(var precCorpGLAcc: Record "Corporate G/L Account"; pintFilterGroup: Integer) rblnIsBottomUp: Boolean
    begin
        // MP 25-11-13

        rblnIsBottomUp := gfcnIsBottomUp;
        with precCorpGLAcc do
            if not rblnIsBottomUp then begin
                if pintFilterGroup <> 0 then
                    FilterGroup(pintFilterGroup);

                SetRange("Global Dimension 1 Filter", '');

                if pintFilterGroup <> 0 then
                    FilterGroup(0);
            end;
    end;

    local procedure lfcnGetEYCoreSetup()
    begin
        // MP 25-11-13

        if not gblnEYCoreSetupRead then begin
            grecEYCoreSetup.Get;
            grecEYCoreSetup.CalcFields("Corp. Accounts In use");
            gblnEYCoreSetupRead := true;
        end;
    end;

    //[Scope('Internal')]
    procedure gfcnIsBottomUp() rblnIsBottomUp: Boolean
    begin
        // MP 25-11-13

        lfcnGetEYCoreSetup;
        rblnIsBottomUp := grecEYCoreSetup."Company Type" = grecEYCoreSetup."Company Type"::"Bottom-up";
    end;

    //[Scope('Internal')]
    procedure gfcnCorpAccInUse() rblnCorpAccInUse: Boolean
    begin
        // MP 25-11-13

        lfcnGetEYCoreSetup;
        rblnCorpAccInUse := grecEYCoreSetup."Corp. Accounts In use";
    end;

    //[Scope('Internal')]
    procedure gfcnGetAccPeriodTableID() rintTableID: Integer
    begin
        // MP 25-11-13

        lfcnGetEYCoreSetup;
        if (grecEYCoreSetup."Company Type" = grecEYCoreSetup."Company Type"::"Bottom-up") and
          (not grecEYCoreSetup."Corp. Accounts In use")
        then
            exit(DATABASE::"Accounting Period");

        exit(DATABASE::"Corporate Accounting Period");
    end;
}

