tableextension 50213 tableextension50213 extends "Standard Item Journal Line"
{

    //Unsupported feature: Code Modification on "GetUnitAmount(PROCEDURE 6)".

    //procedure GetUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RetrieveCosts;
    if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") or
       ("Item Charge No." <> '')
    then
      exit;

    UnitCostValue := UnitCost;
    if (CalledByFieldNo = FieldNo(Quantity)) and
       (Item."No." <> '') and (Item."Costing Method" <> Item."Costing Method"::Standard)
    then
      UnitCostValue := "Unit Cost" / UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

    case "Entry Type" of
      "Entry Type"::Purchase:
        PurchPriceCalcMgt.FindStdItemJnlLinePrice(Rec,CalledByFieldNo);
      "Entry Type"::Sale:
        SalesPriceCalcMgt.FindStdItemJnlLinePrice(Rec,CalledByFieldNo);
      "Entry Type"::"Positive Adjmt.":
        "Unit Amount" := Round(
            ((UnitCostValue - "Overhead Rate") * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
            GLSetup."Unit-Amount Rounding Precision");
      "Entry Type"::"Negative Adjmt.":
        if not "Phys. Inventory" then
          "Unit Amount" := UnitCostValue * "Qty. per Unit of Measure"
        else
          UnitCost := "Unit Cost";
      "Entry Type"::Transfer:
        "Unit Amount" := 0;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    #13..19
            ((UnitCost - "Overhead Rate") * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
    #21..23
          "Unit Amount" := UnitCost * "Qty. per Unit of Measure"
    #25..29
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "GetUnitAmount(PROCEDURE 6).UnitCostValue(Variable 1001)".

}

