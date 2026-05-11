trigger TriggerOnLead on Lead (before insert) {
    if(Trigger.isBefore||Trigger.isInsert){
        HandlerClass.LeadSource(Trigger.new);
    }

}