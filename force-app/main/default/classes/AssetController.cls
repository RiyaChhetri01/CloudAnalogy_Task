public with sharing class AssetController {

   @AuraEnabled(cacheable=true)
	public static List<Asset> getProductAssets() {
   		 return [ SELECT Id, Name,Status,Warranty_End_Date__c FROM Asset WHERE RecordType.DeveloperName = 'Product' ];
}
	@AuraEnabled(cacheable=true)
	public static List<Asset> getServiceAssets() {
 		   return [ SELECT Id, Name,Status,Warranty_End_Date__c FROM Asset  WHERE RecordType.DeveloperName = 'Service' ];
}
    @AuraEnabled
	public static void updateWarranty(Id assetId, Date newDate) {
    		Asset a = [SELECT Id, Warranty_End_Date__c FROM Asset WHERE Id = :assetId];
    		a.Warranty_End_Date__c = newDate;
   		 update a;
}
  
    @AuraEnabled
    public static Map<String, String> createCaseFromAsset( Id assetId, String subject, String status, String description) {
        try{ Asset a = [SELECT Id, Name, AccountId  FROM Asset  WHERE Id = :assetId LIMIT 1];

        Case c = new Case();

        c.AssetId = a.Id;
        c.AccountId = a.AccountId;
		 c.Subject = subject;
       

     
        if (String.isBlank(status)) {
            c.Status = 'New';
        } else {
            c.Status = status;
        }

        c.Description = description;
        c.Origin = 'Web';

        insert c;
        c = [SELECT Id, CaseNumber FROM Case WHERE Id = :c.Id];

        return new Map<String, String>{
        'caseId' => c.Id,
        'caseNumber' => c.CaseNumber
    };}
        catch (Exception e) {
        throw new AuraHandledException('Error creating case: ' + e.getMessage());
    }
       
    }
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases() {


        try{
            Id userId = UserInfo.getUserId();

        User u = [ SELECT Id, Contact.AccountId FROM User WHERE Id = :userId  LIMIT 1  ];

        if (u.Contact.AccountId != null) {

            return [ SELECT Id, CaseNumber,  Subject,Status, CreatedDate, LastModifiedDate, Priority FROM Case WHERE AccountId = :u.Contact.AccountId ORDER BY CreatedDate DESC ];
        }

        
        return [SELECT Id,CaseNumber, Subject, Status,CreatedDate,Priority FROM Case ORDER BY CreatedDate DESC ];
    }
        catch (Exception e) {
        throw new AuraHandledException('Error fetching cases: ' + e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
	public static Case getCaseDetails(String caseNumber) {
    	return [
        	SELECT Id, CaseNumber, Subject, Status, Description, CreatedDate FROM Case  WHERE CaseNumber = :caseNumber  LIMIT 1 ];
}
    @AuraEnabled
	public static Case escalateCase(Id caseId) {

    Case c = [ SELECT Id, CaseNumber, Subject, Status, Priority,  CreatedDate, LastModifiedDate  FROM Case  WHERE Id = :caseId LIMIT 1 ];

    if (c.Priority == 'Low') {
        c.Priority = 'Medium';
    }
    else if (c.Priority == 'Medium') {
        c.Priority = 'High';
    }
    

    update c;

    
    return [ SELECT Id, CaseNumber, Subject, Status, Priority,  CreatedDate, LastModifiedDate  FROM Case WHERE Id = :caseId ];
}
    public static void sendEscalationEmail(Id caseId) {
    Case c = [SELECT CaseNumber, Subject FROM Case WHERE Id = :caseId];

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(new String[] {});
    mail.setSubject('Case Escalated to High Priority');
    mail.setPlainTextBody('Case ' + c.CaseNumber + ' is now HIGH priority.');

    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}



}