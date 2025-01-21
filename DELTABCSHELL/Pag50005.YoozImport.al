page 50005 "Yooz File Import"
{
    ApplicationArea = All;
    Caption = 'Yooz File Import';
    PageType = List;
    UsageCategory = Lists;
    actions
    {
        area(processing)
        {
            action(YoozFileImport)
            {
                ApplicationArea = all;
                Caption = 'Import Yooz File';
                trigger OnAction()
                var
                    YoozFileImport: XmlPort "Yooz File - Import";
                begin
                    YoozFileImport.Run();
                end;
            }
        }
    }
}
