public without sharing class registerUser {

    @AuraEnabled
    public static String initiateRegistration(String firstName, String lastName, String email) {
        try {
           
            Account newAcc = new Account( Name = firstName + ' ' + lastName + ' Account',Is_Pending_Registration__c = true  );
            insert newAcc;

            String otp = String.valueOf(Math.round(Math.random() * 899999) + 100000);
            Contact newCon = new Contact(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                AccountId = newAcc.Id,
                OTP_Code__c = otp,
                OTP_Expiry__c = System.now().addMinutes(15)
            );
            insert newCon;

            sendEmail(email, otp);

            return newCon.Id; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    private static void sendEmail(String targetEmail, String otpCode) {
 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
    mail.setToAddresses(new String[] { targetEmail });
  
    mail.setSubject('Verify Your Account Registration');
    
    
    String body = 'Hello, <br/><br/>' +
                  'Thank you for starting your registration. Your verification code is: <br/>' +
                  '<b><h1>' + otpCode + '</h1></b><br/>';
                  
    mail.setHtmlBody(body);
    
    mail.setSenderDisplayName('Experience Cloud Support');
    

    Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
 
    if (results[0].isSuccess()) {
        System.debug('Email sent successfully to ' + targetEmail);
    } else {
        System.debug('Email failed to send: ' + results[0].getErrors()[0].getMessage());
    }
}

	@AuraEnabled(cacheable=false)
	public static void completeRegistration(Id contactId, String otpInput) {
    // 1. Fetch contact with essential fields
    Contact con = [SELECT Id, FirstName, LastName, Email, AccountId, OTP_Code__c, OTP_Expiry__c 
                   FROM Contact WHERE Id = :contactId LIMIT 1];

    // 2. Validate OTP and Expiry
    if (con.OTP_Code__c != otpInput || con.OTP_Expiry__c < System.now()) {
        throw new AuraHandledException('Invalid or Expired OTP');
    }

    // 3. Prepare the User Record
    User u = new User();
    u.FirstName = con.FirstName;
    u.LastName = con.LastName;
    u.Email = con.Email;
    u.ContactId = con.Id;
    u.Username = con.Email + '.' + System.currentTimeMillis() + '@portal.com'; 
    // Use Math.abs to avoid negative numbers in the nickname
    u.CommunityNickname = con.FirstName + '_' + Math.abs(Crypto.getRandomInteger());
    u.Alias = con.FirstName.length() > 8 ? con.FirstName.substring(0, 8) : con.FirstName;
    u.TimeZoneSidKey = 'GMT';
    u.LocaleSidKey = 'en_US';
    u.EmailEncodingKey = 'UTF-8';
    u.LanguageLocaleKey = 'en_US';
    
    // IMPORTANT: You usually need to query the Profile ID here
     Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community User' LIMIT 1];
     u.ProfileId = p.Id;

    try {
    String userId = Site.createExternalUser(u, con.AccountId, null);

    update new Account(Id = con.AccountId, Is_Pending_Registration__c = false);

    con.OTP_Code__c = null;
    update con;

} catch (Exception e) {
    System.debug('ERROR: ' + e.getMessage());

    AuraHandledException ex = new AuraHandledException(e.getMessage());
    ex.setMessage(e.getMessage());
    throw ex;
}
}}