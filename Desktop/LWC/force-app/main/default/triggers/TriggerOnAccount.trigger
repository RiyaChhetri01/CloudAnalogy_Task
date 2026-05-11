trigger TriggerOnAccount on Account (after insert,after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
            HandlerClass.AccountContactUpdate(Trigger.new,Trigger.oldMap);
    }

}