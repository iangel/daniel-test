/** 
 *  Author : Accenture 
 *  Description : Text constant used in the SaaS App 
 *  Created Date : 05\06\2015
 * 
 *  Version History :
 *  Date              Changes 
 *  05\06\2015        created 
 *
 */

public class SaaSTextConstant 
{
    public static final String CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
  
    public final static String IS_CLONE_URL_PARAM = 'isClone';
    public final static String SCOPE_URL_PARAM = 'scope';
    public final static String RATING_URL_PARAM =    'rating';
    public final static String RETURN_URL_PARAM =    'retURL';
    public final static String VALUE_DELIVERY_ID_URL_PARAM =    'firstParam';
    public final static String VALUE_DELIVERY_OPTIONS_ID_URL_PARAM =    'valueDeliveryOptionsID';
    public final static String CONVERT_QUEST = 'convertQuest';
    public final static String VALUE_DELIVERY_SETUP_ID_URL_PARAM ='valueDeliveryObjID';
    
    public final static String CONVERT_QUEST_ID = 'convertQuestID';
    public final static String DETAIL_URL_PARAM = 'detail';
    public final static String RELEASEID_URL_PARAM = 'releaseid';
    public final static String PARTICIPANTS_ID_URL_PARAM = 'participantsId';
    
    public final static String OPERATION_TYPE_URL_PARAM = 'opptype';
    public final static String REQUEST_ID_URL_PARAM = 'requestid';
    public final static String  EMPTY_STRING =     '';
    public final static String  ISSUE_RISK_SAVE_MSG =      'Risk/Issue is saved.';
    public final static String  NUMERIC_ONE =      '1'; 
    public final Static Integer LIST_VIEW_PAGE_SIZE = 25; 
    public final static String ASCENDING_SORT_ORDER = 'ASC';    
    public final static String DESCENDING_SORT_ORDER = 'DESC';
    public final static String NAME_FIELD_API_NAME = 'Name';  

    public final static String QUESTION ='Question :';
    public final static String NEXT_LINE ='\n';    
    public final static String RESPONSE='Response :'; 
    
    public final static String RELEASE_OBJ_API_NAME ='Release__c'; 
    public final static String REQUEST_OBJ_API_NAME ='Request__c'; 
    public final static String VALUE_DELIVERY_SETUP_OBJ_API_NAME ='Value_Delivery_Setup__c'; 
    public final static String VALUE_DELIVERY_SESSION_OUTCOME_OBJ_API_NAME= 'Value_Delivery_Session_Outcomes__c';
    
    
    public final static String VALUE_DELIVERY_OPTION_OBJ_API_NAME ='Value_Delivery_Objectives_Options__c'; 
    
    public final static String ISSUE_RISK_OBJ_API_NAME= 'Issues_Risks__c';
    public final static String QUESTION_OBJ_API_NAME= 'Question_Log__c';
    public final static String KEY_ACTION_DECISION_OBJ_API_NAME= 'Key_Action_Decision__c';
    public final static String USER_STORIES_OBJ_API_NAME='User_Story__c';
    public final static String NONE_PICKLIST_VALUE =     '--None--';
    
    //Record Type Developer Name 
    public final static String SAAS_QUESTION_RECORD_TYPE   ='SaaS_Delivery_Question_Log';
    public final static String VALUE_DELIVERY_QUESTION_RECORD_TYPE   = 'Value_Delivery_Question_Log';
    
    public final static String KEY_DECISION_RECORD_TYPE   = 'Key_Decision';
    public final static String VALUE_DELIVERY_SETUP_OVERVIEW_RECORD_TYPE =  'Overview';
    public final static String VALUE_DELIVERY_OPTIONS_OVERVIEW_RECORD_TYPE =  'Overview';
     public final static String VALUE_DELIVERY_SETUP_KEY_PARTICIPANTS_RECORD_TYPE =  'Key_Participants';
   

    public final static String RELEASE_RECORD_SAVE_MSG ='Release is saved.';
    public final static String RATING_SAVE_MSG ='Your Rating is saved.';
    public final static String REQUEST_RECORD_SAVE_MSG ='Request is saved.';
    public final static String QUESTION_RESPONSE_RECORD_SAVE_MSG ='Question and Response is Saved';
    public final static String SELECT_STATUS_ERR_MSG ='Please Select the Status';
    public final static String REQUEST_DESCRIPTION_ERR_MSG ='Request Description cannot be blank.';
    public final static String SELECT_REQUEST_TYPE_ERR_MSG = 'Please Select the Request Type';
   
    
    public final static String RELEASE_NAME_NULL_ERR_MSG ='Please enter Release Name';
    public final static String EXCEPTION_ERR_MSG ='Unknown error occurred. Please contact your System Administrator';
    public final static String CLONE_SELECT_ONE_RECORD_ERR_MSG = 'Please select at least one record to clone.';
    public final static String CLONE_MULTIPLE_SELECT_ERR_MSG ='Please select one record to clone.';
    
