tableextension 50111 tableextension50111 extends "Incoming Document Attachment"
{

    //Unsupported feature: Code Modification on "UpdateIncomingDocumentHeaderFields(PROCEDURE 11)".

    //procedure UpdateIncomingDocumentHeaderFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Type <> Type::XML then
      exit;
    TempBlob.Init;
    OnGetBinaryContent(TempBlob);
    if not TempBlob.Blob.HasValue then
      TempBlob.Blob := Content;
    TempBlob.Blob.CreateInStream(InStream);
    if not XMLDOMManagement.LoadXMLNodeFromInStream(InStream,XMLRootNode) then
      exit;
    if not IncomingDocument.Get("Incoming Document Entry No.") then
      exit;
    ExtractHeaderFields(XMLRootNode,IncomingDocument);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    if not XMLDOMManagement.LoadXMLDocumentFromInStream(InStream,XMLRootNode) then
    #9..12
    */
    //end;
}

