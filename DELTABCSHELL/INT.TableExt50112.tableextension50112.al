tableextension 50112 tableextension50112 extends Location
{
    fields
    {

        //Unsupported feature: Code Modification on ""Require Put-away"(Field 5726).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseRcptHeader.SetRange("Location Code",Code);
        if not WhseRcptHeader.IsEmpty then
          Error(Text008,FieldCaption("Require Put-away"),xRec."Require Put-away",WhseRcptHeader.TableCaption);
        #4..9
            Error(Text008,FieldCaption("Require Put-away"),true,WhseActivHeader.TableCaption);
          "Use Cross-Docking" := false;
          "Cross-Dock Bin Code" := '';
        end else
          CreateInboundWhseRequest;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12
        end;
        */
        //end;


        //Unsupported feature: Code Modification on ""Require Receive"(Field 5730).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not "Require Receive" then begin
          TestField("Directed Put-away and Pick",false);
          WhseRcptHeader.SetRange("Location Code",Code);
        #4..10
          WhseActivHeader.SetRange("Location Code",Code);
          if not WhseActivHeader.IsEmpty then
            Error(Text008,FieldCaption("Require Receive"),false,WhseActivHeader.TableCaption);

          CreateInboundWhseRequest;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        end;
        */
        //end;
    }

    procedure GetBinCode(UseFlushingMethod: Boolean; FlushingMethod: Option Manual,Forward,Backward,"Pick + Forward","Pick + Backward"): Code[20]
    begin
        if not UseFlushingMethod then
            exit("From-Production Bin Code");

        case FlushingMethod of
            FlushingMethod::Manual,
          FlushingMethod::"Pick + Forward",
          FlushingMethod::"Pick + Backward":
                exit("To-Production Bin Code");
            FlushingMethod::Forward,
          FlushingMethod::Backward:
                exit("Open Shop Floor Bin Code");
        end;
    end;
}

