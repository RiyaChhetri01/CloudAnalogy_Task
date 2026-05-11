public class newDemoForAura {
     @AuraEnabled(cacheable=true)
    public static List<Account> main(){
        List<Account> acc=[SELECT ID,NAME FROM ACCOUNT];
        return acc;
        
    }

}