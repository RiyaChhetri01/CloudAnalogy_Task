public class userdata {
    public static void main(){
        List<Account> userinfo=[SELECT ID ,NAME,OWNER.NAME FROM ACCOUNT WHERE OWNERID =:UserInfo.getUserId()];
        for(Account ac:userinfo){
            system.debug(ac.Name);
        }
    }

}