    public final static String EDIT_MULTIPLE_SELECT_ERR_MSG ='Please select one record to edit.';
    public final static String EDIT_SELECT_ONE_RECORD_ERR_MSG ='Please select at least one record to edit.';
    
    public final static String DELETE_SELECT_ONE_RECORD_ERR_MSG ='Please select a record to delete.';
    public final static String DELETE_SELECT_ONE_RECORD_SAVE_MSG ='Selected records are deleted.';   
    
    
    public final static String COMMENT_SELECT_ONE_RECORD_ERR_MSG = 'Please select at least one record to comment.';
    public final static String COMMENT_MULTIPLE_SELECT_ERR_MSG ='Please select one record to comment.';
    
    public final static String LINK_TO_REQ_SELECT_ONE_RECORD_ERR_MSG = 'Please select at least one record to link the Question.';
   
    public final static String LINK_TO_REQ_MULTIPLE_SELECT_ERR_MSG ='Please select one record to link the Question.';
   
   
    public final static String CONVERT_QUEST_SELECT_ONE_RECORD_ERR_MSG = 'Please select at least one record to convert.';
    public final static String CONVERT_QUEST_MULTIPLE_SELECT_ERR_MSG ='Please select one record to convert.';
    
    public  final static String  QUESTION_SCOPE_EMPTY_ERR_MSG ='Scope cannot be blank.';
    public  final static String  QUESTION_SUB_CAPABILITY_EMPTY_ERR_MSG ='Sub-Capability cannot be blank.';
    public  final static String  QUESTION_INDUSTRY_EMPTY_ERR_MSG ='Industry cannot be blank.';
    public  final static String  QUESTION_DOMAIN_EMPTY_ERR_MSG ='Domain cannot be blank.';
    public  final static String  QUESTION_FIELD_EMPTY_ERR_MSG ='Question cannot be blank.';
    public final static String QUESTION_RECORD_TYPE_ERROR_MSG ='Please Select Question type.';
    public final static String QUESTION_SAVED_MSG ='Question is saved.';
    public final static String QUESTION_SUBMITTER_EMPTY_ERR_MSG ='Please Select the Submitter';
    public final static String QUESTION_REQUEST_EMPTY_ERR_MSG ='Please Select the Request';
    

     public final static String SESSION_RECORD_SAVE_MSG ='Session is saved.';
     
    public final static String SESSION_NAME_NULL_ERR_MSG ='Please enter Session Name';
    public final static String SESSION_PHASE_NULL_ERR_MSG ='Please select the Phase';
    
     
    public final static String KEY_ACTION_SAVE_MSG =    'Key Action/Decision is saved.';
    
    public final static String KEY_ACTION_NAME_ERROR_MSG =  'Please Enter the Key Action/Decision Name';
    public final static String KEY_ACTION_STATUS_ERROR_MSG =  'Please Select the Status';
    public final static String KEY_ACTION_PRIORITY_ERR_MSG =  'Please Select the Priority';
    public final static String KEY_ACTION_DUE_DATE_ERR_MSG =   'Please Enter the Due Date';
    public final static String KEY_ACTION_DESCRIPTION_ERR_MSG =   'Please Enter the Description';
    public final static String KEY_ACTION_OPTION_ERR_MSG =   'Please Enter the Option';
    public final static String KEY_ACTION_RELATED_RELEASE_ERR_MSG ='Please Select the Release';
    
     public final static String USER_STORIES_SAVE_MSG =    'User Story is saved.';
    
    public final static String ISSUE_STATUS_EMPTY_ERR_MSG ='Please Enter the Status';
    public final static String ISSUE_PRIORITY_EMPTY_ERR_MSG ='Please Select the Priority';
    public final static String ISSUE_DESC_EMPTY_ERR_MSG = 'Please Write the Description';
    public final static String ISSUE_TARGET_RESOLUTION_DATE_ERR_MSG ='Please Enter the Target Resolution Date';
    
    public final static String REQUEST_STATUS_EMPTY_ERR_MSG ='Please Select the Status';
    public final static String REQUEST_DESC_EMPTY_ERR_MSG = 'Please Enter Request Description';
    public final static String REQUEST_TYPE_EMPTY_ERR_MSG =  'Please Select the Request Type';
    public final static String REQUEST_REQUEST_TITLE_ERR_MSG = 'Please Enter Request Title';
    public final static String REQUEST_PLANNED_RELEASE_EMPTY_ERR_MSG = 'Please Select the Planned Release';
    public final static String UPDATE_YOUR_RESPONSE_ERR_MSG = 'You cannot rate your own answer.';


