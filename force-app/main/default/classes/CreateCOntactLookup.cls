public class CreateCOntactLookup {
    public static void  makeContact(){
        List<Account> accList=new List<Account>();
            
            for(Integer i=1;i<=10;i++){
                Account acc=new Account();
                acc.Name='SampleTest'+i;
                
                accList.add(acc);
            }
            insert accList;
            
        
        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<accList.size();i++){
            Contact con=new Contact();
            con.FirstName='SampleTest'+i;
            con.LastName='Sample'+i;
            con.AccountId=accList[i].Id;
            
            conList.add(con);
            
                
        }
        insert conList;
            
            
        List<Contact> conlis=[SELECT Id,FirstName,LastName From Contact Where Name Like 'SampleTest%'];
        for(Contact co:conlis){
            System.debug(co);
        }
        
        
    }

}