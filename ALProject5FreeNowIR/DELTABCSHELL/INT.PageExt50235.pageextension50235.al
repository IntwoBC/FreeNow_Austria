pageextension 50235 pageextension50235 extends "Customer Report Selections"
{
    layout
    {

        //Unsupported feature: Code Insertion (VariableCollection) on ""Custom Report Description"(Control 7).OnDrillDown".

        //trigger (Variable: CustomReportLayout)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Custom Report Description"(Control 7).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookupCustomReportDescription;
        CurrPage.Update(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CustomReportLayout.SetCurrentKey("Report ID","Company Name",Type);
        CustomReportLayout.SetRange("Report ID","Report ID");
        CustomReportLayout.SetFilter("Company Name",'%1|%2','',CompanyName);
        CustomReportLayouts.SetTableView(CustomReportLayout);
        if CustomReportLayouts.RunModal = ACTION::OK then begin
          CustomReportLayouts.GetRecord(CustomReportLayout);
          "Custom Report Layout Code" := CustomReportLayout.Code;
          Modify;
          CalcFields("Custom Report Description");
        end;
        */
        //end;
        modify("Custom Report Description")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Lookup) on ""Custom Report Description"(Control 7)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Custom Report Description"(Control 7)".

    }

    var
        CustomReportLayout: Record "Custom Report Layout";
        CustomReportLayouts: Page "Custom Report Layouts";
}