    public final static String LINK_TO_REQ_NO_RECORDS_ERR_MSG = 'No Records found to link.';
    public final static String LINK_TO_REQ_RECORDS_RECORDS_INSERT_MSG = 'Question is linked to the Request.';
         
    public final static String QUST_RESPONSE_SAVE_MSG ='Your response is saved.';
    
    //VF page Name;
    public final static String CREATE_RELEASE_VF_PAGE_NAME_URL ='/apex/SaaSCreateRelease';
    public final static String CREATE_REQUEST_VF_PAGE_NAME_URL ='/apex/SaaSCreateRequest';
    public final static String CREATE_QUESTION_RESP_VF_PAGE_NAME_URL = '/apex/SaaSCreateQuestionLog';
    public final static String Link_To_QUESTION_VF_PAGE_NAME_URL = '/apex/SaaSLinkToQuestion';
    public final static String CREATE_QUESTION_VF_PAGE_NAME_URL = '/apex/SaaSCreateQuestionLog';
    public final static String CREATE_RISK_ISSUE_VF_PAGE_NAME_URL = '/apex/SaaSCreateIssueRiskPage';
    public final static String CREATE_KEY_DECISION_VF_PAGE_NAME_URL =  '/apex/SaaSCreateKeyDecisionOrAction';
    public final static String CREATE_USER_STORIES_VF_PAGE_NAME_URL =  '/apex/SaaSCreateUserStories';
    public final static String QUEST_SEARCH_VF_PAGE_NAME_URL =  '/apex/SaaSClientQuestionSearch';
    
    public final static String VALUE_DELIVERY_APPROACH_VF_PAGE_NAME_URL = '/apex/CrpiHomePage';
    public final static String SESSION_OUTCOME_DETAIL_VF_PAGE_NAME_URL = '/apex/SaaSSessionOutcomeDetail';  
    public final static String VALUE_DELIVERY_TAB_REDIRECT_VF_PAGE_NAME_URL = '/apex/SaaSTabRediect';  

    public final static String OVERVIEW_COMP_EMPTY_CONTENT_ERR_MSG= 'Please enter Content';
    public final static String OVERVIEW_COMP_EMPTY_TITLE_ERR_MSG= 'Please enter Title';    
    public final static String WHO_COMP_TEAM_TITLE_ERR_MSG= 'Please enter Team Name.';    
    
    public final static String PARTICIPANTS_ROLE_BLANK_ERR_MSG= 'Please enter role.';    
    public final static String PARTICIPANTS_NAME_BLANK_ERR_MSG= 'Please enter name.';  
    
    public final static String CHANGE_PROJECT_NAME_ERR_MSG= 'Please select Project Name';
    public final static String CHANGE_SESSION_ERR_MSG= 'Please select Session';     
    public final static String NEW_LINE_REG_EX= '[\n\r]';  
    public final static String SESSION_NAME_EMPTY_ERR_MSG = 'Please enter session name'; 
    public final static String SESSION_PHASE_EMPTY_ERR_MSG = 'Please select phase';
    
    public final static String KEY_PARTICIPANTS_NAME_EMPTY_ERR_MSG = 'Please enter participant name';
    public final static String KEY_PARTICIPANTS_ROLE_EMPTY_ERR_MSG = 'Please enter participant role';  
      
    public final static String BUSSINESS_OPTION_TITLE_EMPTY_ERR_MSG = 'Please enter title.'; 
    public final static String SELECT_THE_SESSION_TYPE = 'Select the session type'; 
    public final static String SELECT_PROJECT_FROM_DROPDOWN ='Select Project from dropdown';
    public final static String SELECT_SESSION_FROM_DROPDOWN ='Select Session from dropdown';
    public final static String PLEASE_CONTACT_SYSTEM_ADMINSTRATOR ='Please contact system adminstrator';
    Public final static string PLEAS_ENTER_SESSION_NAME ='Please enter Session name';
    Public final static string PLEAS_ENTER_PROJECT_NAME ='Please enter project name';

    Public final static string USER_STORY_DESC_BLANK_ERR_MSG='Please enter user story description';
    public final static String USER_STORY_RELATED_RELEASE_ERR_MSG ='Please Select the Release';
    Public final static string USER_STORY_NAME_BLANK_ERR_MSG='Please enter user story name';    
    
}