tableextension 50234 tableextension50234 extends "Production BOM Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""No."(Field 11).OnValidate".

        //trigger "(Field 11)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestField(Type);

        TestStatus;
        #4..8
              Description := Item.Description;
              Item.TestField("Base Unit of Measure");
              "Unit of Measure Code" := Item."Base Unit of Measure";
              "Scrap %" := Item."Scrap %";
              if "No." <> xRec."No." then
                "Variant Code" := '';
              OnValidateNoOnAfterAssignItemFields(Rec,Item,xRec,CurrFieldNo);
        #16..22
              OnValidateNoOnAfterAssignProdBOMFields(Rec,ProdBOMHeader,xRec,CurrFieldNo);
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        #13..25
        */
        //end;
    }
}

