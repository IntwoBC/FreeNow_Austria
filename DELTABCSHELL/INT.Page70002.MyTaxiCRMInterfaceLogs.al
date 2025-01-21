page 70002 "MyTaxi CRM Interface Logs"
{
    // #MyTaxi.W1.EDD.INT01.001 19/12/2016 CCFR.SDE : MyTaxi CRM Interface
    //   Page Creation

    Caption = 'MyTaxi CRM Interface Logs';
    Editable = false;
    PageType = List;
    SourceTable = "MyTaxi CRM Interface Logs";
    ApplicationArea = all;//SPS
    UsageCategory = Lists;//SPS
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Time; Time)
                {
                }
                field("Interface Code"; Rec."Interface Code")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Table Position"; Rec."Table Position")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field("Reason Description"; Rec."Reason Description")
                {
                }
                field("File Link"; Rec."File Link")
                {
                }
                field("Flow Type"; Rec."Flow Type")
                {
                }
                field("Sent by Email"; Rec."Sent by Email")
                {
                }
                field("Email Date"; Rec."Email Date")
                {
                }
                field("Email Time"; Rec."Email Time")
                {
                }
            }
        }
    }

    actions
    {
    }
}

