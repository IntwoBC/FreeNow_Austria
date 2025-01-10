tableextension 50193 tableextension50193 extends "Whse. Cross-Dock Opportunity"
{
    fields
    {

        //Unsupported feature: Code Insertion (VariableCollection) on ""Qty. to Cross-Dock"(Field 26).OnValidate".

        //trigger (Variable: ReceiptLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Cross-Dock"(Field 26).OnValidate".

        //trigger  to Cross-Dock"(Field 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Qty. to Cross-Dock (Base)" := CalcBaseQty("Qty. to Cross-Dock");
        CalcFields("Qty. Cross-Docked (Base)");
        CalcQtyOnCrossDock(NotUsed,QtyOnCrossdockAllUomBase);
        if ("Qty. Cross-Docked (Base)" + "Qty. to Cross-Dock (Base)" - xRec."Qty. to Cross-Dock (Base)") +
           QtyOnCrossdockAllUomBase >
           CalcQtyToHandleBase("Source Template Name","Source Name/No.","Source Line No.")
        then
          Error(CrossDockQtyExceedsReceiptQtyErr);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ("Qty. Cross-Docked (Base)" + "Qty. to Cross-Dock (Base)" - xRec."Qty. to Cross-Dock (Base)") -
        #5..7
          Error(
            Text001,
            FieldCaption("Qty. to Cross-Dock (Base)"),
            ReceiptLine.FieldCaption("Qty. to Receive (Base)"),
            ReceiptLine.TableCaption);
        */
        //end;
    }


    //Unsupported feature: Code Modification on "AutoFillQtyToCrossDock(PROCEDURE 1)".

    //procedure AutoFillQtyToCrossDock();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CrossDock.CopyFilters(Rec);
    with CrossDock do
      if Find('-') then begin
        QtyToHandleBase := CalcQtyToHandleBase("Source Template Name","Source Name/No.","Source Line No.");

        CrossDockMgt.CalcCrossDockedItems("Item No.","Variant Code",
          "Unit of Measure Code","Location Code",Dummy,QtyOnCrossDockBase);
        QtyOnCrossDockBase += CrossDockMgt.CalcCrossDockReceivedNotCrossDocked("Location Code","Item No.","Variant Code");

        repeat
          CalcFields("Qty. Cross-Docked (Base)");
          if ("Qty. Cross-Docked (Base)" + QtyOnCrossDockBase) >= QtyToHandleBase then
            exit;
          if "Qty. Needed (Base)" <> Rec."Qty. to Cross-Dock (Base)" then
            if (QtyToHandleBase - "Qty. Cross-Docked (Base)" - QtyOnCrossDockBase) > "Qty. Needed (Base)" then begin
              Validate(
                "Qty. to Cross-Dock",
                CalcQty("Qty. Needed (Base)","To-Src. Qty. per Unit of Meas."));
              Modify;
            end else begin
              Validate(
                "Qty. to Cross-Dock",
                CalcQty(QtyToHandleBase - "Qty. Cross-Docked (Base)" - QtyOnCrossDockBase,"To-Src. Qty. per Unit of Meas."));
              Modify;
            end;
        until Next = 0;
      end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    #9..11
          if ("Qty. Cross-Docked (Base)" - QtyOnCrossDockBase) >= QtyToHandleBase then
            exit;
          if "Qty. Needed (Base)" <> Rec."Qty. to Cross-Dock (Base)" then
            if (QtyToHandleBase - "Qty. Cross-Docked (Base)" + QtyOnCrossDockBase) > "Qty. Needed (Base)" then begin
    #16..22
                CalcQty(QtyToHandleBase - "Qty. Cross-Docked (Base)" + QtyOnCrossDockBase,"To-Src. Qty. per Unit of Meas."));
    #24..27
    */
    //end;


    //Unsupported feature: Code Modification on "CalcQtyOnCrossDock(PROCEDURE 4)".

    //procedure CalcQtyOnCrossDock();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Source Template Name" = '' then begin
      ReceiptLine.Get("Source Name/No.","Source Line No.");
      CrossDockMgt.CalcCrossDockedItems(ReceiptLine."Item No.",ReceiptLine."Variant Code",
        ReceiptLine."Unit of Measure Code",ReceiptLine."Location Code",QtyOnCrossDockUOMBase,
        QtyOnCrossDockAllUOMBase);
      QtyOnCrossDockAllUOMBase +=
        CrossDockMgt.CalcCrossDockReceivedNotCrossDocked(
          ReceiptLine."Location Code",ReceiptLine."Item No.",ReceiptLine."Variant Code");
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    end;
    */
    //end;

    var
        ReceiptLine: Record "Warehouse Receipt Line";

    var
        Text001: Label 'The sum of %1 on %3 must not exceed %2 on %4.';
}

