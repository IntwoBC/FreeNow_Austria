tableextension 50221 tableextension50221 extends "Assembly Header"
{

    //Unsupported feature: Code Modification on "ValidateDates(PROCEDURE 34)".

    //procedure ValidateDates();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case FieldNumToCalculateFrom of
      FieldNo("Due Date"):
        begin
    #4..18
            "Due Date" := NewDueDate;
            "Starting Date" := NewStartDate;
          end else begin
            ValidateStartDate(NewStartDate,false);
            if not IsAsmToOrder then begin
              if "Due Date" <> NewDueDate then
                if GuiAllowed and
    #26..31
                then
                  ValidateDueDate(NewDueDate,false);
            end;
          end;
        end;
      FieldNo("Starting Date"):
    #38..73
      Error(Text015,FieldCaption("Due Date"),"Due Date",FieldCaption("Ending Date"),"Ending Date");
    if "Ending Date" < "Starting Date" then
      Error(Text015,FieldCaption("Ending Date"),"Ending Date",FieldCaption("Starting Date"),"Starting Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21
    #23..34
            ValidateStartDate(NewStartDate,false);
    #35..76
    */
    //end;
}

