public class AdditionofTwoNumber {
    public static void getNum(){
        List<Account> acc=[Select Id,Name From Account Where ID IN (Select AccountId From Contact)];
        
        for(Account var:acc){
            System.debug(var);
        }
    }

}