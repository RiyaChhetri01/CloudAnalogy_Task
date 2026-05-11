public class DecoratorDemo {
     @AuraEnabled(cacheable=true)
     public static list<Account> getaccount(){
         List<Account> acLIst=[SELECT ID,NAME FROM ACCOUNT];
         return acLIst;
        
    }
    

}