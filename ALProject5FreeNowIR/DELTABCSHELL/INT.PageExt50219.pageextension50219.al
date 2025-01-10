pageextension 50219 pageextension50219 extends "Budget Matrix"
{

    //Unsupported feature: Code Modification on "BudgetDrillDown(PROCEDURE 1172)".

    //procedure BudgetDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLBudgetEntry.SetRange("Budget Name",GLBudgetName.Name);
    if GLAccBudgetBuf.GetFilter("G/L Account Filter") <> '' then
      GLAccBudgetBuf.CopyFilter("G/L Account Filter",GLBudgetEntry."G/L Account No.");
    #4..25
        SetCurrentKey("Budget Name","G/L Account No.","Business Unit Code","Global Dimension 1 Code")
      else
        SetCurrentKey("Budget Name","G/L Account No.",Date);
    GLBudgetEntries.SetEditable(true);
    GLBudgetEntries.SetTableView(GLBudgetEntry);
    GLBudgetEntries.Run;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..28
    PAGE.Run(0,GLBudgetEntry);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "BudgetDrillDown(PROCEDURE 1172).GLBudgetEntries(Variable 1000)".

}

