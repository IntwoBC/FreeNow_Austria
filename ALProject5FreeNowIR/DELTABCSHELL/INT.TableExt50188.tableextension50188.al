tableextension 50188 tableextension50188 extends "Inventory Event Buffer"
{

    //Unsupported feature: Code Modification on "TransferFromInboundTransOrder(PROCEDURE 14)".

    //procedure TransferFromInboundTransOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    RecRef.GetTable(TransLine);
    "Source Line ID" := RecRef.RecordId;
    "Item No." := TransLine."Item No.";
    "Variant Code" := TransLine."Variant Code";
    "Location Code" := TransLine."Transfer-to Code";
    "Availability Date" := TransLine."Receipt Date";
    Type := Type::Transfer;
    TransLine.CalcFields("Reserved Qty. Inbnd. (Base)","Reserved Qty. Shipped (Base)");
    "Remaining Quantity (Base)" := TransLine."Quantity (Base)" - TransLine."Qty. Received (Base)";
    "Reserved Quantity (Base)" := TransLine."Reserved Qty. Inbnd. (Base)" + TransLine."Reserved Qty. Shipped (Base)";
    Positive := not ("Remaining Quantity (Base)" < 0);
    "Transfer Direction" := "Transfer Direction"::Inbound;

    OnAfterTransferFromInboundTransOrder(Rec,TransLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    TransLine.CalcFields("Reserved Qty. Inbnd. (Base)");
    "Remaining Quantity (Base)" := TransLine."Quantity (Base)" - TransLine."Qty. Received (Base)";
    "Reserved Quantity (Base)" := TransLine."Reserved Qty. Inbnd. (Base)";
    #12..15
    */
    //end;
}

