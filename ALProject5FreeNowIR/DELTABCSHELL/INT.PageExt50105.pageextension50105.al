pageextension 50105 pageextension50105 extends "Payment-to-Entry Match"
{
    var
        OneAmountInclToleranceMatchedTxt: Label 'Yes - Single';
        MultipleAmountInclToleranceMatchedTxt: Label 'Yes - Multiple';
        NoMatchOnAmountInclToleranceTxt: Label 'No';

        AmountMatchText: Text;
    //Unsupported feature: Code Modification on "FetchData(PROCEDURE 1)".

    //procedure FetchData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FilterGroup(4);
    Evaluate(AppliesToEntryNo,GetFilter("Applies-to Entry No."));
    RecRef.GetTable(Rec);
    #4..44
    BankAccReconciliationLine."Match Confidence" := TypeHelper.GetOptionNo(
        GetFilter("Match Confidence"),MatchConfidenceFieldRef.OptionCaption);

    AmountMatchText := Format(BankPmtApplRule."Amount Incl. Tolerance Matched");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..47
    SetAmountInclToleranceMatched(BankPmtApplRule);
    */
    //end;

    local procedure SetAmountInclToleranceMatched(BankPmtApplRule: Record "Bank Pmt. Appl. Rule")
    begin
        case BankPmtApplRule."Amount Incl. Tolerance Matched" of
            BankPmtApplRule."Amount Incl. Tolerance Matched"::"One Match":
                AmountMatchText := OneAmountInclToleranceMatchedTxt;
            BankPmtApplRule."Amount Incl. Tolerance Matched"::"Multiple Matches":
                AmountMatchText := MultipleAmountInclToleranceMatchedTxt;
            BankPmtApplRule."Amount Incl. Tolerance Matched"::"No Matches":
                AmountMatchText := NoMatchOnAmountInclToleranceTxt;
        end;
    end;
}

