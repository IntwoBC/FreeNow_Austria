pageextension 50164 pageextension50164 extends "Depreciation Book Card"
{
    layout
    {
        addafter("Fiscal Year 365 Days")
        {
            field("Allow Acq. Cost below Zero"; Rec."Allow Acq. Cost below Zero")
            {
                ApplicationArea = all;
            }
        }
    }
}

