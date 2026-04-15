trigger TriggerForLwc on Opportunity (after insert, after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();

    // Safely collect Account IDs from New and Old maps without manual loops
    if (Trigger.newMap != null) {
        // This adds all AccountIds from the new version of Opportunities
        for(Opportunity opp : Trigger.new)
        { 
            if(opp.AccountId != null) accountIds.add(opp.AccountId);
        }
    }
    
    if (Trigger.oldMap != null) {
        // This handles deleted or reparented opportunities
        for(Opportunity opp : Trigger.old) {
            if(opp.AccountId != null) accountIds.add(opp.AccountId); 
        }
    }

    if (!accountIds.isEmpty()) {
        HandlerforLWc.calculateMinMax(accountIds);
    }
}