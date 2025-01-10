tableextension 50110 tableextension50110 extends "Payment Application Proposal"
{

    //Unsupported feature: Code Modification on "Apply(PROCEDURE 5)".

    //procedure Apply();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AppliedPaymentEntry.TransferFields(Rec);
    BankAccReconciliationLine.Get(
      AppliedPaymentEntry."Statement Type",AppliedPaymentEntry."Bank Account No.",
      AppliedPaymentEntry."Statement No.",AppliedPaymentEntry."Statement Line No.");
    MatchBankPayments.SetApplicationDataInCVLedgEntry(
      "Account Type","Applies-to Entry No.",BankAccReconciliationLine.GetAppliesToID);

    if AmtToApply = 0 then
      Error(StmtAmtIsFullyAppliedErr);
    #10..22

    if BankAccReconciliationLine."Transaction Date" < "Posting Date" then
      Message(StrSubstNo(TransactionDateIsBeforePostingDateMsg,BankAccReconciliationLine."Transaction Date","Posting Date"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AppliedPaymentEntry.TransferFields(Rec);

    #2..4
    #7..25
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "Apply(PROCEDURE 5).MatchBankPayments(Variable 1004)".

}

