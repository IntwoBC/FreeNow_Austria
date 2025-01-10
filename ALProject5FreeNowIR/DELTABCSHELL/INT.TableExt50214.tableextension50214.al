tableextension 50214 tableextension50214 extends "Miniform Header"
{

    //Unsupported feature: Code Modification on "LoadXMLin(PROCEDURE 2)".

    //procedure LoadXMLin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    XMLin.CreateOutStream(OutStrm);
    XMLDOMManagement.LoadXMLDocumentFromOutStream(OutStrm,DOMxmlin);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    XMLin.CreateOutStream(OutStrm);
    DOMxmlin.Load(OutStrm);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "LoadXMLin(PROCEDURE 2).XMLDOMManagement(Variable 1002)".

}

