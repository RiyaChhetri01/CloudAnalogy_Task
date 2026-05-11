public class FutureMethod {
    @future
    public static void UpdateRecord(){
        List<Account> accList=[Select id,Name,Rating From Account];
        for(Account ac:accList){
            ac.Rating='Hot';
        }
        update accList;
    }
    @future
    public static void  InsertRecord(){
        Account acc=new Account(Name='Riya',Rating='Cold');
        insert acc;
            
    }

}