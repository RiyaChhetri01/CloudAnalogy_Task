public class HandlerClassForBs {
    public static void AccountUpdate(List<Opportunity> opList) {
        Set<Id> accIds = new Set<Id>();
        
        for (Opportunity opp : opList) {//getting each opportuniyt
            if (opp.AccountId != null) {
                accIds.add(opp.AccountId);
            }
        }

        if (accIds.isEmpty()) return;//if empty then return 

     
        Map<Id, Decimal> oppMap = new Map<Id, Decimal>();   // 1. map for opportunity amount
        for (AggregateResult agr : [SELECT AccountId, SUM(Amount) total from Opportunity where AccountId IN :accIds Group By AccountId]) {
            oppMap.put((Id)agr.get('AccountId'), (Decimal)agr.get('total'));//running aggregate
        }

   
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();     // 2. Map for contact count
        for (AggregateResult agr : [SELECT AccountId, COUNT(Id) totalContacts from Contact Where AccountId IN :accIds Group BY AccountId]) {
            contactCountMap.put((Id)agr.get('AccountId'), (Integer)agr.get('totalContacts'));//running aggregate
        }

        List<Account> accToUpdate = new List<Account>();
        for (Id accId : accIds) {
            Decimal totalAmount = oppMap.containsKey(accId) ? oppMap.get(accId) : 0;//getting amount
            Integer totalContacts = contactCountMap.containsKey(accId) ? contactCountMap.get(accId) : 0;
            
        
            if (totalAmount >= 100 && totalContacts > 2) {//both condition checking is done here
                accToUpdate.add(new Account(Id = accId, Rating = 'Hot'));
            }    
        }
        
        if (!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
}