page 70012 "Data Migration Entries"
{
    // #MyTaxi.W1.CRE.DMIG.001 15/05/2017 CCFR.SDE : MyTaxi - Legacy System Data Migration
    //   Page Creation

    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Data Migration Entries";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SerialNo; Rec.SerialNo)
                {
                }
                field(EntryType; Rec.EntryType)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(AccountNo; Rec.AccountNo)
                {
                }
                field(EntryNo; Rec.EntryNo)
                {
                }
                field(Text; Rec.Text)
                {
                }
                field(AmountEUR; Rec.AmountEUR)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(ProjectNo; Rec.ProjectNo)
                {
                }
                field(ActivityNo; Rec.ActivityNo)
                {
                }
                field(CustomerNo; Rec.CustomerNo)
                {
                }
                field(SupplierNo; Rec.SupplierNo)
                {
                }
                field(InvoiceNo; Rec.InvoiceNo)
                {
                }
                field(SupplierInvoiceNo; Rec.SupplierInvoiceNo)
                {
                }
                field(DueDate; Rec.DueDate)
                {
                }
                field(VATCode; Rec.VATCode)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Unit1No; Rec.Unit1No)
                {
                }
                field(Unit2No; Rec.Unit2No)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Quantity2; Rec.Quantity2)
                {
                }
                field(Processed; Rec.Processed)
                {
                }
                field("Processed On"; Rec."Processed On")
                {
                }
                field("Processed By"; Rec."Processed By")
                {
                }
                field("Error Description 1"; Rec."Error Description 1")
                {
                }
                field("Error Description 2"; Rec."Error Description 2")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("1- Import Data")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    XMLPORT.Run(XMLPORT::"Data Migration Entries");
                    CurrPage.Update;
                end;
            }
            action("2- Process")
            {
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Data Migration Process";
            }
            action("3 - Update Doc Type on Journal")
            {
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Data Migration - Update Doc Ty";
            }
        }
    }
}

