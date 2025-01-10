tableextension 50115 tableextension50115 extends "Workflow Step Buffer"
{

    //Unsupported feature: Code Modification on "LookupEvents(PROCEDURE 39)".

    //procedure LookupEvents();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if WorkflowStep.Get("Workflow Code","Event Step ID") then
      FindParentEvent(WorkflowStep,ParentEventWorkflowStep)
    else begin
      TempWorkflowStepBuffer.Copy(Rec,true);
      TempWorkflowStepBuffer.SetRange("Workflow Code","Workflow Code");
      TempWorkflowStepBuffer.SetFilter(Order,'<%1',Order);
      if Indent > 0 then
        TempWorkflowStepBuffer.SetFilter(Indent,'<%1',Indent);
      if TempWorkflowStepBuffer.FindLast then
        ParentEventWorkflowStep.Get(TempWorkflowStepBuffer."Workflow Code",TempWorkflowStepBuffer."Event Step ID");
    end;
    #12..20
      exit(true);
    end;
    exit(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    #9..23
    */
    //end;
}

