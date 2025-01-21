tableextension 50101 tableextension50101 extends "Job Usage Link"
{
    fields
    {
        modify("Job No.")
        {
            TableRelation = "Job Planning Line"."Job No.";
        }
        modify("Job Task No.")
        {
            TableRelation = "Job Planning Line"."Job Task No.";
        }
        modify("Line No.")
        {
            TableRelation = "Job Planning Line"."Line No.";
        }
    }
}

