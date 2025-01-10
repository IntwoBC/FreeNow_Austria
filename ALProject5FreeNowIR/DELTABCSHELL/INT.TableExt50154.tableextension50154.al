tableextension 50154 tableextension50154 extends "Opportunity Entry"
{
    fields
    {

        //Unsupported feature: Deletion on ""Sales Cycle Stage"(Field 4).OnValidate".

    }

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Opp.Get("Opportunity No.");
    case "Action Taken" of
      "Action Taken"::" ",
      "Action Taken"::Next,
      "Action Taken"::Previous,
      "Action Taken"::Updated,
      "Action Taken"::Jumped:
        begin
          if SalesCycleStage.Get("Sales Cycle Code","Sales Cycle Stage") then
            "Sales Cycle Stage Description" := SalesCycleStage.Description;
          if Opp.Status <> Opp.Status::"In Progress" then begin
            Opp.Status := Opp.Status::"In Progress";
            Opp.Modify;
          end;
        end;
      "Action Taken"::Won:
        begin
    #18..34
          Opp.Modify;
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
        if Opp.Status <> Opp.Status::"In Progress" then begin
          Opp.Status := Opp.Status::"In Progress";
          Opp.Modify;
    #15..37
    */
    //end;
}

