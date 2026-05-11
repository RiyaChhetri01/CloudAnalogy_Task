public class CreateFields {
    public static void accountCreate(){
        List<Account> acclist=new List<Account>(); 
        
        for(Integer i=1;i<=20;i++){
            Account acc=new Account();
            acc.Name='TestAccount'+i;
            acc.Phone='929394996'+i;
            acc.Rating='Hot';
            acc.Website='www.google.com';
            
            acclist.add(acc);
        }
        insert acclist;
        
                
                
        }
    }