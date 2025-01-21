tableextension 50196 tableextension50196 extends "Standard Cost Worksheet"
{

    //Unsupported feature: Code Modification on "UpdateCostShares(PROCEDURE 4)".

    //procedure UpdateCostShares();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if xRec."New Standard Cost" <> 0 then
      Ratio := "New Standard Cost" / xRec."New Standard Cost";

    "New Single-Lvl Material Cost" := RoundAmt("New Single-Lvl Material Cost",Ratio);
    #5..25
       "New Rolled-up Subcontrd Cost" +
       "New Rolled-up Cap. Ovhd Cost");
    "New Rolled-up Material Cost" := "New Rolled-up Material Cost" + RoundingResidual;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if xRec."Standard Cost" <> 0 then
    #2..28
    */
    //end;
}

