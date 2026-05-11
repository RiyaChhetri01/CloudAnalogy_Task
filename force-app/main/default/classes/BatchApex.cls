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
    
}