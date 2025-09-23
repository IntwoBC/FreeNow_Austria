report 50002 "I2I Delete GL Entry"
{
    ApplicationArea = All;
    Caption = 'Delete GL Entry';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(EntryNo)
                {
                    field(FromEntryNo; FromEntryNo)
                    {
                        ApplicationArea = All;
                        Caption = 'From Entry No.';
                    }
                    field(ToEntryNo; ToEntryNo)
                    {
                        ApplicationArea = All;
                        Caption = 'To Entry No.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if (FromEntryNo = 0) or (ToEntryNo = 0) then
            Error('Please enter both "From Entry No." and "To Entry No." before running the report.');
    end;

    trigger OnPostReport()
    var
        I2IGLEntryL: Record "I2I G/L Entry";
    begin
        I2IGLEntryL.SetCurrentKey("Entry No.");
        I2IGLEntryL.SetFilter("Entry No.", '%1..%2', FromEntryNo, ToEntryNo);
        if I2IGLEntryL.FindSet() then
            I2IGLEntryL.DeleteAll();
    end;

    var
        FromEntryNo: Integer;
        ToEntryNo: Integer;
}