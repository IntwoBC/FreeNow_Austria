codeunit 63010 "P:General Journal Batches"
{

    trigger OnRun()
    begin
    end;

    var
        txt60000: Label 'Note that only the lines marked as %1 will be posted.';
        txt60001: Label 'journals cannot be posted from here, please open the journal and post,';

    [EventSubscriber(ObjectType::Page, 251, 'OnBeforeActionEvent', "P&ost", false, false)]
    local procedure levtOnBeforeActionEventPost(var Rec: Record "Gen. Journal Batch")
    begin
        gfcnConfirmReadyToPost(Rec);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-B.Post", Rec);
    end;

    [EventSubscriber(ObjectType::Page, 251, 'OnBeforeActionEvent', "Post and &Print", false, false)]
    local procedure levtOnBeforeActionEventPostAndPrint(var Rec: Record "Gen. Journal Batch")
    begin
        gfcnConfirmReadyToPost(Rec);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-B.Post+Print", Rec);
    end;

    //[Scope('Internal')]
    procedure gfcnConfirmReadyToPost(var precGenJournalBatch: Record "Gen. Journal Batch")
    var
        lrecGenJournalTemplate: Record "Gen. Journal Template";
    begin
        with precGenJournalBatch do begin
            lrecGenJournalTemplate.Get("Journal Template Name");
            if lrecGenJournalTemplate."Use Ready to Post" then
                lrecGenJournalTemplate.FieldError("Use Ready to Post", txt60001);

            SetRange("Reverse TB to TB", true);
            if FindFirst then
                FieldError("Reverse TB to TB", txt60001);
            SetRange("Reverse TB to TB");
        end;
    end;
}

