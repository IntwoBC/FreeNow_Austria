codeunit 50003 UpdateNewGLEntry
{
    trigger OnRun()
    var
        I2IGLentry: Record "I2I G/L Entry";
        GLEntry: Record "G/L Entry";
        LastProcessedEntryNo: Integer;
    begin
        // Step 1: Find the last processed Entry No. in the staging table
        if I2IGLentry.FindLast() then
            LastProcessedEntryNo := I2IGLentry."Entry No."
        else
            LastProcessedEntryNo := 0; // No entries processed yet

        // Step 2: Filter G/L Entries to include only recent entries
        GLEntry.SetFilter("Entry No.", '>=%1', LastProcessedEntryNo + 1);

        // Step 3: Insert new entries into the staging table
        if GLEntry.FindSet() then
            repeat
                I2IGLentry.Init();
                I2IGLentry.TransferFields(GLEntry);
                I2IGLentry."Entry No." := GLEntry."Entry No.";
                I2IGLentry.Insert();
            until GLEntry.Next() = 0;
    end;
}