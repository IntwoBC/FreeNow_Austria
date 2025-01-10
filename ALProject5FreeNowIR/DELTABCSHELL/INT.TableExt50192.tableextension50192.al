tableextension 50192 tableextension50192 extends "Warehouse Activity Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Qty. to Handle"(Field 26).OnValidate".

        //trigger  to Handle"(Field 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsHandled := false;
        OnBeforeValidateQtyToHandle(Rec,IsHandled);
        if not IsHandled then
        #4..30
          if ("Breakbulk No." <> 0) or "Original Breakbulk" then
            UpdateBreakbulkQtytoHandle;

        if ("Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"]) and
           ("Action Type" <> "Action Type"::Place) and ("Lot No." <> '') and (CurrFieldNo <> 0)
        then
          CheckReservedItemTrkg(1,"Lot No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..33
        if ("Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"]) and
        #35..37
        */
        //end;


        //Unsupported feature: Code Modification on ""Serial No."(Field 6500).OnValidate".

        //trigger "(Field 6500)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Serial No." <> '' then begin
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,true);
          TestField("Qty. per Unit of Measure",1);

          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] then
            CheckReservedItemTrkg(0,"Serial No.");

          CheckSNSpecificationExists;
        #9..12

        if "Serial No." <> xRec."Serial No." then
          "Expiration Date" := 0D;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] then
        #6..15
        */
        //end;


        //Unsupported feature: Code Modification on ""Lot No."(Field 6501).OnValidate".

        //trigger "(Field 6501)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Lot No." <> '' then begin
          ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",SNRequired,LNRequired,true);

          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick"] then
            CheckReservedItemTrkg(1,"Lot No.");
        end;

        if "Lot No." <> xRec."Lot No." then
          "Expiration Date" := 0D;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          if "Activity Type" in ["Activity Type"::Pick,"Activity Type"::"Invt. Pick","Activity Type"::"Invt. Movement"] then
        #5..9
        */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 7300).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckBinInSourceDoc;

        if "Bin Code" <> '' then
        #4..67
              end else begin
                if "Qty. to Handle" > 0 then
                  CheckIncreaseCapacity(false);
                xRec.DeleteBinContent(xRec."Action Type"::Place);
              end;
            end;
            Dedicated := Bin.Dedicated;
        #75..78
            end;
            OnValidateBinCodeOnAfterGetBin(Rec,Bin);
          end else begin
            xRec.DeleteBinContent(xRec."Action Type"::Place);
            Dedicated := false;
            "Bin Ranking" := 0;
            "Bin Type Code" := '';
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..70
                DeleteBinContent(xRec."Action Type"::Place);
        #72..81
        #83..87
        */
        //end;


        //Unsupported feature: Code Modification on ""Zone Code"(Field 7301).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Zone Code" <> "Zone Code" then begin
          GetLocation("Location Code");
          Location.TestField("Directed Put-away and Pick");
          xRec.DeleteBinContent(xRec."Action Type"::Place);
          "Bin Code" := '';
          "Bin Ranking" := 0;
          "Bin Type Code" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          if "Action Type" = "Action Type"::Place then
            DeleteBinContent(xRec."Action Type"::Place);
        #5..8
        */
        //end;
    }


    //Unsupported feature: Code Modification on "DeleteRelatedWhseActivLines(PROCEDURE 13)".

    //procedure DeleteRelatedWhseActivLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeDeleteRelatedWhseActivLines(WhseActivLine,CalledFromHeader);

    with WhseActivLine do begin
    #4..30
        repeat
          OnBeforeDeleteWhseActivLine2(WhseActivLine2,CalledFromHeader);
          WhseActivLine2.Delete; // to ensure correct item tracking update
          WhseActivLine2.DeleteBinContent(WhseActivLine2."Action Type"::Place);
          UpdateRelatedItemTrkg(WhseActivLine2);
        until WhseActivLine2.Next = 0;

      if (not CalledFromHeader) and ("Action Type" <> "Action Type"::" ") then
        ShowDeletedMessage(WhseActivLine);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..33
          DeleteBinContent(xRec."Action Type"::Place);
    #35..40
    */
    //end;


    //Unsupported feature: Code Modification on "SplitLine(PROCEDURE 27)".

    //procedure SplitLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSplitLines(WhseActivLine);

    WhseActivLine.TestField("Qty. to Handle");
    #4..16
    else
      LineSpacing := 10000;

    if LineSpacing = 0 then begin
      ReNumberAllLines(NewWhseActivLine,WhseActivLine."Line No.",NewLineNo);
      WhseActivLine.Get(WhseActivLine."Activity Type",WhseActivLine."No.",NewLineNo);
      LineSpacing := 5000;
    end;

    NewWhseActivLine.Reset;
    NewWhseActivLine.Init;
    NewWhseActivLine := WhseActivLine;
    #29..68
    WhseActivLine.Modify;

    OnAfterSplitLines(WhseActivLine,NewWhseActivLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    #26..71
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "SplitLine(PROCEDURE 27).NewLineNo(Variable 1005)".

}

