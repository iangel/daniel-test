public class SaaSDocumentDownload 
{
    public String docDeveloperName {get;set;}
    
    public String getDocumentID()
    {
        String documentID ='';
        List<Document>  docLst = [Select id from Document where DeveloperName = : docDeveloperName];
        if(docLst.size() > 0)
        {
            documentID  = docLst.get(0).id;     
        }
        return documentID;
    }
}