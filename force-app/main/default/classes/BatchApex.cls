public class BatchApex implements Database.Batchable<sObject>, Database.stateful{
    public integer readCounter=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT ID,NAME FROM OPPORTUNITY]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity>opp){
        for(Opportunity op:opp){
            op.LeadSource='Web';
        }
        update opp;
        readCounter +=opp.size();
        
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('total record fetched'+readCounter);
    }
    

}