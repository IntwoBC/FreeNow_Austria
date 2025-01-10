pageextension 50196 pageextension50196 extends "Purchase Analysis Report"
{
    layout
    {

        //Unsupported feature: Code Modification on "CurrentReportName(Control 40).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if AnalysisReportMgt.LookupReportName(GetRangeMax("Analysis Area"),CurrentReportName) then begin
          Text := CurrentReportName;
          CurrentReportNameOnAfterValidate;
          exit(true);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if AnalysisReportMgt.LookupReportName(GetRangeMax("Analysis Area"),CurrentReportName) then begin
          Text := CurrentReportName;
          exit(true);
        end;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentReportName(Control 40).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AnalysisReportMgt.CheckReportName(CurrentReportName,Rec);
        CurrentReportNameOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        AnalysisReportMgt.CheckReportName(CurrentReportName,Rec);
        CurrentReportNameOnAfterValida;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentLineTemplate(Control 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AnalysisReportMgt.CheckAnalysisLineTemplName(CurrentLineTemplate,Rec);
        CurrentLineTemplateOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        AnalysisReportMgt.CheckAnalysisLineTemplName(CurrentLineTemplate,Rec);
        CurrentLineTemplateOnAfterVali;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentColumnTemplate(Control 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if AnalysisReportMgt.LookupColumnName(GetRangeMax("Analysis Area"),CurrentColumnTemplate) then begin
          Text := CurrentColumnTemplate;
          CurrentColumnTemplateOnAfterValidate;
          exit(true);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if AnalysisReportMgt.LookupColumnName(GetRangeMax("Analysis Area"),CurrentColumnTemplate) then begin
          Text := CurrentColumnTemplate;
          exit(true);
        end;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentColumnTemplate(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AnalysisReportMgt.GetColumnTemplate(GetRangeMax("Analysis Area"),CurrentColumnTemplate);
        CurrentColumnTemplateOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        AnalysisReportMgt.GetColumnTemplate(GetRangeMax("Analysis Area"),CurrentColumnTemplate);
        CurrentColumnTemplateOnAfterVa;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentSourceTypeFilter(Control 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetRange("Source Type Filter",CurrentSourceTypeFilter);
        CurrentSourceTypeNoFilter := '';
        AnalysisReportMgt.SetSourceNo(Rec,CurrentSourceTypeNoFilter);
        CurrentSourceTypeFilterOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        CurrentSourceTypeFilterOnAfter;
        */
        //end;


        //Unsupported feature: Code Modification on "CurrentSourceTypeNoFilter(Control 25).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrentSourceTypeNoFilterOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrentSourceTypeNoFilterOnAft;
        */
        //end;
    }


    //Unsupported feature: Code Modification on "SetPointsAnalysisColumn(PROCEDURE 22)".

    //procedure SetPointsAnalysisColumn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AnalysisColumn2.SetRange("Analysis Area",AnalysisColumn2."Analysis Area"::Purchase);
    AnalysisColumn2.SetRange("Analysis Column Template",CurrentColumnTemplate);

    if (Direction = Direction::Forward) or
       (FirstColumn = '')
    then begin
      if LastColumn = '' then begin
        if AnalysisColumn2.Find('-') then;
        tmpFirstColumn := AnalysisColumn2."Column Header";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.Next(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column Header";
        tmpLastLineNo := AnalysisColumn2."Line No.";
      end else begin
        if AnalysisColumn2.Get(AnalysisColumn2."Analysis Area"::Purchase,CurrentColumnTemplate,LastLineNo) then;
        AnalysisColumn2.Next(1);
        tmpFirstColumn := AnalysisColumn2."Column Header";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.Next(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column Header";
        tmpLastLineNo := AnalysisColumn2."Line No.";
      end;
    end else begin
      if AnalysisColumn2.Get(AnalysisColumn2."Analysis Area"::Purchase,CurrentColumnTemplate,FirstLineNo) then;
      AnalysisColumn2.Next(-1);
      tmpLastColumn := AnalysisColumn2."Column Header";
      tmpLastLineNo := AnalysisColumn2."Line No.";
      AnalysisColumn2.Next(-NoOfColumns + 1);
      tmpFirstColumn := AnalysisColumn2."Column Header";
      tmpFirstLineNo := AnalysisColumn2."Line No.";
    end;

    #33..38
    LastColumn := tmpLastColumn;
    FirstLineNo := tmpFirstLineNo;
    LastLineNo := tmpLastLineNo;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
        tmpFirstColumn := AnalysisColumn2."Column No.";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.Next(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column No.";
    #13..16
        tmpFirstColumn := AnalysisColumn2."Column No.";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.Next(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column No.";
    #21..25
      tmpLastColumn := AnalysisColumn2."Column No.";
      tmpLastLineNo := AnalysisColumn2."Line No.";
      AnalysisColumn2.Next(-NoOfColumns + 1);
      tmpFirstColumn := AnalysisColumn2."Column No.";
    #30..41
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "CurrentReportNameOnAfterValidate(PROCEDURE 19043622)".


    //Unsupported feature: Property Modification (Name) on "CurrentLineTemplateOnAfterValidate(PROCEDURE 19002239)".


    //Unsupported feature: Property Modification (Name) on "CurrentColumnTemplateOnAfterValidate(PROCEDURE 19007060)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeNoFilterOnAfterValidate(PROCEDURE 19027013)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeFilterOnAfterValidate(PROCEDURE 19072332)".

}

