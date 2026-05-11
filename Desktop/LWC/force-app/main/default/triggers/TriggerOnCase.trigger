trigger TriggerOnCase on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
                 HandlerClass.CaserecordCreation(Trigger.new);
    }

}