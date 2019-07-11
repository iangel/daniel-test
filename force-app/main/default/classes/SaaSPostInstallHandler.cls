/** 
 *  Author : Accenture 
 *  Description : Controller class for SaaSPostInstallHandler. Once SaaS Delivery toolKit is Installed we need to setupup  value delivery app Data.
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\10\2015        created 
 *
 */ 
global without sharing class SaaSPostInstallHandler implements InstallHandler 
{
    
    global void onInstall(InstallContext context)    
    {
        if(context.previousVersion() == null) 
        {
            createSetupOverview();
        }            
    }


    public void createSetupOverview()
    {
        try
        {
            Release__c releaseObj = null;
            Value_Delivery_Session__c valSessObj = null;
            Value_Delivery_Setup__c  bussObj = null;
            Integer sequenceNo = 0;
            List<Value_Delivery_Objectives_Options__c> bussOptionLst = new List<Value_Delivery_Objectives_Options__c>();
            List<String> optionLst = new List<String>();
            // Check if package has installed for the first time .
            
                releaseObj  = createRelease();       
                insert releaseObj;
                valSessObj  =   createValueDeliverySession(releaseObj);
                insert valSessObj;
                
                //Create Bussiness Objective for Initiate And Confirm                   
                bussObj = createBusinessObjective(valSessObj,'Objectives','Initiate And Confirm',sequenceNo );
                insert bussObj; 
                optionLst.add('Align on expected benefits and value drivers of the capability');
                optionLst.add('Define in scope / out of scope boundaries');
                optionLst.add('Identify structure and resource team');
                optionLst.add('Identify key stakeholders');            
                optionLst.add('Identify big-rocks');
                optionLst.add('Finalize standardized inputs for Scope VALUE Delivery Approach');                
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Key Participants','Initiate And Confirm',sequenceNo );
                insert bussObj; 
                optionLst.add('Global Capability Lead');
                optionLst.add('Business Unit Leads');
                optionLst.add('VALUE Delivery Approach Lead');
                optionLst.add('Process Analyst');            
                optionLst.add('Business Analyst');
                optionLst.add('SME Advisors');                
                optionLst.add('Data & Integration SMEs');                
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Inputs','Initiate And Confirm',sequenceNo );
                insert bussObj; 
                optionLst.add('Strategic direction / vision for change');
                optionLst.add('Program value proposition and guiding principles');
                optionLst.add('Capability roadmap / process areas defined for release');
                optionLst.add('Leading practice and research');                                         
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                bussObj = createBusinessObjective(valSessObj,'Outputs','Initiate And Confirm',sequenceNo );
                insert bussObj; 
                optionLst.add('Capability definition');
                optionLst.add('Value proposition and impacted value drivers');
                optionLst.add('E2E process flow');
                optionLst.add('Resources allocated to team and key stakeholder list');            
                optionLst.add('Big rocks / strategic policy decisions / transformations (i.e. long-lead time items)');
                optionLst.add('D&I requirements, cross-VALUE Delivery Approach dependencies, and operational impacts (preliminary)');                
                optionLst.add('Inventory of draft user stories and requirements (~75% complete), with initial prioritization'); 
                optionLst.add('Early sizing, if available');                                
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                
                sequenceNo++;bussObj = createBusinessObjective(valSessObj,'Session Outcomes','Initiate And Confirm',sequenceNo );
                insert bussObj; 
                optionLst.add('Understand Salesforce.com out of the box capabilities through live demonstrations');
                optionLst.add('Understand business objectives by capability');
                optionLst.add('Review Business Processes and Use Cases against live Salesforce.com application');
                optionLst.add('Consider requirement effort against technology trade offs');            
                optionLst.add('Confirm scope - Requirements, Interfaces, Conversions, Enhancements, Workflows');                             
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                
                //Create Records for the Design Phase
                sequenceNo = 0 ;

                bussObj = createBusinessObjective(valSessObj,'Objectives','Design',sequenceNo );
                insert bussObj; 
                optionLst.add('Demonstrate user stories build and requirements');
                optionLst.add('Confirm design where options are available');
                optionLst.add('Validate estimates and performance tradeoffs are necessary');
                optionLst.add('Create initial designs in development sandbox where possible');            
                optionLst.add('Confirm data model for integrations');                       
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Key Participants','Design',sequenceNo );
                insert bussObj; 
                optionLst.add('Global Capability Lead');
                optionLst.add('Business Unit Leads');
                optionLst.add('VALUE Delivery Approach Lead');
                optionLst.add('Process Analyst');            
                optionLst.add('Business Analyst');
                optionLst.add('SME Advisors');           
                optionLst.add('Technology/Development Team');     
                optionLst.add('Data & Integration SMEs');                
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Inputs','Design',sequenceNo );
                insert bussObj; 
                optionLst.add('Value proposition and impacted value drivers');
                optionLst.add('Development sandbox with prototype or existing build');
                optionLst.add('End to End Business Requirements and User Stories in scope');
                optionLst.add('Estimates and Assumptions for in-scope user stories and requirements');                                         
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                bussObj = createBusinessObjective(valSessObj,'Outputs','Design',sequenceNo );
                insert bussObj; 
                optionLst.add('Confirmation of designs for all in-scope user stories');
                optionLst.add('Tradeoffs confirmed where estimates have increased or decreased due to design decisions');
                                              
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                
                sequenceNo++;bussObj = createBusinessObjective(valSessObj,'Session Outcomes','Design',sequenceNo );
                insert bussObj; 
                optionLst.add('Review and lock requirements and scope');
                optionLst.add('Review configured application design against business process enhancements. Take feedback and make real-time design changes.');
                optionLst.add('Review full capability design in the application. Take feedback and make real-time design changes.');
                optionLst.add('End-to-end walkthrough');            
                optionLst.add('Sign off on Design');                             
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
               
                //Create Records for the Build Phase
                sequenceNo = 0 ;

                bussObj = createBusinessObjective(valSessObj,'Objectives','Build',sequenceNo );
                insert bussObj; 
                optionLst.add('Demonstrate user stories build and requirements');
                optionLst.add('Confirm build with Business Group Voters');
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Key Participants','Build',sequenceNo );
                insert bussObj; 
                optionLst.add('Global Capability Lead');
                optionLst.add('Business Unit Leads');
                optionLst.add('VALUE Delivery Approach Lead');
                optionLst.add('Process Analyst');            
                optionLst.add('Business Analyst');
                optionLst.add('SME Advisors');           
                optionLst.add('Technology/Development Team');     
                optionLst.add('Data & Integration SMEs');                
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                
                bussObj = createBusinessObjective(valSessObj,'Inputs','Build',sequenceNo );
                insert bussObj; 
                optionLst.add('Development sandbox with prototype or existing build');
                optionLst.add('End to End Business Requirements and User Stories in-scope');
                optionLst.add('Estimates and assumptions of in-scope user stories and requirements');
                optionLst.add('Confirmed design recommendations for user stories and requirements');                                         
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                sequenceNo++;
                bussObj = createBusinessObjective(valSessObj,'Outputs','Build',sequenceNo );
                insert bussObj; 
                optionLst.add('Confirmation of build for all in-scope user stories');
                optionLst.add('Tradeoffs confirmed where estimates have increased or decreased due to build decisions');
                                              
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();
                
                sequenceNo++;bussObj = createBusinessObjective(valSessObj,'Session Outcomes','Build',sequenceNo );
                insert bussObj; 
                optionLst.add('Review configured and near-working application');
                optionLst.add('Identify any interative development changes that can be observed and shall be completed');
                optionLst.add('Review full capability design in the application. Take feedback and make real-time design changes.');
                optionLst.add('End-to-end walkthrough');            
                optionLst.add('Sign off on Build');                             
                bussOptionLst.addAll(createBusinessOpt(optionLst,bussObj)); 
                optionLst.clear();


                // Insert All Business options
                insert bussOptionLst;             
        }
        catch(Exception e)
        {
            System.debug('Error While creating VALUE Delivery Session Template records' + e.getMessage());
        }            
    }
    
   /**
    * 
    * Create Release record 
    * 
    */
    
    private Release__c createRelease()
    {
        Release__c releaseObj  = new Release__c();
        releaseObj.name = 'VALUE Delivery Session Template';   
        releaseObj.Description__c = 'This is used for the as VALUE Delivery Session Template should not be deleted.'; 
        return  releaseObj;  
    }
   /**
    * 
    * Create VALUE Delivery Session Template Session Records 
    * 
    */   
    private Value_Delivery_Session__c  createValueDeliverySession( Release__c releaseObj)
    {
        Value_Delivery_Session__c valSessObj = new Value_Delivery_Session__c();
        valSessObj.name=  'VALUE Delivery Session Template';
        valSessObj.Description__c = 'This is used for the as VALUE Delivery Session Template should not be deleted.'; 
        valSessObj.Releases__c = releaseObj.id;
        return valSessObj ;
    }
    
   /**
    *  Create Business Objective 
    *
    */
    private Value_Delivery_Setup__c  createBusinessObjective(Value_Delivery_Session__c  valSessObj,String title,String phase,Integer sequence)
    {
        Value_Delivery_Setup__c   bussObj  = new Value_Delivery_Setup__c();
        bussObj.name = 'Anatomy';
        bussObj.Component_Title__c = title;
        bussObj.Project_Phase__c =phase;
        bussObj.Sequence_Order__c = sequence;
        bussObj.Value_Delivery_Session__c = valSessObj.id;  
        return bussObj;
    }
    /**
    *  Create Business Options
    *
    */
    private List<Value_Delivery_Objectives_Options__c> createBusinessOpt(List<String> optionLst, Value_Delivery_Setup__c   bussObj )  
    {
        Integer sequenceNo = 1; 
        List<Value_Delivery_Objectives_Options__c> bussOptionLst = new List<Value_Delivery_Objectives_Options__c>();
        
        for(String str : optionLst)
        {
            Value_Delivery_Objectives_Options__c obj = new Value_Delivery_Objectives_Options__c();
            obj.Objectives_and_Attendees_for_Participant__c = bussObj.id; 
            obj.Option_Description__c = str; 
            obj.Sequence_No__c = sequenceNo; 
            bussOptionLst.add(obj); 
            sequenceNo++; 
        }        
        return bussOptionLst;        
    }    
}