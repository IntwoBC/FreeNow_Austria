pageextension 50221 pageextension50221 extends "MyDim Value Combinations"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "PreviousSet(Action 1102601002)".


        //Unsupported feature: Property Modification (Name) on "PreviousColumn(Action 1102601003)".


        //Unsupported feature: Property Modification (Name) on "NextColumn(Action 1102601004)".


        //Unsupported feature: Property Modification (Name) on "NextSet(Action 1102601001)".

    }

    //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1106)".

    //procedure "MATRIX_GenerateColumnCaptions"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if DimensionValueCombination."Dimension 2 Code" <> '' then
      MatrixRecord.SetRange(Code,DimensionValueCombination."Dimension 2 Value Code");
    RecRef.GetTable(MatrixRecord);
    #4..9
      MATRIX_CaptionSet,MATRIX_ColumnSet,MATRIX_CurrSetLength);
    Clear(MatrixRecords);
    MatrixRecord.SetPosition(PrimaryKeyFirstCaptionInCurrSe);
    repeat
      CurrentMatrixRecordOrdinal += 1;
      MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
    until (CurrentMatrixRecordOrdinal = ArrayLen(MatrixRecords)) or (MatrixRecord.Next <> 1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    CurrentMatrixRecordOrdinal := 1;
    repeat
      MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
      CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
    until (CurrentMatrixRecordOrdinal = ArrayLen(MatrixRecords)) or (MatrixRecord.Next <> 1);
    */
    //end;
}

