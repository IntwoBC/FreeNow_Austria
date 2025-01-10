tableextension 50116 tableextension50116 extends "Workflow Rule"
{

    //Unsupported feature: Code Modification on "CompareValues(PROCEDURE 7)".

    //procedure CompareValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Value.IsInteger or Value.IsBigInteger or Value.IsDecimal or Value.IsDuration then
      exit(CompareNumbers(xValue,Value));

    if Value.IsDate then
      exit(CompareDates(xValue,Value));

    if Value.IsTime then
      exit(CompareTimes(xValue,Value));

    if Value.IsDateTime then
      exit(CompareDateTimes(xValue,Value));

    exit(CompareText(Format(xValue,0,2),Format(Value,0,2)));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    exit(CompareText(Format(xValue,0,2),Format(Value,0,2)));
    */
    //end;
}

