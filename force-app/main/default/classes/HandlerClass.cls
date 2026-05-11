public class HandlerClass {
    
    // 1. Update Account Name with the name of the highest Opportunity
    public static void UpdatingtheAmouuntNameWithHighestopp(List<Opportunity> oppList) {
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) accIds.add(opp.AccountId);
        }
        
        List<Account> accListToUpdate = new List<Account>();
        // Querying Account with its highest related Opportunity
        for (Account acc : [SELECT Id, Name, (SELECT Name FROM Opportunities WHERE Amount != null ORDER BY Amount DESC LIMIT 1) 
                            FROM Account WHERE Id IN :accIds]) {
            if (!acc.Opportunities.isEmpty()) {
                acc.Name = acc.Opportunities[0].Name;
                accListToUpdate.add(acc);
            }
        }
        if (!accListToUpdate.isEmpty()) update accListToUpdate;
    }

    // 2. Sync Address from Account to related Contacts
    public static void changingTheAddress(List<Account> accList, Map<Id, Account> oldMap) {
        Set<Id> accIds = new Set<Id>();
        for (Account acc : accList) {
            Account oldAcc = oldMap.get(acc.Id);
            if (acc.BillingCity != oldAcc.BillingCity || acc.BillingCountry != oldAcc.BillingCountry || 
                acc.BillingStreet != oldAcc.BillingStreet || acc.BillingPostalCode != oldAcc.BillingPostalCode) {
                accIds.add(acc.Id);
            }
        }
        
        if (accIds.isEmpty()) return;

        List<Contact> contactsToUpdate = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds];
        Map<Id, Account> accMap = new Map<Id, Account>(accList);
        
        for (Contact con : contactsToUpdate) {
            Account parent = accMap.get(con.AccountId);
            con.MailingStreet = parent.BillingStreet;
            con.MailingCity = parent.BillingCity;
            con.MailingCountry = parent.BillingCountry;
            con.MailingPostalCode = parent.BillingPostalCode;
        }
        if (!contactsToUpdate.isEmpty()) update contactsToUpdate;
    }

    // 3. Prevent Duplicate Leads by Name
    public static void preventDuplicate(List<Lead> leadRecs) {
        Set<String> firstNames = new Set<String>();
        Set<String> lastNames = new Set<String>();
        for (Lead ld : leadRecs) {
            firstNames.add(ld.FirstName);
            lastNames.add(ld.LastName);
        }

        Set<String> existingFullNames = new Set<String>();
        for (Lead ld : [SELECT FirstName, LastName FROM Lead WHERE FirstName IN :firstNames AND LastName IN :lastNames]) {
            existingFullNames.add((ld.FirstName + ld.LastName).toLowerCase());
        }

        for (Lead ld : leadRecs) {
            String currentFullName = (ld.FirstName + ld.LastName).toLowerCase();
            if (existingFullNames.contains(currentFullName)) {
                ld.addError('A Lead with this name already exists.');
            }
        }
    }

    // 4. Prevent Opportunity if Amount < 10,000
    public static void stopOpportunity(List<Opportunity> oppList) {
        for (Opportunity opp : oppList) {
            if (opp.Amount < 10000) {
                opp.addError('The Opportunity amount must be at least 10,000.');
            }
        }
    }

    // 5. Count Contacts from Asia (Runs on Account Trigger)
    public static void updatingTheContactField(List<Account> accList) {
        Set<Id> accIds = new Set<Id>();
        for (Account acc : accList) accIds.add(acc.Id);

        // Map to store counts per Account
        Map<Id, Integer> countMap = new Map<Id, Integer>();
        for (AggregateResult ar : [SELECT AccountId, COUNT(Id) total FROM Contact 
                                   WHERE AccountId IN :accIds AND MailingCountry = 'Asia' 
                                   GROUP BY AccountId]) {
            countMap.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
        }

        for (Account acc : accList) {
            acc.Contact_Count_From_Asia__c = countMap.containsKey(acc.Id) ? countMap.get(acc.Id) : 0;
        }
    }

    // 6. Update Total Opp Count on Account via OLI
    public static void total_opp_count(List<OpportunityLineItem> oliList) {
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityLineItem opp:oliList){
            if(opp.OpportunityId!=null){
                oppIds.add(opp.OpportunityId);
            }
        }
        List<Opportunity>oppId=[SELECT ID,AccountId From Opportunity Where Id IN:oppIds and AccountId!=null];
        Set<Id>accId=new Set<Id>();
        for(Opportunity opList:oppId){
            accId.add(opList.AccountId);
        }
        list<Account> accUpdate=new list<Account>();
        List<Account> relatedAccount=[SELECT Id, total_opportunity_count__c from Account Where ID IN :accId];
        for(Account ac: relatedAccount ){
            Decimal countTotal = (ac.total_opportunity_count__c == null)?0:ac.total_opportunity_count__c;
            ac.total_opportunity_count__c= countTotal +1;
            if(ac.total_opportunity_count__c>5){
                accUpdate.add(ac);
            }
        }
            if(!accUpdate.isEmpty()){
                update accUpdate;
            }
        
            
        
    }
    //Update Contact on Account Website fill
    public static void AccountContactUpdate(List<Account> accList){
        Set<Id> accId=new Set<Id>();
        for(Account acc:accList){
            if(acc.Website!=null){
                accId.add(acc.Id);
            }
        }
        if(!accId.isEmpty()){
            List<Contact> cnnList=[Select AccountId,FirstName,LastName,Account.Website From Contact Where AccountId IN:accId];
        
        for(Contact cnn:cnnList){
            String nameCollect=(cnn.FirstName!=null)?cnn.FirstName.substring(0,1):'';
            cnn.Profile__c=cnn.Account.Website + nameCollect+cnn.LastName;
            
            
        }
        if(!cnnList.isEmpty()){
            update cnnList;
        }}
    }
    //AccountUpdateOnOpportunityifamountabove>20
    public static void AccountUpdateOnOpportunity(List<Opportunity>oppList){
        Set<Id>oppId=new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.Amount>2000 && opp.AccountId!=null){
                oppId.add(opp.AccountId);
            }
        }
        if(!oppId.isEmpty()){
            List<Account> acc=[SELECT Id ,is_gold__c from Account Where Id IN:oppId];
            for(Account acList:acc){
                acList.is_gold__c=true;
            }
        update acc;
        }
        
    }


    
    
    
    
    
    
    
    
    
    
}