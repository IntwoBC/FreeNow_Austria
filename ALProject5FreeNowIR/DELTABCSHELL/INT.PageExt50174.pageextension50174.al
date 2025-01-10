pageextension 50174 pageextension50174 extends "Standard Cost Worksheet"
{
    var
        Text001: Label 'Default';


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Standard Cost Worksheet Name" <> '' then // called from batch
          CurrWkshName := "Standard Cost Worksheet Name";

        if not StdCostWkshName.Get(CurrWkshName) then
          if not StdCostWkshName.FindFirst then begin
            StdCostWkshName.Name := DefaultNameTxt;
            StdCostWkshName.Description := DefaultNameTxt;
            StdCostWkshName.Insert;
          end;
        CurrWkshName := StdCostWkshName.Name;

        FilterGroup := 2;
        SetRange("Standard Cost Worksheet Name",CurrWkshName);
        FilterGroup := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not StdCostWkshName.Get("Standard Cost Worksheet Name") then begin
          if StdCostWkshName.FindFirst then begin
            if CurrWkshName = '' then
              CurrWkshName := StdCostWkshName.Name
          end else begin
            StdCostWkshName.Name := Text001;
            StdCostWkshName.Description := Text001;
            StdCostWkshName.Insert;
            CurrWkshName := StdCostWkshName.Name;
          end;
        end else
          CurrWkshName := "Standard Cost Worksheet Name";
        #11..14
        */
        //end;
}

