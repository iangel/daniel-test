public class NS_CustomerSummaryData implements NS_WebService{
/*TYES_getCustomerSummary_Action*/
 public final Static String ACTION = 'http://tempuri.org/ISalesForceDataService/GetCustomerSummary';
/*Send invocation for callout*/    
public  String invokeCallout(NS_IntegParams datum){     
        String endpoint = NS_IntegrationUtility_Tyes.TYES_ENDPOINT; 
        String body = NS_WsRequestBodyFactory.getCustomerSummaryReqBody(datum.getUserId(), datum.getClassCode(), datum.getstationCode());
        body =NS_IntegrationUtility_Tyes.prepareSignedBody(body);                
        return parseResponse(NS_WSCallout.sendRequest(endpoint, NS_IntegrationUtility.POST_METHOD,
                                         NS_IntegrationUtility.CONTENT_TYPE, ACTION, body));
     }

     private  String parseResponse(String res){                   
        Dom.Document docForResponse = new dom.Document();
        docForResponse.load(res);
        Dom.XmlNode res_envelope = docForResponse.getRootElement();
        Dom.XmlNode bodyElement = res_envelope.getChildElement(NS_StaticVariablesUtility.Body, NS_StaticVariablesUtility.soapNS);
        Dom.XmlNode CustomerSummaryResponseElement = bodyElement.getChildElement(NS_StaticVariablesUtility.GetCustomerSummaryResponse, NS_StaticVariablesUtility.tem);
        Dom.XmlNode GetCustomerSummaryResultElement = CustomerSummaryResponseElement.getChildElement(NS_StaticVariablesUtility.GetCustomerSummaryResult, NS_StaticVariablesUtility.tem);
        Dom.XmlNode StatusElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.Tyes_Status, NS_StaticVariablesUtility.tyes);
        Dom.XmlNode CodeElement = StatusElement.getChildElement(NS_StaticVariablesUtility.Code, NS_StaticVariablesUtility.b);
        
        NS_GCS.GCSWrapper gcsData = new NS_GCS.GCSWrapper();
        if(CodeElement.getText() == '0'){    
            List<NS_GCS.EquipmentSummary> eSummaryList = new List<NS_GCS.EquipmentSummary>();
            List<String> EquipSumList;
            Dom.XmlNode GetEquipmentSummaryElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.EquipmentSummary, NS_StaticVariablesUtility.SucessURI); 
            for(Dom.XmlNode GetChildren : GetEquipmentSummaryElement.getChildren()){
                EquipSumList= new List<String>();
                for(Dom.XmlNode GetChildreninfo : GetChildren.getChildren()){
                    EquipSumList.add(GetChildreninfo.getText());    
                }
                NS_GCS.EquipmentSummary es = new NS_GCS.EquipmentSummary(GetChildren.getName(),EquipSumList[0],EquipSumList[1],EquipSumList[2],EquipSumList[3],EquipSumList[4]);
                eSummaryList.add(es);              
            }
            gcsData.EquipmentElement = eSummaryList;
            
            
            /*Service Window*/            
            Dom.XmlNode GetScheduleElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.Schedule, NS_StaticVariablesUtility.SucessURI);
            List<NS_GCS.CustomerSummarySchedule> cssList = new List<NS_GCS.CustomerSummarySchedule>();
            for(Dom.XmlNode GetSummaryScheduleChildren : GetScheduleElement.getChildren()){
                List<String> scheduleDataList = new List<String>();
                for(Dom.XmlNode SubChild : GetSummaryScheduleChildren.getChildren()){
                    scheduleDataList.add(SubChild.getText());   
                }
                NS_GCS.CustomerSummarySchedule css = new NS_GCS.CustomerSummarySchedule(scheduleDataList[0],scheduleDataList[1],scheduleDataList[2],scheduleDataList[3],scheduleDataList[4]);
                cssList.add(css);
            }
            gcsData.scheduleElement = cssList;
            
            /*Special Instruction*/
            Dom.XmlNode GetSpecialInstructionsElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.SpecialInstructions, NS_StaticVariablesUtility.SucessURI);
            List<String> spclInstList = new List<String>();
            for(Dom.XmlNode GetChildren : GetSpecialInstructionsElement.getChildren()){
                spclInstList.add(GetChildren.getText());                
            }
            NS_GCS.SummaryBullets spcl = new NS_GCS.SummaryBullets(spclInstList[0],spclInstList[1]);
            gcsData.SpecialInstructionElement = spcl;            
            
            /*General Instruction*/
            Dom.XmlNode GetSummaryBulletsElement = GetCustomerSummaryResultElement.getChildElement(NS_StaticVariablesUtility.SummaryBullets, NS_StaticVariablesUtility.SucessURI);
            List<String> genInstList = new List<String>();
            for(Dom.XmlNode GetChildren : GetSummaryBulletsElement.getChildren()){
                genInstList.add(GetChildren.getText());                
            }
            NS_GCS.SummaryBullets sbull = new NS_GCS.SummaryBullets(genInstList[0],genInstList[1]);
            gcsData.GeneralInstructionElement = sbull;
         }
         return  JSON.serialize(gcsData);
    }   
    
}