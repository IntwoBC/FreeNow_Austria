pageextension 50197 pageextension50197 extends "Inventory Analysis Report"
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

    //Unsupported feature: Property Modification (Name) on "CurrentReportNameOnAfterValidate(PROCEDURE 19043622)".


    //Unsupported feature: Property Modification (Name) on "CurrentLineTemplateOnAfterValidate(PROCEDURE 19002239)".


    //Unsupported feature: Property Modification (Name) on "CurrentColumnTemplateOnAfterValidate(PROCEDURE 19007060)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeNoFilterOnAfterValidate(PROCEDURE 19027013)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeFilterOnAfterValidate(PROCEDURE 19072332)".

}

