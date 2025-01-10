tableextension 50139 tableextension50139 extends "Excel Buffer"
{
    // MP 18-11-15
    // Added function gfcnAddWorksheet (CB1 Enhancements)

    procedure gfcnAddWorksheet(ptxtSheetName: Text[250])
    begin
        // MP 18-11-15

        //XlWrkShtWriter := XlWrkBkWriter.AddWorksheet(ptxtSheetName);
    end;
}

