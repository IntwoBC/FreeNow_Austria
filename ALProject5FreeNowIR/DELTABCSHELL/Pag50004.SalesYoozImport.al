page 50004 "Sales Yooz File Import"
{
    ApplicationArea = All;
    Caption = 'Sales Yooz File Import';
    PageType = List;
    UsageCategory = Lists;

    actions
    {
        area(processing)
        {
            action(SalesYoozFileImport)
            {
                ApplicationArea = all;
                Caption = 'Import Sales Yooz File';

                trigger OnAction()
                var
                    YoozFileImport: XmlPort "Sales - Yooz File - Import";
                begin
                    YoozFileImport.Run();
                end;
            }
        }
    }
}
