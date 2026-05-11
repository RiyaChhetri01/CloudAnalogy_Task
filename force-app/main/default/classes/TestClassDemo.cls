@isTest
public class TestClassDemo {
    @isTest
    public static void testing(){
        List<Account> newList=new List<Account>();
        newList.add(new Account(Name='Riya',Industry='Media'));
        newList.add(new Account(Name='Isha',Industry='Banking'));
        Test.startTest();
        insert newList;
        Test.stopTest();
        
        List<Account>accList=[Select Name,Industry,Rating From Account Where Name In('Riya','Isha')];
        for(Account acc:accList){
            if(acc.Industry=='Media'){
                System.assertEquals('Hot',acc.Rating);
                
            }
            else{
                System.assertEquals(null,acc.Rating);
            }
        }
            
        
    }

}