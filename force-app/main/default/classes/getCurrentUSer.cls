public class getCurrentUSer {
    public static List<Account> getAccount(){
        List<Account> accountList=[Select Name,Type From 
                                   Account Where OwnerID=:UserInfo.getUserid()];
        return accountList;
    }

}