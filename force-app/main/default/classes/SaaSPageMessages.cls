/** 
 *  Author : Accenture 
 *  Description : TO display Custom VF page message 
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */
public with sharing class SaaSPageMessages 
{
    public SaaSPageMessages() {
        throw new UnsupportedOperationException('The PageMessages class cannot be instantiated. Maybe you were looking for PageMessages.PageMessage()?');       
    }

    public enum Severity {CONFIRM,INFO,WARN,FATAL,ERROR}

    private static List<PageMessage> StaticMessages {
        get { 
            if(StaticMessages == null) StaticMessages = new List<PageMessage>(); 
            return StaticMessages; 
        }
        private set;
    } 

    public class PageMessage {
        private Map<Severity,String> SeverityStrMap = new Map<Severity,String>{
            Severity.CONFIRM => 'confirm',
            Severity.INFO => 'info',
            Severity.WARN => 'warn',
            Severity.FATAL => 'error',
            Severity.ERROR => 'error'
        };

        public Severity SeverityLevel { get; set; }
        public String SeverityStr { get; set; }
        public String Message { get; set; }

        public PageMessage (Severity theSeverity, String theMessage) {
            this.SeverityLevel = theSeverity;
            this.Message = theMessage;
            this.SeverityStr = SeverityStrMap.get(theSeverity);
        }
    }

    public static void addMessage(PageMessage thePageMessage) {
        StaticMessages.add(thePageMessage);
    }

    public static List<PageMessage> getMessages(){
        return StaticMessages;
    }
}