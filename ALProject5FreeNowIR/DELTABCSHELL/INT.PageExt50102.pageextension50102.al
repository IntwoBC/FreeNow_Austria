pageextension 50102 pageextension50102 extends "Job Task Lines"
{
    actions
    {

        //Unsupported feature: Code Modification on "JobPlanningLines(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Job Task Type","Job Task Type"::Posting);
        TestField("Job No.");
        TestField("Job Task No.");
        JobPlanningLine.FilterGroup(2);
        JobPlanningLine.SetRange("Job No.","Job No.");
        JobPlanningLine.SetRange("Job Task No.","Job Task No.");
        JobPlanningLine.FilterGroup(0);
        JobPlanningLines.SetJobTaskNoVisible(false);
        JobPlanningLines.SetTableView(JobPlanningLine);
        JobPlanningLines.Run;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        JobPlanningLine.SetRange("Job No.","Job No.");
        JobPlanningLine.SetRange("Job Task No.","Job Task No.");
        JobPlanningLines.SetJobNoVisible(false);
        #8..10
        */
        //end;
    }
}

