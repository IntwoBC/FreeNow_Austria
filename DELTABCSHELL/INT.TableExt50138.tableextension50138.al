tableextension 50138 tableextension50138 extends "Sales Line"
{
    Caption = 'Sales Line';
    fields
    {
        modify("Document Type")
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        }
        modify("Sell-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Line No.")
        {
            Caption = 'Line No.';
        }
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
        }
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Posting Group")
        {
            Caption = 'Posting Group';
        }
        modify("Shipment Date")
        {
            Caption = 'Shipment Date';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Unit of Measure")
        {
            Caption = 'Unit of Measure';
        }
        modify(Quantity)
        {
            Caption = 'Quantity';
        }
        modify("Outstanding Quantity")
        {
            Caption = 'Outstanding Quantity';
        }
        modify("Qty. to Invoice")
        {
            Caption = 'Qty. to Invoice';
        }
        modify("Qty. to Ship")
        {
            Caption = 'Qty. to Ship';
        }
        modify("Unit Price")
        {
            Caption = 'Unit Price';
        }
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost (LCY)';
        }
        modify("VAT %")
        {
            Caption = 'VAT %';
        }
        modify("Line Discount %")
        {
            Caption = 'Line Discount %';
        }
        modify("Line Discount Amount")
        {
            Caption = 'Line Discount Amount';
        }
        modify(Amount)
        {
            Caption = 'Amount';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including VAT';
        }
        modify("Allow Invoice Disc.")
        {
            Caption = 'Allow Invoice Disc.';
        }
        modify("Gross Weight")
        {
            Caption = 'Gross Weight';
        }
        modify("Net Weight")
        {
            Caption = 'Net Weight';
        }
        modify("Units per Parcel")
        {
            Caption = 'Units per Parcel';
        }
        modify("Unit Volume")
        {
            Caption = 'Unit Volume';
        }
        modify("Appl.-to Item Entry")
        {
            Caption = 'Appl.-to Item Entry';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Customer Price Group")
        {
            Caption = 'Customer Price Group';
        }
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Work Type Code")
        {
            Caption = 'Work Type Code';
        }
        modify("Recalculate Invoice Disc.")
        {
            Caption = 'Recalculate Invoice Disc.';
        }
        modify("Outstanding Amount")
        {
            Caption = 'Outstanding Amount';
        }
        modify("Qty. Shipped Not Invoiced")
        {
            Caption = 'Qty. Shipped Not Invoiced';
        }
        modify("Shipped Not Invoiced")
        {
            Caption = 'Shipped Not Invoiced';
        }
        modify("Quantity Shipped")
        {
            Caption = 'Quantity Shipped';
        }
        modify("Quantity Invoiced")
        {
            Caption = 'Quantity Invoiced';
        }
        modify("Shipment No.")
        {
            Caption = 'Shipment No.';
        }
        modify("Shipment Line No.")
        {
            Caption = 'Shipment Line No.';
        }
        modify("Profit %")
        {
            Caption = 'Profit %';
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';
        }
        modify("Inv. Discount Amount")
        {
            Caption = 'Inv. Discount Amount';
        }
        modify("Purchase Order No.")
        {
            Caption = 'Purchase Order No.';
        }
        modify("Purch. Order Line No.")
        {
            Caption = 'Purch. Order Line No.';
        }
        modify("Drop Shipment")
        {
            Caption = 'Drop Shipment';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("VAT Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
        }
        modify("Transport Method")
        {
            Caption = 'Transport Method';
        }
        modify("Attached to Line No.")
        {
            Caption = 'Attached to Line No.';
        }
        modify("Exit Point")
        {
            Caption = 'Exit Point';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("Transaction Specification")
        {
            Caption = 'Transaction Specification';
        }
        modify("Tax Category")
        {
            Caption = 'Tax Category';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';
        }
        modify("Tax Group Code")
        {
            Caption = 'Tax Group Code';
        }
        modify("VAT Clause Code")
        {
            Caption = 'VAT Clause Code';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Outstanding Amount (LCY)")
        {
            Caption = 'Outstanding Amount (LCY)';
        }
        modify("Reserved Quantity")
        {
            Caption = 'Reserved Quantity';
        }
        modify(Reserve)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
        }
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }
        modify("VAT Base Amount")
        {
            Caption = 'VAT Base Amount';
        }
        modify("Unit Cost")
        {
            Caption = 'Unit Cost';
        }
        modify("System-Created Entry")
        {
            Caption = 'System-Created Entry';
        }
        modify("Line Amount")
        {
            Caption = 'Line Amount';
        }
        modify("VAT Difference")
        {
            Caption = 'VAT Difference';
        }
        modify("Inv. Disc. Amount to Invoice")
        {
            Caption = 'Inv. Disc. Amount to Invoice';
        }
        modify("VAT Identifier")
        {
            Caption = 'VAT Identifier';
        }
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.';
        }
        modify("IC Partner Reference")
        {
            Caption = 'IC Partner Reference';
        }
        modify("Prepayment %")
        {
            Caption = 'Prepayment %';
        }
        modify("Prepmt. Line Amount")
        {
            Caption = 'Prepmt. Line Amount';
        }
        modify("Prepmt. Amt. Inv.")
        {
            Caption = 'Prepmt. Amt. Inv.';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            Caption = 'Prepmt. Amt. Incl. VAT';
        }
        modify("Prepayment Amount")
        {
            Caption = 'Prepayment Amount';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            Caption = 'Prepmt. VAT Base Amt.';
        }
        modify("Prepayment VAT %")
        {
            Caption = 'Prepayment VAT %';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            Caption = 'Prepmt. VAT Calc. Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
        }
        modify("Prepayment VAT Identifier")
        {
            Caption = 'Prepayment VAT Identifier';
        }
        modify("Prepayment Tax Area Code")
        {
            Caption = 'Prepayment Tax Area Code';
        }
        modify("Prepayment Tax Liable")
        {
            Caption = 'Prepayment Tax Liable';
        }
        modify("Prepayment Tax Group Code")
        {
            Caption = 'Prepayment Tax Group Code';
        }
        modify("Prepmt Amt to Deduct")
        {
            Caption = 'Prepmt Amt to Deduct';
        }
        modify("Prepmt Amt Deducted")
        {
            Caption = 'Prepmt Amt Deducted';
        }
        modify("Prepayment Line")
        {
            Caption = 'Prepayment Line';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
        }
        modify("Prepmt. Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. Amount Inv. (LCY)';
        }
        modify("IC Partner Code")
        {
            Caption = 'IC Partner Code';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. VAT Amount Inv. (LCY)';
        }
        modify("Prepayment VAT Difference")
        {
            Caption = 'Prepayment VAT Difference';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            Caption = 'Prepmt VAT Diff. to Deduct';
        }
        modify("Prepmt VAT Diff. Deducted")
        {
            Caption = 'Prepmt VAT Diff. Deducted';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';
        }
        modify("Qty. to Assemble to Order")
        {
            Caption = 'Qty. to Assemble to Order';
        }
        modify("Qty. to Asm. to Order (Base)")
        {
            Caption = 'Qty. to Asm. to Order (Base)';
        }
        modify("ATO Whse. Outstanding Qty.")
        {
            Caption = 'ATO Whse. Outstanding Qty.';
        }
        modify("ATO Whse. Outstd. Qty. (Base)")
        {
            Caption = 'ATO Whse. Outstd. Qty. (Base)';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Deferral Code")
        {
            Caption = 'Deferral Code';
        }
        modify("Returns Deferral Start Date")
        {
            Caption = 'Returns Deferral Start Date';
        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Bin Code")
        {
            Caption = 'Bin Code';
        }
        modify("Qty. per Unit of Measure")
        {
            Caption = 'Qty. per Unit of Measure';
        }
        modify(Planned)
        {
            Caption = 'Planned';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Quantity (Base)")
        {
            Caption = 'Quantity (Base)';
        }
        modify("Outstanding Qty. (Base)")
        {
            Caption = 'Outstanding Qty. (Base)';
        }
        modify("Qty. to Invoice (Base)")
        {
            Caption = 'Qty. to Invoice (Base)';
        }
        modify("Qty. to Ship (Base)")
        {
            Caption = 'Qty. to Ship (Base)';
        }
        modify("Qty. Shipped Not Invd. (Base)")
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
        }
        modify("Qty. Shipped (Base)")
        {
            Caption = 'Qty. Shipped (Base)';
        }
        modify("Qty. Invoiced (Base)")
        {
            Caption = 'Qty. Invoiced (Base)';
        }
        modify("Reserved Qty. (Base)")
        {
            Caption = 'Reserved Qty. (Base)';
        }
        modify("FA Posting Date")
        {
            Caption = 'FA Posting Date';
        }
        modify("Depreciation Book Code")
        {
            Caption = 'Depreciation Book Code';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("Use Duplication List")
        {
            Caption = 'Use Duplication List';
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }
        modify("Out-of-Stock Substitution")
        {
            Caption = 'Out-of-Stock Substitution';
        }
        modify("Substitution Available")
        {
            Caption = 'Substitution Available';
        }
        modify("Originally Ordered No.")
        {
            Caption = 'Originally Ordered No.';
        }
        modify("Originally Ordered Var. Code")
        {
            Caption = 'Originally Ordered Var. Code';
        }
        /*
        modify("Cross-Reference No.")
        {
            Caption = 'Cross-Reference No.';
        }
        modify("Unit of Measure (Cross Ref.)")
        {
            Caption = 'Unit of Measure (Cross Ref.)';
        }
        modify("Cross-Reference Type")
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
        }
        modify("Cross-Reference Type No.")
        {
            Caption = 'Cross-Reference Type No.';
        }*/
        modify("Item Category Code")
        {
            Caption = 'Item Category Code';
        }
        modify("Purchasing Code")
        {
            Caption = 'Purchasing Code';
        }
        /*modify("Product Group Code")
        {
            Caption = 'Product Group Code';
        }*/
        modify("Special Order")
        {
            Caption = 'Special Order';
        }
        modify("Special Order Purchase No.")
        {
            Caption = 'Special Order Purchase No.';
        }
        modify("Special Order Purch. Line No.")
        {
            Caption = 'Special Order Purch. Line No.';
        }
        modify("Whse. Outstanding Qty.")
        {
            Caption = 'Whse. Outstanding Qty.';
        }
        modify("Whse. Outstanding Qty. (Base)")
        {
            Caption = 'Whse. Outstanding Qty. (Base)';
        }
        modify("Completely Shipped")
        {
            Caption = 'Completely Shipped';
        }
        modify("Requested Delivery Date")
        {
            Caption = 'Requested Delivery Date';
        }
        modify("Promised Delivery Date")
        {
            Caption = 'Promised Delivery Date';
        }
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Outbound Whse. Handling Time")
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        modify("Planned Delivery Date")
        {
            Caption = 'Planned Delivery Date';
        }
        modify("Planned Shipment Date")
        {
            Caption = 'Planned Shipment Date';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Allow Item Charge Assignment")
        {
            Caption = 'Allow Item Charge Assignment';
        }
        modify("Qty. to Assign")
        {
            Caption = 'Qty. to Assign';
        }
        modify("Qty. Assigned")
        {
            Caption = 'Qty. Assigned';
        }
        modify("Return Qty. to Receive")
        {
            Caption = 'Return Qty. to Receive';
        }
        modify("Return Qty. to Receive (Base)")
        {
            Caption = 'Return Qty. to Receive (Base)';
        }
        modify("Return Qty. Rcd. Not Invd.")
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
        }
        modify("Ret. Qty. Rcd. Not Invd.(Base)")
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
        }
        modify("Return Rcd. Not Invd.")
        {
            Caption = 'Return Rcd. Not Invd.';
        }
        modify("Return Rcd. Not Invd. (LCY)")
        {
            Caption = 'Return Rcd. Not Invd. (LCY)';
        }
        modify("Return Qty. Received")
        {
            Caption = 'Return Qty. Received';
        }
        modify("Return Qty. Received (Base)")
        {
            Caption = 'Return Qty. Received (Base)';
        }
        modify("Appl.-from Item Entry")
        {
            Caption = 'Appl.-from Item Entry';
        }
        modify("BOM Item No.")
        {
            Caption = 'BOM Item No.';
        }
        modify("Return Receipt No.")
        {
            Caption = 'Return Receipt No.';
        }
        modify("Return Receipt Line No.")
        {
            Caption = 'Return Receipt Line No.';
        }
        modify("Return Reason Code")
        {
            Caption = 'Return Reason Code';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("Customer Disc. Group")
        {
            Caption = 'Customer Disc. Group';
        }

        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField("Quantity Shipped",0);
        if "Blanket Order Line No." <> 0 then begin
          SalesLine2.Get("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
        #4..13
            Validate("Location Code",SalesLine2."Location Code");
            Validate("Unit of Measure Code",SalesLine2."Unit of Measure Code");
          end;
          Validate("Unit Price",SalesLine2."Unit Price");
          Validate("Line Discount %",SalesLine2."Line Discount %");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..16

        #17..19
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;

    if (Quantity <> 0) and ItemExists("No.") then begin
    #4..72
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetSalesDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..75
    */
    //end;


    //Unsupported feature: Property Modification (TextConstString) on "Text000(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete the order line because it is associated with purchase order %1 line %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete the order line because it is associated with purchase order %1 line %2.;ITA=Non è possibile eliminare la riga d'ordine perché è associata alla riga %2 dell'ordine di acquisto %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;ITA=Impossibile rinominare %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot change %1 because the order line is associated with purchase order %2 line %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot change %1 because the order line is associated with purchase order %2 line %3.;ITA=Non è possibile cambiare %1 perché la riga d'ordine è associata alla riga %3 dell'ordine di acquisto %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must not be less than %1;ITA=non può essere minore di %1;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text005(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot invoice more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot invoice more than %1 units.;ITA=Impossibile fatturare più di %1 unità.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text006(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot invoice more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot invoice more than %1 base units.;ITA=Impossibile fatturare più di %1 unità di base.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot ship more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot ship more than %1 units.;ITA=Non è possibile spedire più di %1 unità.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text008(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot ship more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot ship more than %1 base units.;ITA=Non è possibile spedire più di %1 unità di base.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=" must be 0 when %1 is %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=" must be 0 when %1 is %2";ITA=" deve essere 0 quando %1 è %2";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1013)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=%1 %2 is before work date %3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=%1 %2 is before work date %3;ITA=%1 %2 è anteriore alla data del lavoro %3;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text016(Variable 1040)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";ITA="%1 è necessario per %2 = %3.";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text020(Variable 1019)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;ITA=Impossibile effettuare il reso di più di %1 unità.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text021(Variable 1020)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;ITA=Impossibile effettuare il reso di più di %1 unità di base.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text026(Variable 1025)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text026 : ENU=You cannot change %1 if the item charge has already been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text026 : ENU=You cannot change %1 if the item charge has already been posted.;ITA=Impossibile modificare %1 se l'addebito articolo è già stato registrato.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text028(Variable 1098)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;ITA=Impossibile cambiare %1 quando %2 è stato compilato.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text029(Variable 1021)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=must be positive;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=must be positive;ITA=deve essere positivo;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text030(Variable 1042)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=must be negative;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=must be negative;ITA=deve essere negativo;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text031(Variable 1093)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=You must either specify %1 or %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=You must either specify %1 or %2.;ITA=¯ necessario specificare o %1 o %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text034(Variable 1084)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU=The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU=The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.;ITA=Il valore del campo %1 deve essere un numero intero per l'articolo incluso nel gruppo articoli in assistenza se il campo %2 nella finestra Gruppi articoli in assistenza contiene un segno di spunta.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text035(Variable 1083)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU="Warehouse ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU="Warehouse ";ITA="Warehouse ";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text036(Variable 1090)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text036 : ENU="Inventory ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text036 : ENU="Inventory ";ITA="Magazzino ";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text037(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=You cannot change %1 when %2 is %3 and %4 is positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=You cannot change %1 when %2 is %3 and %4 is positive.;ITA=Impossibile modificare %1 quando %2 è %3 e %4 è positivo.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text038(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=You cannot change %1 when %2 is %3 and %4 is negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=You cannot change %1 when %2 is %3 and %4 is negative.;ITA=Impossibile modificare %1 quando %2 è %3 e %4 è negativo.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text039(Variable 1034)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=%1 units for %2 %3 have already been returned. Therefore, only %4 units can be returned.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=%1 units for %2 %3 have already been returned. Therefore, only %4 units can be returned.;ITA=%1 unità per %2 %3 sono già state rese. Possono pertanto essere rese solo %4 unità.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text040(Variable 1039)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;ITA=Se è utilizzata la tracciabilità articolo, è necessario utilizzare il form %1 per inserire %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text042(Variable 1055)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry %1 will be opened first;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry %1 will be opened first;ITA=Durante la registrazione, %1 collegato al mov. contabile viene aperto per primo;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ShippingMoreUnitsThanReceivedErr(Variable 1047)".

    //var
    //>>>> ORIGINAL VALUE:
    //ShippingMoreUnitsThanReceivedErr : ENU=You cannot ship more than the %1 units that you have received for document no. %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShippingMoreUnitsThanReceivedErr : ENU=You cannot ship more than the %1 units that you have received for document no. %2.;ITA=Impossibile spedire più unità rispetto alle %1 unità ricevute per il documento nr. %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text044(Variable 1103)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=cannot be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=cannot be less than %1;ITA=non può essere minore di %1;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text045(Variable 1104)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : ENU=cannot be more than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : ENU=cannot be more than %1;ITA=non può essere maggiore di %1;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text046(Variable 1105)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : ENU=You cannot return more than the %1 units that you have shipped for %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : ENU=You cannot return more than the %1 units that you have shipped for %2 %3.;ITA=Impossibile effettuare il reso di più delle %1 unità spedite per %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text047(Variable 1106)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text047 : ENU=must be positive when %1 is not 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text047 : ENU=must be positive when %1 is not 0.;ITA=deve essere positivo se %1 è diverso da 0.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text048(Variable 1108)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text048 : ENU=You cannot use item tracking on a %1 created from a %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text048 : ENU=You cannot use item tracking on a %1 created from a %2.;ITA=Impossibile utilizzare la tracciabilità articolo su un %1 creato da un %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text049(Variable 1139)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=cannot be %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=cannot be %1.;ITA=non può essere %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text051(Variable 1141)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : ENU=You cannot use %1 in a %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : ENU=You cannot use %1 in a %2.;ITA=Impossibile utilizzare %1 in %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text052(Variable 1022)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text052 : ENU=You cannot add an item line because an open warehouse shipment exists for the sales header and Shipping Advice is %1.\\You must add items as new lines to the existing warehouse shipment or change Shipping Advice to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text052 : ENU=You cannot add an item line because an open warehouse shipment exists for the sales header and Shipping Advice is %1.\\You must add items as new lines to the existing warehouse shipment or change Shipping Advice to Partial.;ITA=Impossibile aggiungere una riga articolo perché esiste una spedizione warehouse aperta per Testate vendita e Avviso spedizione è %1.\\¯ necessario aggiungere gli articoli come nuove righe alla spedizione warehouse esistente o impostare Avviso spedizione su Parziale.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text053(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;ITA=Sono state modificate una o più dimensioni in %1, che è già stato spedito. Quando si registra la riga con la dimensione modificata nella contabilità generale, gli importi nel conto provvisorio di giacenza magazzino non quadreranno quando riportati in base alla dimensione.\\Mantenere la dimensione modificata?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text054(Variable 1023)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=Cancelled.;ITA=Annullato.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text055(Variable 1024)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text055 : @@@=Quantity Invoiced must not be greater than the sum of Qty. Assigned and Qty. to Assign.;ENU=%1 must not be greater than the sum of %2 and %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text055 : @@@=Quantity Invoiced must not be greater than the sum of Qty. Assigned and Qty. to Assign.;ENU=%1 must not be greater than the sum of %2 and %3.;ITA=%1 non deve essere maggiore della somma di %2 e %3.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text056(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text056 : ENU=You cannot add an item line because an open inventory pick exists for the Sales Header and because Shipping Advice is %1.\\You must first post or delete the inventory pick or change Shipping Advice to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text056 : ENU=You cannot add an item line because an open inventory pick exists for the Sales Header and because Shipping Advice is %1.\\You must first post or delete the inventory pick or change Shipping Advice to Partial.;ITA=Impossibile aggiungere una riga articolo perché esiste un prelievo magazzino aperto per Testate vendita e perché Avviso spedizione è %1.\\¯ innanzitutto necessario registrare o eliminare il prelievo magazzino o impostare Avviso spedizione su Parziale.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text057(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text057 : ENU=must have the same sign as the shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text057 : ENU=must have the same sign as the shipment;ITA=deve avere lo stesso segno della spedizione;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text058(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text058 : ENU=The quantity that you are trying to invoice is greater than the quantity in shipment %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text058 : ENU=The quantity that you are trying to invoice is greater than the quantity in shipment %1.;ITA=La quantità che si sta cercando di fatturare è superiore alla quantità della spedizione %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text059(Variable 1029)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text059 : ENU=must have the same sign as the return receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text059 : ENU=must have the same sign as the return receipt;ITA=deve avere lo stesso segno del carico da reso;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text060(Variable 1041)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text060 : ENU=The quantity that you are trying to invoice is greater than the quantity in return receipt %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text060 : ENU=The quantity that you are trying to invoice is greater than the quantity in return receipt %1.;ITA=La quantità che si sta cercando di fatturare è superiore alla quantità del carico da reso %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SalesLineCompletelyShippedErr(Variable 1053)".

    //var
    //>>>> ORIGINAL VALUE:
    //SalesLineCompletelyShippedErr : ENU=You cannot change the purchasing code for a sales line that has been completely shipped.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesLineCompletelyShippedErr : ENU=You cannot change the purchasing code for a sales line that has been completely shipped.;ITA=Impossibile modificare il codice acquisto per una riga vendita completamente spedita.;
    //Variable type has not been exported.
}

