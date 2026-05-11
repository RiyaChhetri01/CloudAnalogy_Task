trigger TriggerForLwc on Opportunity (after insert, after update, after delete, after undelete) {
    
        HandlerforLWc.handleTrigger(Trigger.new,Trigger.old);
    
}