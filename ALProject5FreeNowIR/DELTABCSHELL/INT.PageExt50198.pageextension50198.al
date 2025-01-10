pageextension 50198 pageextension50198 extends "Sales Analysis by Dimensions"
{

    //Unsupported feature: Code Modification on "SetPointsLocation(PROCEDURE 6)".

    //procedure SetPointsLocation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Clear(MatrixColumnCaptions);
    Location.SetFilter(Code,LocationFilter);
    RecRef.GetTable(Location);
    RecRef.SetTable(Location);

    if ShowColumnName then
      CaptionFieldNo := Location.FieldNo(Name)
    else
    #9..11
      MATRIX_CaptionRange,MATRIX_CurrSetLength);
    MATRIX_CodeRange :=
      MatrixMgt.GetPKRange(RecRef,Location.FieldNo(Code),MATRIX_PKFirstRecInCurrSet,MATRIX_CurrSetLength)
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #6..14
    */
    //end;


    //Unsupported feature: Code Modification on "SetPointsDim(PROCEDURE 17)".

    //procedure SetPointsDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Clear(MatrixColumnCaptions);
    DimVal.SetRange("Dimension Code",DimensionCode);
    if DimFilter <> '' then
    #4..9
    else
      CaptionFieldNo := DimVal.FieldNo(Code);

    MatrixMgt.GenerateMatrixData(RecRef,SetWanted,NoOfColumns,CaptionFieldNo,MATRIX_PKFirstRecInCurrSet,MatrixColumnCaptions,
      MATRIX_CaptionRange,MATRIX_CurrSetLength);
    if DimensionCode <> '' then
      MATRIX_CodeRange :=
        MatrixMgt.GetPKRange(RecRef,DimVal.FieldNo(Code),MATRIX_PKFirstRecInCurrSet,MATRIX_CurrSetLength);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    if ShowColumnName then begin
      MatrixMgt.GenerateMatrixData(RecRef,SetWanted,NoOfColumns,DimVal.FieldNo(Code),MATRIX_PKFirstRecInCurrSet,MatrixColumnCaptions,
        MATRIX_CaptionRange,MATRIX_CurrSetLength);
      MATRIX_CodeRange :=
        MatrixMgt.GetPKRange(RecRef,DimVal.FieldNo(Code),MATRIX_PKFirstRecInCurrSet,MATRIX_CurrSetLength);
    end;

    #13..17
    */
    //end;


    //Unsupported feature: Code Modification on "ShowMatrix(PROCEDURE 10)".

    //procedure ShowMatrix();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PeriodInitialized := ColumnDimOption = ColumnDimOption::Period;
    if CurItemFilter = '' then
      CurItemFilter := ItemFilter;
    #4..16
      ShowOppositeSign,PeriodInitialized,ShowColumnName,MATRIX_CurrSetLength);
    SalesAnalysisByDimMatrix.LoadFilters(CurItemFilter,CurLocationFilter,CurDim1Filter,CurDim2Filter,CurDim3Filter,
      DateFilter,BudgetFilter,InternalDateFilter);
    SalesAnalysisByDimMatrix.LoadCodeRange(MATRIX_CodeRange);

    SalesAnalysisByDimMatrix.RunModal;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19

    SalesAnalysisByDimMatrix.RunModal;
    */
    //end;
}

