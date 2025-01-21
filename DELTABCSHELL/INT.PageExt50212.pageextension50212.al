pageextension 50212 pageextension50212 extends "Assembly Orders"
{
    actions
    {

        //Unsupported feature: Property Modification (Name) on "Release(Action 27)".


        //Unsupported feature: Property Modification (Name) on "Reopen(Action 31)".


        //Unsupported feature: Code Modification on "Release(Action 27).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AssemblyHeader := Rec;
        AssemblyHeader.Find;
        CODEUNIT.Run(CODEUNIT::"Release Assembly Document",AssemblyHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.Run(CODEUNIT::"Release Assembly Document",Rec);
        */
        //end;


        //Unsupported feature: Code Modification on "Reopen(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AssemblyHeader := Rec;
        AssemblyHeader.Find;
        ReleaseAssemblyDoc.Reopen(AssemblyHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReleaseAssemblyDoc.Reopen(Rec);
        */
        //end;
    }
}

