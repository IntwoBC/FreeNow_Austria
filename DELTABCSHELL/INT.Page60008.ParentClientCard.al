page 60008 "Parent Client Card"
{
    // MP 02-05-14
    // Development taken from Core II
    // Fields "A/R Trans Posting Scenario" and "A/P Trans Posting Scenario" removed, functionality not implemented

    Caption = 'Parent Client Card';
    PageType = Card;
    SourceTable = "Parent Client";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("G/L Detail Level"; Rec."G/L Detail Level")
                {
                }
                field("G/L Account Template Code"; Rec."G/L Account Template Code")
                {
                }
                field("Corporate GL Acc. Templ. Code"; Rec."Corporate GL Acc. Templ. Code")
                {
                }
                field("Trial Balance Template Code"; Rec."Trial Balance Template Code")
                {
                }
                field("G/L Entry Template Code"; Rec."G/L Entry Template Code")
                {
                }
                field("Customer Template Code"; Rec."Customer Template Code")
                {
                }
                field("Vendor Template Code"; Rec."Vendor Template Code")
                {
                }
                field("AR Template Code"; Rec."AR Template Code")
                {
                }
                field("AP Template Code"; Rec."AP Template Code")
                {
                }
                field("Import Logs"; Rec."Import Logs")
                {
                    Editable = false;
                }
                field("Posting Method"; Rec."Posting Method")
                {
                }
            }
            part("Subsidiary Clients"; "Parent Client Subform")
            {
                SubPageLink = "Parent Client No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            separator(Action1000000025)
            {
            }
            action("Import Status")
            {
                Caption = 'Import Status';

                trigger OnAction()
                var
                    lpagImportMonitoringMatrix: Page "Import Monitoring Matrix";
                begin
                    lpagImportMonitoringMatrix.gfncSetParentClientFilter(Rec."No.");
                    lpagImportMonitoringMatrix.RunModal;
                end;
            }
            group(Import)
            {
                Caption = 'Import';
                group("Single Files")
                {
                    Caption = 'Single Files';
                    action("G/L Accounts")
                    {
                        Caption = 'G/L Accounts';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 1, true, '');
                        end;
                    }
                    action("Corporate COA")
                    {
                        Caption = 'Corporate COA';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 2, true, '');
                        end;
                    }
                    action("G/L Transactions")
                    {
                        Caption = 'G/L Transactions';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 4, true, '');
                        end;
                    }
                    action("G/L Trial Balance")
                    {
                        Caption = 'G/L Trial Balance';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 3, true, '');
                        end;
                    }
                    action(Vendors)
                    {
                        Caption = 'Vendors';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 6, true, '');
                        end;
                    }
                    action("AP Transactions")
                    {
                        Caption = 'AP Transactions';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 8, true, '');
                        end;
                    }
                    action(Customers)
                    {
                        Caption = 'Customers';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 5, true, '');
                        end;
                    }
                    action("AR Transactions")
                    {
                        Caption = 'AR Transactions';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncEndToEndProcess(Rec, 7, true, '');
                        end;
                    }
                }
                group("Combined File")
                {
                    Caption = 'Combined File';
                    action("Statutory Standardization Upload Model (SSUM)")
                    {
                        Caption = 'Statutory Standardization Upload Model (SSUM)';

                        trigger OnAction()
                        begin
                            gmodDataImportManagementGlobal.gfncSSBImports(Rec, true, '', false);
                        end;
                    }
                }
            }
        }
    }

    var
        gmodDataImportManagementGlobal: Codeunit "Data Import Management Global";
}

