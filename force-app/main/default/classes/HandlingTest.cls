public class HandlingTest {
    public static void testinghandler(List<Account> newList){
        for(Account acc:newList){
            If (acc.Industry=='Media'){
                acc.Rating='Hot';
            }
        }   
    }
    public static void handleTesting(List<Account> newList,Map<Id,Account>oldMap){
        for(Account acc:newList){
            Account oldAcc=oldMap.get(acc.Id);
                If(acc.Industry=='Media' && oldAcc.Industry!='Media'){
                    acc.Rating='Hot';
                }
        }
    }

}