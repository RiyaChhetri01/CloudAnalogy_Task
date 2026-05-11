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
        List<Opportunity> oppList=[SELECT AccountId,Amount From Opportunity 
        Where AccountId IN:accountIds and Amount !=null];

        Map<Id,Decimal>minMap=new Map<Id,Decimal>();
        Map<Id,Decimal>maxMap=new Map<Id,Decimal>();

        for(Opportunity opp:oppList){
            Id accId=opp.AccountId;
            Decimal amt=opp.Amount;
            if(!minMap.containsKey(accId)){
                minMap.put(accId,amt);
                maxMap.put(accId,amt);
            }
            else{
                if(amt<minMap.get(accId)){
                    minMap.put(accId,amt);
                }
                if(amt>maxMap.get(accId)){
                    maxMap.put(accId,amt);
                }
            }
        }
        List<Account> accToUPdate=new List<Account>();
        for(Id accId:minMap.keySet()){
            accToUPdate.add(new Account(
                Id=accId,
                Min_Amount__c=minMap.get(accId),
                Max_Amount__c=maxMap.get(accId)



            ));
        }
        if(!accToUPdate.isEmpty()){
            update accToUPdate;
        }


      
    
}
}