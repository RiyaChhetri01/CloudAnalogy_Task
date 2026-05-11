<<<<<<< HEAD
public class BatchApex implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT ID,Name ,Rating FROM ACCOUNT');
        
    }
    public void execute(Database.BatchableContext BC,List<Account> scope)
    {
        for(Account acc:scope){
            acc.Rating='Hot';
        }
        update scope;
    }
    public void finish(Database.BatchableContext BC){
        system.debug('task completed');
    }
    
=======
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
    

>>>>>>> 6972eb78d6eba22a5bfc69ab4e862aa85c1e1971
}