public class HandlerforLWc {
    @AuraEnabled(cacheable=true)
    public static List<Account> Accountrec(){
        return [Select Id,Name from Account limit 5];
        
        
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> RelatedOpportunities(Id accountId){
        return [SELECT ACCOUNTID,NAME,STAGENAME,AMOUNT FROM  OPPORTUNITY  WHERE ACCOUNTID  =:accountId];
    }
    @AuraEnabled
    public static void updateOpportunities(List<Opportunity> oppList){
        update oppList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(){
        try{
            return [SELECT ID,NAME,STAGENAME,AMOUNT, Account.Name FROM OPPORTUNITY ];
        }
        catch(Exception e){
             System.debug('Error in getOpportunity: ' + e.getMessage());
             return new List<Opportunity>();
        }
       
        
    }
    @AuraEnabled
	public static void deleteOpportunity(Id oppId) {
    try {
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :oppId LIMIT 1];
        delete opp;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}
   
  

    public static void handleTrigger(
        List<Opportunity> newList,
        List<Opportunity> oldList
    ) {
        Set<Id> accountIds = new Set<Id>();

       
        if (newList != null) {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        if (oldList != null) {
            for (Opportunity opp : oldList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        if (!accountIds.isEmpty()) {
            calculateMinMax(accountIds);
        }
    }

    public static void calculateMinMax(Set<Id> accountIds) {

        List<Account> accountsToUpdate = new List<Account>();

        AggregateResult[] results = [
            SELECT AccountId, MIN(Amount) minAmount, MAX(Amount) maxAmount FROM Opportunity WHERE AccountId IN :accountIds GROUP BY AccountId ];

        for (AggregateResult ar : results) {
            accountsToUpdate.add(new Account( Id = (Id) ar.get('AccountId'), Min_Amount__c = (Decimal) ar.get('minAmount'),Max_Amount__c = (Decimal) ar.get('maxAmount') ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    
}
}