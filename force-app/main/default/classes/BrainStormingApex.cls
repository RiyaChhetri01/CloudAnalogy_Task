public class BrainStormingApex {
   @AuraEnabled(cacheable=true)
    public static List<AggregateResult> AccOpp(Id accountId){
       
        List<AggregateResult> opp = [SELECT AccountId, Sum(Amount) totalAmount from Opportunity where AccountId = :accountId  AND AccountId != null  Group By AccountId];
        return opp;
    }
}