pageextension 50211 pageextension50211 extends "Acc. Receivables Adm. RC"
{
    actions
    {
        addafter("C&ustomer")
        {
            action("<Report Create Reminders>")
            {
                Caption = 'Create Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
                ApplicationArea = all;
            }
            action("<Page Issued Reminders>")
            {
                Caption = 'Issued Reminders';
                Ellipsis = true;
                Image = Archive;
                RunObject = Page "Issued Reminder List";
                ApplicationArea = all;
            }
            action("<Report Statement>")
            {
                Caption = 'Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Codeunit "Customer Layout - Statement";
                ApplicationArea = all;
            }
        }
    }
}

