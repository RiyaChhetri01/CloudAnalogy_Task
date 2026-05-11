public class AccountHandler {
    public static Account insertNewAccount(String accountName){
        try{
            Account newAcct=new Account(Name=accountName);
            insert newAcct;
            return newAcct;
        }
        catch(DmlException e){
            System.debug('A DML exception has occured: ' + e.getMessage());
            return null;
        }
    }

}