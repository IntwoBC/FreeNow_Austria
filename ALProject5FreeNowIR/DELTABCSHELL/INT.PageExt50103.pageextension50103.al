pageextension 50103 pageextension50103 extends "Job Planning Lines"
{
    layout
    {

        modify("Job No.")
        {
            Visible = "Job No.Visible";
        }

    }

    var

        "Job No.Visible": Boolean;

    procedure SetJobNoVisible(JobNoVisible: Boolean)
    begin
        "Job No.Visible" := JobNoVisible;
    end;
}

