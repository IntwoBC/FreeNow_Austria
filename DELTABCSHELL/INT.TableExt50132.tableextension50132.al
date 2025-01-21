tableextension 50132 tableextension50132 extends "Issued Reminder Header"
{
    // #MyTaxi.W1.CRE.ACREC.001 28/11/2017 CCFR.SDE : Print Level Custom Report Layout
    //   Modified functions : PrintRecords,SendReport

    //Unsupported feature: Variable Insertion (Variable: ReportSelection) (VariableCollection) on "PrintRecords(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforePrintRecords(Rec,ShowRequestForm,SendAsEmail,HideDialog,IsHandled);
    if IsHandled then
    #4..21
        IssuedReminderHeaderToSend.FieldNo("Customer No."),ShowRequestForm);

    OnAfterPrintRecords(Rec,ShowRequestForm,SendAsEmail,HideDialog);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..24
    */
    //end;

    var
        "--- MyTaxi.W1.CRE.ACREC.001 ---": Integer;
        ReminderLevel: Record "Reminder Level";
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        CustomReportSelection: Record "Custom Report Selection";
        IssuedReminder: Page "Issued Reminder";
        CustomLayoutPresent: Boolean;
}

