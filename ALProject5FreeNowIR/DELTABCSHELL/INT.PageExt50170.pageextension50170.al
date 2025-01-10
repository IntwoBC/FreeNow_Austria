pageextension 50170 pageextension50170 extends "Cross-Dock Opportunities"
{

    //Unsupported feature: Code Modification on "CalcValues(PROCEDURE 2)".

    //procedure CalcValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CrossDockMgt.CalcCrossDockedItems(ItemNo2,VariantCode2,'',LocationCode2,Dummy,QtyOnCrossDockBase);
    QtyOnCrossDockBase += CrossDockMgt.CalcCrossDockReceivedNotCrossDocked(LocationCode2,ItemNo2,VariantCode2);

    if TemplateName2 = '' then begin
      ReceiptLine.Get(NameNo2,LineNo2);
    #6..15
    "Location Code" := LocationCode2;
    "Unit of Measure Code" := UOMCode2;
    "Qty. per Unit of Measure" := QtyPerUOM2;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CrossDockMgt.CalcCrossDockedItems(ItemNo2,VariantCode2,'',LocationCode2,Dummy,QtyOnCrossDockBase);
    #3..18
    */
    //end;
}

