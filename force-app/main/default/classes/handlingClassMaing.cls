public class handlingClassMaing {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(){
        List<Account> acc=[SELECT ID,NAME FROM ACCOUNT limit 5];
        return acc;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAcc(Id accountId){
        List<Contact>ac=[SELECT AccountId,FirstName,LastName ,Phone  FROM Contact Where AccountId  =:accountId];
        RETURN ac;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccOrg(){
        List<Account> acc=[SELECT ID,NAME,INDUSTRY,PHONE FROM ACCOUNT LIMIT 2];
        return acc;
    }
    @AuraEnabled
    public static void makeAcc(String name,String Phone,String Industry,String Website,String Type){
        Account acc=new Account(
            Name=name,
            Phone=Phone,
                Industry=Industry,
                Website=Website,
                Type=Type
            
        );
        insert acc;
        
    }
    @AuraEnabled
    public static List<Account> getAccountforCombobox(){
        List<Account> acc=[SELECT ID,Name from Account];
         return acc;        
    }
    @AuraEnabled
    public static List<Contact> getCon(Id accountId){
        List<Contact> con=[Select AccountId,firstName,LastName,Phone from Contact Where  AccountId =:accountId];
        return con;
    }
    @AuraEnabled
    public static List<Opportunity> AccOpp(Id accountId){
        List<Opportunity> opp=[SELECT AccountId,Name,StageName from Opportunity Where AccountId=:accountId];
        return opp;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountfordatatable(){
        List<Account> AccRec=[Select Id,Name From Account];
        return AccRec;
            
    }
     @AuraEnabled
    public static void DelRec(List<Id> accountId){
        List<Account> del=[Select Id,Name from Account Where Id =:accountId];
        Delete del;
    }
}