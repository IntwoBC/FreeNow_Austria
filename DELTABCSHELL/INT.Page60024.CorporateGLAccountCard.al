page 60024 "Corporate G/L Account Card"
{
    // MP 19-04-12
    // Added check for mandatory field "Financial Statement Code"
    // 
    // MP 25-09-13
    // Added field "Name (English)"
    // 
    // MP 19-11-13
    // Added support for bottom-up companies, controling visibility of field "Local G/L Account No." (CR 30)
    // 
    // MP 19-02-14
    // Added check for mandatory field "Local G/L Account No." (CR 30)
    // Added field "Local G/L Account Name"
    // 
    // MP 30-04-14
    // Amended mandatory field check, moved to OnInsertRecord trigger and set Page to DelayedInsert
    // 
    // MP 04-12-15
    // Added AssistEdit to Financial Statement Code in order to support historic FS Code (CB1 Enhancements)
    // 
    // MP 22-03-16
    // Added code to table to populate historic FS Codes automatically so now triggers save in "Financial Statement Code" (CB1 CR002)
    // Added FlowField "Fin. Statement Code (Local)"

    Caption = 'Corporate G/L Account Card';
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Corporate G/L Account";
    ApplicationArea = all;//SPS
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
                field("Name (English)"; Rec."Name (English)")
                {
                }
                field("Account Class"; Rec."Account Class")
                {
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    Importance = Promoted;
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Totaling; Rec.Totaling)
                {
                }
                field("No. of Blank Lines"; Rec."No. of Blank Lines")
                {
                }
                field("New Page"; Rec."New Page")
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field(Balance; Rec.Balance)
                {
                    Importance = Promoted;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
            group(Reporting)
            {
                Caption = 'Reporting';
                field("Financial Statement Code"; Rec."Financial Statement Code")
                {
                    Importance = Promoted;
                    NotBlank = true;

                    trigger OnAssistEdit()
                    var
                        lrecHistAccFinStatmtCode: Record "Hist. Acc. Fin. Statmt. Code";
                    begin
                        // MP 22-03-16 >>
                        CurrPage.SaveRecord;
                        Commit;
                        // MP 22-03-16 <<

                        // MP 23-11-15 >>
                        lrecHistAccFinStatmtCode.SetRange("G/L Account Type", lrecHistAccFinStatmtCode."G/L Account Type"::"Corporate G/L Account");
                        lrecHistAccFinStatmtCode.SetRange("G/L Account No.", Rec."No.");
                        PAGE.RunModal(0, lrecHistAccFinStatmtCode);
                        // MP 23-11-15 <<
                    end;
                }
                field("Fin. Statement Code (Local)"; Rec."Fin. Statement Code (Local)")
                {
                    Editable = true;
                    ValuesAllowed = 'NOT EDITABLE';

                    trigger OnAssistEdit()
                    var
                        lrecHistAccFinStatmtCode: Record "Hist. Acc. Fin. Statmt. Code";
                        lpagHistAccFinStatmtCodes: Page "Hist. Acc. Fin. Statmt. Codes";
                    begin
                        // MP 31-03-16 >>
                        lrecHistAccFinStatmtCode.SetRange("G/L Account Type", lrecHistAccFinStatmtCode."G/L Account Type"::"G/L Account");
                        lrecHistAccFinStatmtCode.SetRange("G/L Account No.", Rec."Local G/L Account No.");
                        lpagHistAccFinStatmtCodes.Editable(false);
                        lpagHistAccFinStatmtCodes.SetTableView(lrecHistAccFinStatmtCode);
                        lpagHistAccFinStatmtCodes.RunModal;
                        // MP 31-03-16 <<
                    end;
                }
                field("Local G/L Account No."; Rec."Local G/L Account No.")
                {
                    Importance = Promoted;
                    NotBlank = true;
                    Visible = NOT gblnBottomUp;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Local G/L Acc. Name"); // MP 19-02-14
                    end;
                }
                field("Local G/L Acc. Name"; Rec."Local G/L Acc. Name")
                {
                    Visible = NOT gblnBottomUp;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "General Ledger Entries";
                    RunPageLink = "Corporate G/L Account No." = FIELD("No."),
                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter");
                    RunPageView = SORTING("Corporate G/L Account No.", "Global Dimension 1 Code");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = //"Table Name" = CONST ("Corporate G/L Account"),//SPS
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(15),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
            group("&Balance")
            {
                Caption = '&Balance';
                action("G/L &Account Balance")
                {
                    Caption = 'G/L &Account Balance';
                    Image = GLAccountBalance;
                    RunObject = Page "G/L Account Balance";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Business Unit Filter" = FIELD("Business Unit Filter");
                }
                action("G/L &Balance")
                {
                    Caption = 'G/L &Balance';
                    Image = GLBalance;
                    RunObject = Page "G/L Balance";
                    RunPageOnRec = true;
                }
                action("G/L Balance by &Dimension")
                {
                    Caption = 'G/L Balance by &Dimension';
                    Image = GLBalanceDimension;
                    RunObject = Page "G/L Balance by Dimension";
                }
            }
            action("G/L Register")
            {
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "G/L Registers";
            }
        }
        area(reporting)
        {
            action("Detail Trial Balance")
            {
                Caption = 'Detail Trial Balance';
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Corporate Detail Trial Balance";
            }
            action("Trial Balance")
            {
                Caption = 'Trial Balance';
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Corporate Trial Balance";
            }
            action(Action1900210206)
            {
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "G/L Register";
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;

                    trigger OnAction()
                    var
                        TemplateMgt: Codeunit "Config. Template Management";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        TemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        // MP 19-04-12 >>

        gblnOnDelete := true;
        exit(true);

        // MP 19-04-12 <<
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // MP 30-04-14 Moved check up from OnQueryClosePage >>
        if (Rec."Financial Statement Code" = '') and (Rec."No." <> '') and (not gblnOnDelete) then
            Error(txt60000, Rec.FieldCaption(Rec."Financial Statement Code"), Rec.TableCaption, Rec.FieldCaption("No."), Rec."No.")
        else
            if (not gblnBottomUp) and (Rec."Local G/L Account No." = '') and (Rec."No." <> '') and (not gblnOnDelete) then begin
                Error(txt60000, Rec.FieldCaption("Local G/L Account No."), Rec.TableCaption, Rec.FieldCaption("No."), Rec."No.")
            end else
                exit(true);
        // MP 30-04-14 <<
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewGLAcc(xRec, BelowxRec);
    end;

    trigger OnOpenPage()
    var
        lrecEYCoreSetup: Record "EY Core Setup";
    begin
        // MP 19-11-13 >>
        lrecEYCoreSetup.Get;
        gblnBottomUp := lrecEYCoreSetup."Company Type" = lrecEYCoreSetup."Company Type"::"Bottom-up";
        // MP 19-11-13 <<
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // MP 30-04-14 Moved to OnInsertRecord >>
        // MP 19-04-12 >>
        //
        //IF ("Financial Statement Code" = '') AND ("No." <> '') AND (NOT gblnOnDelete) THEN BEGIN
        //  MESSAGE(txt60000,FIELDCAPTION("Financial Statement Code"),TABLECAPTION,FIELDCAPTION("No."),"No.");
        //  EXIT(FALSE);
        //END ELSE
        //  // MP 19-02-14 >>
        //  IF ("Local G/L Account No." = '') AND ("No." <> '') AND (NOT gblnOnDelete) THEN BEGIN
        //    MESSAGE(txt60000,FIELDCAPTION("Local G/L Account No."),TABLECAPTION,FIELDCAPTION("No."),"No.");
        //    EXIT(FALSE);
        //  END ELSE
        //  // MP 19-02-14 <<
        //    EXIT(TRUE);
        //
        //// MP 19-04-12 <<
        // MP 30-04-14 Moved to OnInsertRecord <<
    end;

    var
        gblnOnDelete: Boolean;
        txt60000: Label 'You must specify %1 in %2 %3=%4.';
        [InDataSet]
        gblnBottomUp: Boolean;
}

